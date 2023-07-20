package com.sk.goodogs.admin.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;


import com.sk.goodogs.news.model.vo.NewsComment;
import com.sk.goodogs.news.model.vo.NewsScript;
import com.sk.goodogs.news.model.vo.NewsScriptRejected;

import javax.naming.spi.DirStateFactory.Result;
import static com.sk.goodogs.common.JdbcTemplate.*;
import com.sk.goodogs.admin.model.exception.AdminException;
import com.sk.goodogs.admin.model.exception.AdminScriptException;
import com.sk.goodogs.admin.model.vo.Alarm;
import com.sk.goodogs.member.model.exception.MemberException;
import com.sk.goodogs.member.model.vo.Gender;
import com.sk.goodogs.member.model.vo.Member;
import com.sk.goodogs.member.model.vo.MemberRole;


public class AdminDao {
	private Properties prop = new Properties();
	
	public AdminDao() {
		String filename = 
				AdminDao.class.getResource("/admin/admin-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}


	
// 벤용 ----------------------------------------
	

	public List<NewsComment> findBanComment(Connection conn, int start, int end) {
		List<NewsComment> newsComments = new ArrayList<>();
		String sql = prop.getProperty("findBanComment");
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
					
			try(ResultSet rset = pstmt.executeQuery()) {
				while(rset.next()) {
					NewsComment newsComment  =  handleCommentrResultSet(rset);
					newsComments.add(newsComment);
				}
			}
		} catch (Exception e) {
			throw new  AdminException(e);
		}
			return newsComments;
	}

	public int BanUpdate(Connection conn, String memberId) {
		int result = 0;
		
		String sql=prop.getProperty("banMember");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, memberId);
			System.out.println(memberId);
			result = pstmt.executeUpdate(); 
			
		} catch (SQLException e) {
			throw new  AdminException(e);
		}

		return result;
	}

private NewsComment handleCommentrResultSet(ResultSet rset) throws SQLException {
	 int commentNo = rset.getInt("comment_no");
	 int newsCommentLevel  = rset.getInt("news_comment_level");
	 int newsNo  = rset.getInt("news_no");
	 String newsCommentWriter = rset.getString("news_comment_writer");
	 int  commentNoRef  = rset.getInt("comment_no_ref");
	 String newsCommentNickname  = rset.getString("news_comment_nickname");
	String  newsCommentContent  = rset.getString("news_comment_content");
	Timestamp commentRegDate  = rset.getTimestamp("comment_reg_date");
	 int newsCommentReportCnt  = rset.getInt("news_comment_report_cnt");
	 int commentState  = rset.getInt("comment_state");

	return new NewsComment( commentNo, newsCommentLevel,newsNo, newsCommentWriter, commentNoRef,
			 newsCommentNickname,  newsCommentContent,commentRegDate, newsCommentReportCnt, commentState);
	
}


	public List<Member> memberFindAll(Connection conn) {
		List<Member> members= new ArrayList<>();
		String sql=prop.getProperty("memberFindAll");
		
		try(
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rset = pstmt.executeQuery();
			){
				while (rset.next()) {
					Member member = handleMemberResultSet(rset);
					members.add(member);
			}
		}catch (SQLException e) {
			throw new  AdminException(e);
		}
		
		return members;
	}

private Member handleMemberResultSet(ResultSet rset) throws SQLException{
		String memberId= rset.getString("member_id");
		String password= rset.getString("password");
		String nickname= rset.getString("nickname");
		String phone= rset.getString("phone");
		
		Gender gender= null;
		if(rset.getString("gender")!=null)
			gender=Gender.valueOf(rset.getString("gender"));
		MemberRole memberRole= null;
		if(rset.getString("member_role")!=null)
			memberRole=MemberRole.valueOf(rset.getString("member_role"));
		 
		
		Timestamp enrollDate= rset.getTimestamp("enroll_date");
		String memberProfile = rset.getString("member_profile");
		int isBanned =rset.getInt("is_banned");
		
		Member member = new Member(memberId, password, nickname, phone, gender, memberRole, enrollDate, memberProfile, isBanned);
				
		return member;
	}



