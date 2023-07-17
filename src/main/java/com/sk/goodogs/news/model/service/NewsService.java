package com.sk.goodogs.news.model.service;

import static com.sk.goodogs.common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;

import com.sk.goodogs.member.model.vo.Member;
import com.sk.goodogs.news.model.dao.NewsDao;
import com.sk.goodogs.news.model.vo.News;
import com.sk.goodogs.news.model.vo.NewsAndImage;
import com.sk.goodogs.news.model.vo.NewsImage;
import com.sk.goodogs.news.model.vo.NewsScript;

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
	 */

	public List<News> findAllNewsById(Member loginMember) {
		Connection conn = getConnection();
		List<News> newsList = newsDao.findAllNewsById(conn, loginMember);
		System.out.println(conn);
		close(conn);
		return newsList;
		
	}
	public List<NewsScript> findAllScriptById(Member loginMember) {
		Connection conn = getConnection();
		List<NewsScript> scripts = newsDao.findAllScriptById(conn, loginMember);
		close(conn);
		return scripts;
	}
	public int newsScriptSubmit(NewsScript newNewsScript) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = newsDao.newsScriptSubmit(conn, newNewsScript);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}
	public int newsScriptTempSave(NewsScript tempNewsScript) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = newsDao.newsScriptTempSave(conn, tempNewsScript);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}
	
	public int scriptDelete(int scriptNo) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = newsDao.scriptDelete(scriptNo, conn);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		}finally {
			close(conn);
		}
		return result;
		
		
	}
	public NewsScript findByScriptNo(int scriptNo) {
		Connection conn = getConnection();
		NewsScript newsScript = newsDao.findByScriptNo(conn, scriptNo);
		close(conn);
		return newsScript;
	}
	
	/***
	 * @author 이혜령
	 * 메인메뉴 페이지 구현
	 */
	public int getTotalContent() {
		Connection conn = getConnection();
		int totalContent = newsDao.getTotalContent(conn);
		close(conn);
		return totalContent;
	}
	
	
	public List<NewsAndImage> findNews(int start, int end) {
		Connection conn = getConnection();
		List<NewsAndImage> newsAndImages = newsDao.findNews(conn, start, end);
		close(conn);
		return newsAndImages;
	}
	public int getLastScriptNo() {
		int lastScriptNo = 0;
		Connection conn = getConnection();
		try {
			lastScriptNo = newsDao.getLastScriptNo(conn);
			commit(conn);
		}catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		
		
		return lastScriptNo;
	}
	public int insertnewsImage(NewsImage newsImage_) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = newsDao.insertnewsImage(conn, newsImage_);
			commit(conn);
		}catch (Exception e) {
			rollback(conn);
			throw e;
		}finally {
			close(conn);
		}
		
		return result;
	}
	public NewsImage findAllImage(int newsNo) {
		Connection conn = getConnection();
		NewsImage newsImage = newsDao.findAllImage(conn, newsNo);
		close(conn);
		return newsImage;
	}
	
	
}
