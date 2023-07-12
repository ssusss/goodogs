package com.sk.goodogs.admin.model.service;

import static com.sk.goodogs.common.JdbcTemplate.*;
import java.sql.Connection;
import java.util.List;

import com.sk.goodogs.admin.model.dao.AdminDao;
import com.sk.goodogs.news.model.vo.NewsComment;

public class AdminService {
	private final AdminDao adminDao = new AdminDao();



	
// <Ban> ----------------------------------------
	
	public List<NewsComment> findBanComment() {
		Connection conn = getConnection();
		 List<NewsComment> newsComments = adminDao.findBenComment(conn);
		close(conn);
		return newsComments;
	}
		
// ---------------------------------------

}
