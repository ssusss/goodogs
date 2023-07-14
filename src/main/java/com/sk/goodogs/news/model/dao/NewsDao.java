package com.sk.goodogs.news.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.script.ScriptException;

import static com.sk.goodogs.common.JdbcTemplate.*;
import com.sk.goodogs.member.model.vo.Member;
import com.sk.goodogs.news.model.exception.NewsException;
import com.sk.goodogs.news.model.vo.News;
import com.sk.goodogs.news.model.vo.NewsScript;

/**
 * @author 김준한
 *
 */
public class NewsDao {
	private Properties prop = new Properties();

	public NewsDao() {
		String filename =
				NewsDao.class.getResource("/news/news-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		}catch(IOException e) {
			e.printStackTrace();
		}
	}
	
	public List<News> findAllNewsById(Connection conn, Member loginMember) {
		List<News> newsList = new ArrayList<>();
		String sql = prop.getProperty("findAllNewsById");
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, loginMember.getMemberId());
			try(ResultSet rset = pstmt.executeQuery()) {
				while(rset.next()) {
					News news = handleNewsResultSet(rset);
					
					newsList.add(news);
					}
				}
			} catch (SQLException e) {
				throw new NewsException(e);
			}
			System.out.println(loginMember);
			return newsList;
			}
		
		private News handleNewsResultSet(ResultSet rset) throws SQLException {
			int newsNo = rset.getInt("news_no");
			String newsWriter = rset.getString("news_writer");
			String newsTitle = rset.getString("news_title");
			String newsCategory = rset.getString("news_category");
			String newsContent = rset.getString("news_content");
			Date newsWriteDate = rset.getDate("news_write_date");
			String newsTag = rset.getString("news_tag");
			int newsLikeCnt = rset.getInt("news_like_cnt");
			int newsReadCnt = rset.getInt("news_read_cnt");
			Date newsConfirmedDate = rset.getDate("news_confirmed_date");
			
			return new News(newsNo, newsWriter, newsTitle, newsCategory, newsContent, newsWriteDate, newsTag, newsLikeCnt, newsReadCnt, newsConfirmedDate);
		}

		public List<NewsScript> findAllScriptById(Connection conn, Member loginMember) {
			List<NewsScript> scripts = new ArrayList<>();
			String sql = prop.getProperty("findAllScriptById");
			try(PreparedStatement pstmt = conn.prepareStatement(sql)){
				pstmt.setString(1, loginMember.getMemberId());
				try(ResultSet rset = pstmt.executeQuery()) {
					while(rset.next()) {
						NewsScript script = handleScriptResultSet(rset);
						
						scripts.add(script);
						}
					}
			} catch (SQLException e) {
				throw new NewsException(e);
			} 
			
			return scripts;
		}

		private NewsScript handleScriptResultSet(ResultSet rset) throws SQLException{
			int scriptNo = rset.getInt("script_no");
			String scriptWriter = rset.getString("script_writer");
			String scriptTitle = rset.getString("script_title");
			String scriptCategory = rset.getString("script_category");
			String scriptContent = rset.getString("script_content");
			Date scriptWriteDate = rset.getDate("script_write_date");
			String scriptTag = rset.getString("script_tag");
			int scriptState = rset.getInt("script_state");
			NewsScript newsScript = new NewsScript(scriptNo, scriptWriter, scriptTitle, scriptCategory, scriptContent, scriptWriteDate, scriptTag, scriptState);
			
			return newsScript;
		}

		public int newsScriptSubmit(Connection conn, NewsScript newNewsScript) {
			int result = 0;
			String sql = prop.getProperty("newsScriptSubmit");
			try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
				pstmt.setString(1, newNewsScript.getScriptWriter());
				pstmt.setString(2, newNewsScript.getScriptTitle());
				pstmt.setString(3, newNewsScript.getScriptCategory());
				pstmt.setString(4, newNewsScript.getScriptContent());
				pstmt.setString(5, newNewsScript.getScriptTag());
				result = pstmt.executeUpdate();
			} catch (SQLException e) {
				throw new NewsException(e);
			}
			
			return result;
		}

		public int newsScriptTempSave(Connection conn, NewsScript tempNewsScript) {
			int result = 0;
			String sql = prop.getProperty("tempNewsScript");
			try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
				pstmt.setString(1, tempNewsScript.getScriptWriter());
				pstmt.setString(2, tempNewsScript.getScriptTitle());
				pstmt.setString(3, tempNewsScript.getScriptCategory());
				pstmt.setString(4, tempNewsScript.getScriptContent());
				pstmt.setString(5, tempNewsScript.getScriptTag());
				result = pstmt.executeUpdate();
			} catch (SQLException e) {
				throw new NewsException(e);
			}
			
			return result;
		}

		

		public int scriptDelete(int scriptNo, Connection conn) {
			int result = 0;
			String sql = prop.getProperty("scriptDelete");
			try(PreparedStatement pstmt = conn.prepareStatement(sql)){
				pstmt.setInt(1,scriptNo);
				result = pstmt.executeUpdate();
			}catch (SQLException e) {
				throw new NewsException(e);
			}
			return result;
		}

		public NewsScript findByScriptNo(Connection conn, int scriptNo) {
			NewsScript newsScript = null;
			String sql = prop.getProperty("findByScriptNo");
			try(PreparedStatement pstmt = conn.prepareStatement(sql)){
				pstmt.setInt(1, scriptNo);
				try(ResultSet rset = pstmt.executeQuery()){
					while(rset.next()) {
						int scriptNo_ = rset.getInt("script_no");
						String scriptWriter = rset.getString("script_writer");
						String scriptTitle = rset.getString("script_title");
						String scriptCategory = rset.getString("script_category");
						String scriptContent = rset.getString("script_content");
						Date scriptWriteDate = rset.getDate("script_write_date");
						String scriptTag = rset.getString("script_tag");
						int scriptState = rset.getInt("script_state");
						newsScript = new NewsScript(scriptNo_, scriptWriter, scriptTitle, scriptCategory, scriptContent, scriptWriteDate, scriptTag, scriptState);
					}
				}
			} catch (SQLException e) {
				throw new NewsException(e);
			}
			
			return newsScript;
		}

		/***
		 * @author 이혜령
		 * 메인메뉴 페이지 구현
		 */
		public int getTotalContent(Connection conn) {
			int totalContent = 0;
			String sql = prop.getProperty("getTotalContent");
			try (PreparedStatement pstmt = conn.prepareStatement(sql)){
				try (ResultSet rset = pstmt.executeQuery()) {
					if(rset.next())
						totalContent = rset.getInt(1);
				}
			} catch (SQLException e) {
				throw new NewsException(e);
			}
			return totalContent;
		}
		
		
		public List<News> findNews(Connection conn, int start, int end) {
			List<News> news = new ArrayList<>();
			String sql = prop.getProperty("findNews");
			try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				
				try(ResultSet rset = pstmt.executeQuery()) {
					while(rset.next())
						news.add(handleNewsResultSet(rset));
				}
				
			} catch (SQLException e) {
				throw new NewsException(e);
			}
			return news;
		}
}