public List<Member> memberFindSelected(String searchType, String searchKeyword, Connection conn) {
		List<Member> members = new ArrayList<>();
		String sql=prop.getProperty("memberFindSelected");
		sql=sql.replace("#",searchType);
		System.out.println("check sql ="+ sql);
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, "%"+searchKeyword+"%");
			try(ResultSet rset = pstmt.executeQuery()){
				while(rset.next()) {
					Member member=handleMemberResultSet(rset);
					members.add(member);
				}
			}
		} catch (SQLException e) {
			throw new MemberException(e);
		}
	return members;
}




public int roleUpdate(String memberRole, String memberId, Connection conn) {
	int result=0;
	String sql=prop.getProperty("roleUpdate");
	try(PreparedStatement pstmt=conn.prepareStatement(sql)){
		pstmt.setString(1, memberRole);
		pstmt.setString(2, memberId);
		
		result=pstmt.executeUpdate();
	}catch (SQLException e) {
		throw new MemberException(e);
	}
	
	return result;
}



public int getTotalContent(Connection conn) {
	
	int totalContent = 0;
	String sql = prop.getProperty("getTotalContent"); // select count(*) from board
	
	try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
		try (ResultSet rset = pstmt.executeQuery()) {
			while(rset.next())
				totalContent = rset.getInt(1);
		}
	} catch (SQLException e) {
		throw new AdminException(e);
	}
	return totalContent;
}



public List<NewsScript> scriptFind(int scriptState, Connection conn) {
	List<NewsScript> scripts= new ArrayList<>();
	String sql=prop.getProperty("scriptFind");
	try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
		pstmt.setInt(1, scriptState);
		try(ResultSet rset=pstmt.executeQuery()){
			while(rset.next()) {
				NewsScript script=handleScriptResultSet(rset);
				scripts.add(script);
			}
		}
	} catch (SQLException e) {
		throw new AdminException(e);
	}
	return scripts;
}



private NewsScript handleScriptResultSet(ResultSet rset) throws SQLException{
	
	int scriptNo =rset.getInt("script_no");
	String scriptWriter=rset.getString("script_writer");
	String scriptTitle=rset.getString("script_title");
	String scriptCategory=rset.getString("script_category");
	String scriptContent=rset.getString("script_content");
	Timestamp scriptWriteDate=rset.getTimestamp("script_write_date");
	String scriptTag=rset.getString("script_tag");
	int scriptState=rset.getInt("script_state");
	
	NewsScript script=new NewsScript(scriptNo, scriptWriter, scriptTitle, scriptCategory, scriptContent, scriptWriteDate, scriptTag, scriptState);
	return script;
}



public List<NewsScript> scriptSerch(int scriptState, String searchTypeVal, String searchKeywordVal, Connection conn) {
	List<NewsScript> scripts= new ArrayList<>();
	String sql=prop.getProperty("scriptSerch");
	sql=sql.replace("#",searchTypeVal);
	System.out.println(sql);
	
	try(PreparedStatement pstmt= conn.prepareStatement(sql)){
		pstmt.setString(1, "%"+searchKeywordVal+"%");
		pstmt.setInt(2, scriptState);
		try(ResultSet rset=pstmt.executeQuery()){
			while(rset.next()) {
				NewsScript script=handleScriptResultSet(rset);
				scripts.add(script);
			}
		}
	} catch (SQLException e) {
		throw new AdminException(e);
	}
	
	return scripts;
}



public NewsScript findOneScript(int no, Connection conn) {
	NewsScript script=null;
	String sql=prop.getProperty("findOneScript");
	
	try(PreparedStatement pstmt= conn.prepareStatement(sql)) {
		pstmt.setInt(1, no);
		try(ResultSet rset=pstmt.executeQuery()){
			while(rset.next()) {
				script=handleScriptResultSet(rset);
			}
		}
	} catch (SQLException e) {
		throw new AdminException(e);
	}
	
	return script;
}



public int scriptUpdate(NewsScript script, Connection conn) {
	int result=0;
	String sql=prop.getProperty("scriptUpdate");
	
	try(PreparedStatement pstmt=conn.prepareStatement(sql)){
			pstmt.setInt(1,script.getScriptState());
			pstmt.setInt(2,script.getScriptNo());
			
			result = pstmt.executeUpdate(); 
	} catch (SQLException e) {
		throw new AdminException(e);
	}
	
	return result;
}



