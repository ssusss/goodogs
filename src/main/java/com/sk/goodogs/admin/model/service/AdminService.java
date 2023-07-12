package com.sk.goodogs.admin.model.service;

import static com.sk.goodogs.common.JdbcTemplate.*;
import java.sql.Connection;
import java.util.List;
import com.sk.goodogs.admin.model.dao.AdminDao;
import com.sk.goodogs.news.model.vo.NewsComment;
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
		
		return null;
	}


	
// <Ban> ----------------------------------------
	
	public List<NewsComment> findBanComment() {
		Connection conn = getConnection();
		 List<NewsComment> newsComments = adminDao.findBenComment(conn);
		close(conn);
		return newsComments;
	}
		
// ---------------------------------------

}
