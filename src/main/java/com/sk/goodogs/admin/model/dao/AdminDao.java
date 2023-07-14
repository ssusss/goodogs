package com.sk.goodogs.admin.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;


import com.sk.goodogs.news.model.vo.NewsComment;
import javax.naming.spi.DirStateFactory.Result;
import static com.sk.goodogs.common.JdbcTemplate.*;
import com.sk.goodogs.admin.model.exception.AdminException;
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
	 Date commentRegDate  = rset.getDate("comment_reg_date");
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
		 
		
		Date enrollDate= rset.getDate("enroll_date");
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
			throw new MemberException();
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


	
}