public NewsScriptRejected findOneRejectedScript(int no, Connection conn) {
	NewsScriptRejected rejectedScript=null;
	String sql=prop.getProperty("findOneRejectedScript");
	
	try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
		pstmt.setInt(1,no);
		try(ResultSet rset=pstmt.executeQuery()){
			while(rset.next()) {
				rejectedScript=handleRejectedScriptResultSet(rset);
			}
		}
	} catch (SQLException e) {
		throw new AdminException(e);
	}
	
	return rejectedScript;
}



private NewsScriptRejected handleRejectedScriptResultSet(ResultSet rset) throws SQLException{
	
	NewsScriptRejected scriptRejected = new NewsScriptRejected();
	
	scriptRejected.setRejectedNo(rset.getInt("script_rejected_no"));
	scriptRejected.setScriptNo(rset.getInt("script_no"));
	scriptRejected.setScriptWriter(rset.getString("script_writer"));
	scriptRejected.setScriptTitle(rset.getString("script_title"));
	scriptRejected.setScriptCategory(rset.getString("script_category"));
	scriptRejected.setScriptContent(rset.getString("script_content"));
	scriptRejected.setScriptWriteDate(rset.getTimestamp("script_write_date"));
	scriptRejected.setScriptTag(rset.getString("script_tag"));
	scriptRejected.setRejectedReson(rset.getString("script_rejected_reason").trim());

	return scriptRejected;
}



public int insertAlarm(Map<String, Object> payload, Connection conn) {
	int result=0;
	String sql=prop.getProperty("insertAlarm");
	
	System.out.println((String)payload.get("messageType"));
	System.out.println(Integer.parseInt((String) payload.get("no")));
	System.out.println((String)payload.get("comemt"));
	System.out.println((String)payload.get("receiver"));
	
	try(PreparedStatement pstmt=conn.prepareStatement(sql)){
		pstmt.setString(1,(String)payload.get("messageType"));
		pstmt.setInt(2,Integer.parseInt((String) payload.get("no")));
		pstmt.setString(3,(String)payload.get("comemt"));
		pstmt.setString(4,(String)payload.get("receiver"));
		
		result = pstmt.executeUpdate(); 
	}catch (Exception e) {
		throw new AdminException(e);
	}
	
	return result;
}



public List<Alarm> checkById(Connection conn, String memberId) {
	List<Alarm> alarms= new ArrayList<>();
	String sql=prop.getProperty("checkById");
	try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
		pstmt.setString(1, memberId);
		try(ResultSet rset=pstmt.executeQuery()){
			while(rset.next()) {
				Alarm alarm= handleAlarm(rset);
				alarms.add(alarm);
			}
		}
	} catch (SQLException e) {
		throw new AdminException(e);
	}

	return alarms;
}



private Alarm handleAlarm(ResultSet rset) throws SQLException {
	int no= rset.getInt("alarm_no");
	String messageType= rset.getString("alarm_message_type");
	int scriptNo= rset.getInt("alarm_script_no");
	String comment= rset.getString("alarm_comment");
	String receiver= rset.getString("alarm_receiver");
	int hasRead= rset.getInt("alarm_hasread");
	
	Alarm alarm= new Alarm(no, messageType, scriptNo, comment, receiver, hasRead, null);
	
	return alarm;
}



public int alarmUpdate(String memberId, Connection conn) {
	int result =0;
	String sql= prop.getProperty("alarmUpdate");
	
	try(PreparedStatement pstmt= conn.prepareStatement(sql)){
		pstmt.setString(1, memberId);
		
		result = pstmt.executeUpdate(); 
	} catch (SQLException e) {
		throw new AdminException();
	}
	return result;
}



public int addRejextReason(int no, String rejectReason, Connection conn) {
	int result=0;
	String sql=prop.getProperty("addRejextReason");
	try(PreparedStatement pstmt = conn.prepareStatement(sql)){
		pstmt.setString(1, rejectReason);
		pstmt.setInt(2, no);
		
		result=pstmt.executeUpdate();
	} catch (SQLException e) {
		throw new AdminException(e);
	}
	return result;
}


	
}
