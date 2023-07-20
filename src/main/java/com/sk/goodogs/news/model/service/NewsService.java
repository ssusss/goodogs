package com.sk.goodogs.news.model.service;

import static com.sk.goodogs.common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.sk.goodogs.member.model.vo.Member;
import com.sk.goodogs.news.model.dao.NewsDao;
import com.sk.goodogs.news.model.exception.NewsException;
import com.sk.goodogs.news.model.vo.News;
import com.sk.goodogs.news.model.vo.NewsComment;
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
			int ScriptNo=newsDao.findScriptNo(conn);
			newNewsScript.setScriptNo(ScriptNo);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw new NewsException(e);
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

	public int getContentByCategory(String category) {
		Connection conn = getConnection();
		int categoryContent = newsDao.getContentByCategory(conn, category);
		close(conn);
		return categoryContent;
	}
	public List<NewsAndImage> findNewsByCategory(int start, int end, String category) {
		Connection conn = getConnection();
		List<NewsAndImage> newsAndImages = newsDao.findNewsByCategory(conn, start, end, category);
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

	public News findNewsByNewsNo(int newsNo) {
		Connection conn = getConnection();
		News news = newsDao.findNewsByNewsNo(conn, newsNo);
		return news;
	}
	public List<News> findByNewsName(String term) {
		Connection conn = getConnection();
		List<News> newsnames = newsDao.findAllNewsName(conn);
		List<News> results = new ArrayList<>();
		for(News news: newsnames) {
			if(news.getNewsTitle().indexOf(term)> -1) {
				results.add(news);
			}
		}
		return results;
	}
	
	//----------
	
	
	public int newCommentInsert(NewsComment newsComment) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = newsDao.newCommentInsert(conn, newsComment);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}
	
	
	
	public List<NewsComment> findNewsComment(int no) {
		Connection conn = getConnection();
		List<NewsComment> newsComments = newsDao.findNewsComment(conn, no);
		close(conn);
		return newsComments;
	}
	
	
	// 뉴스
		public  NewsAndImage newsDetail(int No) {
			Connection conn = getConnection();
			NewsAndImage newsAndImage = newsDao.NewsDetail(conn,No);
			close(conn);
			return newsAndImage;
		}


	
	// 댓글 삭제 ( 업데이트 )
		public int NewsCommentDelete(int commentNo, int commentState) {
			int result = 0;
			Connection conn = getConnection();
			try {
				result = newsDao.NewsCommentDelete(commentNo,commentState, conn);
				commit(conn);
			} catch (Exception e) {
				rollback(conn);
				throw e;
			}finally {
				close(conn);
			}
			return result;
		}

		public int newsLikeUpdate(int newsNo) {
			int result = 0;
			Connection conn = getConnection();
			try {
				result = newsDao.newsLikeUpdate(newsNo, conn);
				commit(conn);
			} catch (Exception e) {
				rollback(conn);
				throw e;
			}finally {
				close(conn);
			}
			return result;
		}
	
		// 뉴스 삭제 
		public int NewsAdminDelete(int newsno) {
			Connection conn = getConnection();
			int result = 0;
			try {
				result = newsDao.NewsAdminDelete(conn, newsno);
				commit(conn);
			} catch (Exception e) {
				rollback(conn);
				throw e;
			} finally {
				close(conn);
			}
			return result;
		}

		public List<News> findNewsRanking() {
			Connection conn = getConnection();
			List<News> news = newsDao.findNewsRanking(conn);
			close(conn);
			return news;

		}
		
		public List<News> searchNewsByTitle(String title) {
			Connection conn = getConnection();
			
			List<News> newsList = newsDao.searchNewsByTitle(conn, title);
			close(conn);
			return newsList;
		}

		
		// 신고여부 체크
		public int checkReport(String memberId, int commentNo) {
			Connection conn = getConnection();
			int result = newsDao.checkReport(conn, memberId, commentNo);
			close(conn);
			return result;
		}
		
		// 신고 체크
		public int updateReport(String memberId, int commentNo) {
			int result =0;
			Connection conn = getConnection();
			try {
				result = newsDao.updateReport(conn,  memberId,commentNo );
				commit(conn);
			}catch (Exception e) {
				rollback(conn);
			} finally {
				close(conn);			
			}
			return result;
		}
		

		public List<NewsAndImage> findNewsByKeyword(int start, int end, String keyword) {
			Connection conn = getConnection();
			List<NewsAndImage> newsAndImages = newsDao.findNewsByKeyword(conn, start, end, keyword);
			close(conn);
			return newsAndImages;
		}
	

	
}
