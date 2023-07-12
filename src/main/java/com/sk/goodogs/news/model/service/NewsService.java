package com.sk.goodogs.news.model.service;

import static com.sk.goodogs.common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;

import com.sk.goodogs.news.model.dao.NewsDao;
import com.sk.goodogs.news.model.vo.News;

public class NewsService {
	public final NewsDao newsDao = new NewsDao();
	/**
	 * DQL
	 * 1. Connection 생성
	 * 2. PrepareStatement 생성 및 ? 값대입
	 * 3. 실행 및 ResultSet처리
	 * 4. 자원반납
	 * 
	 * DML
	 * 1. Connection 생성 (setAutoCommit : false)
	 * 2. PrepareStatement 생성 및 ? 값대입
	 * 3. 실행 및 int 반환
	 * 4. 트랜잭션 (commit/rollback)
	 * 5. 자원반납
	 * 
	 */

	public List<News> findAll(String memberId) {
		Connection conn = getConnection();
		List<News> newsList = newsDao.findAll(conn, memberId);
		System.out.println(conn);
		close(conn);
		return newsList;
		
	}
	
}
