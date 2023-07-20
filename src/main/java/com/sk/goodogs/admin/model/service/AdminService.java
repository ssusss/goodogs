package com.sk.goodogs.admin.model.service;

import static com.sk.goodogs.common.JdbcTemplate.*;
import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.sk.goodogs.admin.model.dao.AdminDao;
import com.sk.goodogs.admin.model.vo.Alarm;
import com.sk.goodogs.news.model.vo.NewsComment;
import com.sk.goodogs.news.model.vo.NewsImage;
import com.sk.goodogs.news.model.vo.NewsScript;
import com.sk.goodogs.news.model.vo.NewsScriptRejected;
import com.sk.goodogs.member.model.dao.MemberDao;
import com.sk.goodogs.member.model.vo.Member;


public class AdminService {
	private final  AdminDao adminDao = new AdminDao();
	private final  MemberDao memberDao = new MemberDao();


	
	public List<Member> memberFindAll() {
		//전체 맴버 리스트 조회 dql
		Connection conn= getConnection();
		
		List<Member> members=adminDao.memberFindAll(conn);
		close(conn);
		return members;
	}

	public List<Member> memberFindSelected(String searchType, String searchKeyword) {
		Connection conn = getConnection();
		
		List<Member> members=adminDao.memberFindSelected(searchType,searchKeyword,conn);
		close(conn);
		return members;
	}


	
	public List<NewsComment> findBanComment(int start, int end) {
		Connection conn = getConnection();
		 List<NewsComment> newsComments = adminDao.findBanComment(conn,start, end);
		close(conn);
		return newsComments;
	}


	public int roleUpdate(String memberRole, String memberId) {
		int result =0;
		Connection conn= getConnection();
		try{
			result= adminDao.roleUpdate(memberRole,memberId,conn);
			commit(conn);
		}catch (Exception e) {
			rollback(conn);
			throw e;
		}finally {
			close(conn);
		}
		return result;
	}
			

	public int BanUpdate(String memberId) {
		Connection conn = getConnection();
		int result = 0;
	
		try {
			result = adminDao.BanUpdate(conn, memberId );
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		}finally {
			close(conn);
		}

		return result;
	}
	

	public int getTotalContent() {
		Connection conn = getConnection();
		int totalContent = adminDao.getTotalContent(conn);
		close(conn);
		return totalContent;
	}

	public List<NewsScript> scriptFind(int scriptState) {
		Connection conn = getConnection();
		List<NewsScript> scripts= adminDao.scriptFind(scriptState,conn);
		close(conn);
		return scripts;
	}

	public List<NewsScript> scriptSerch(int scriptState, String searchTypeVal, String searchKeywordVal) {
		Connection conn = getConnection();
		List<NewsScript> scripts=adminDao.scriptSerch(scriptState,searchTypeVal,searchKeywordVal,conn);
		close(conn);
		
		return scripts;
	}

	public NewsScript findOneScript(int no) {
		NewsScript script=null;
		Connection conn= getConnection();
		script=adminDao.findOneScript(no,conn);
		close(conn);

		return script;
	}

	public int scriptUpdate(NewsScript script) {
		int result =0;
		Connection conn = getConnection();
		try {
			result= adminDao.scriptUpdate(script,conn);
			commit(conn);
		}catch (Exception e) {
			rollback(conn);
		}finally {
			close(conn);
		}
		return result;
	}

	public NewsScriptRejected findOneRejectedScript(int no) {
		 NewsScriptRejected rejectedScript=null;
		Connection conn = getConnection();
		rejectedScript=adminDao.findOneRejectedScript(no,conn );
		close(conn);
		
		return rejectedScript;
	}

	public int insertAlarm(Map<String, Object> payload) {
		int result=0;
		Connection conn= getConnection();
		try {
			result=adminDao.insertAlarm(payload,conn);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		}finally {
			close(conn);
		}
		return result;
	}

	public List<Alarm> checkById(String memberId) {
		List<Alarm> alarms= null;
		Connection conn= getConnection();
		
		alarms=adminDao.checkById(conn,memberId);
		close(conn);
		
		return alarms;
	}

	public int alarmUpdate(String memberId) {
		int result=0;
		Connection conn = getConnection();
		
		try {
		 result=adminDao.alarmUpdate(memberId,conn);
		 commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		}finally {
			close(conn);
		}
		
		return result;
	}

	public int addRejextReason(int no, String rejectReason) {
		int result=0;
		Connection conn =getConnection();
		
		try{
			result=adminDao.addRejextReason(no,rejectReason,conn);
			commit(conn);
		}catch (Exception e) {
			rollback(conn);
			throw e;
		}finally {
			close(conn);
		}
		
		return result;
	}
	
	public NewsImage findImageByNo(int no) {
		NewsImage image = null;
		Connection conn= getConnection();
		image = adminDao.findImageByNo(no,conn);
		close(conn);

		return image;
	}
		


}
