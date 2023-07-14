package com.sk.goodogs.admin.model.service;

import static com.sk.goodogs.common.JdbcTemplate.*;
import java.sql.Connection;
import java.util.List;
import com.sk.goodogs.admin.model.dao.AdminDao;
import com.sk.goodogs.news.model.vo.NewsComment;
import com.sk.goodogs.member.model.dao.MemberDao;
import com.sk.goodogs.member.model.vo.Member;


public class AdminService {
	private final AdminDao adminDao = new AdminDao();

	
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
		result= adminDao.roleUpdate(memberRole,memberId,conn);
		commit(conn);
		try{
			
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
		


}
