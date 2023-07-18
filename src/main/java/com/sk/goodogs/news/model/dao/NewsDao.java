package com.sk.goodogs.news.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.script.ScriptException;

import static com.sk.goodogs.common.JdbcTemplate.*;
import com.sk.goodogs.member.model.vo.Member;
import com.sk.goodogs.news.model.exception.NewsException;
import com.sk.goodogs.news.model.vo.News;
import com.sk.goodogs.news.model.vo.NewsComment;
import com.sk.goodogs.news.model.vo.NewsAndImage;
import com.sk.goodogs.news.model.vo.NewsImage;
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
			Timestamp newsWriteDate = rset.getTimestamp("news_write_date");
			String newsTag = rset.getString("news_tag");
			int newsLikeCnt = rset.getInt("news_like_cnt");
			int newsReadCnt = rset.getInt("news_read_cnt");
			Timestamp newsConfirmedDate = rset.getTimestamp("news_confirmed_date");
			
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
			Timestamp scriptWriteDate = rset.getTimestamp("script_write_date");
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
						Timestamp scriptWriteDate = rset.getTimestamp("script_write_date");
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
		
		
		public List<NewsAndImage> findNews(Connection conn, int start, int end) {
			List<NewsAndImage> newsAndImages = new ArrayList<>();
			String sql = prop.getProperty("findNews");
			try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				
				try(ResultSet rset = pstmt.executeQuery()) {
					while(rset.next())
						newsAndImages.add(handleNewsAndImageResultSet(rset));
				}
				
			} catch (SQLException e) {
				throw new NewsException(e);
			}
			return newsAndImages;
		}

		private NewsAndImage handleNewsAndImageResultSet(ResultSet rset) throws SQLException {
		    int newsNo = rset.getInt("news_no");
		    String newsWriter = rset.getString("news_writer");
		    String newsTitle = rset.getString("news_title");
		    String newsCategory = rset.getString("news_category");
		    String newsContent = rset.getString("news_content");
		    Timestamp newsWriteDate = rset.getTimestamp("news_write_date");
		    String newsTag = rset.getString("news_tag");
		    int newsLikeCnt = rset.getInt("news_like_cnt");
		    int newsReadCnt = rset.getInt("news_read_cnt");
		    Timestamp newsConfirmedDate = rset.getTimestamp("news_confirmed_date");
		    String renamedFilename = rset.getString("renamed_filename");

		    return new NewsAndImage(newsNo, newsWriter, newsTitle, newsCategory, newsContent, newsWriteDate, newsTag, newsLikeCnt, newsReadCnt, newsConfirmedDate, renamedFilename);
		}


		public int getContentByCategory(Connection conn, String category) {
			int categoryContent = 0;
			String sql = prop.getProperty("getContentByCategory");
			try (PreparedStatement pstmt = conn.prepareStatement(sql)){
				pstmt.setString(1, category);
				try (ResultSet rset = pstmt.executeQuery()) {
					if(rset.next())
						categoryContent = rset.getInt(1);
				}
			} catch (SQLException e) {
				throw new NewsException(e);
			}
			return categoryContent;
		}

		public List<News> findNewsByCategory(Connection conn, int start, int end, String category) {
			List<News> news = new ArrayList<>();
			String sql = prop.getProperty("findNewsByCategory");
			try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
				pstmt.setString(1, category);
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
				
				try(ResultSet rset = pstmt.executeQuery()) {
					while(rset.next())
						news.add(handleNewsResultSet(rset));
				}
				
			} catch (SQLException e) {
				throw new NewsException(e);
			}
			return news;
		}


		public int getLastScriptNo(Connection conn) {
			int lastScriptNo = 0;
			String sql = prop.getProperty("getLastScriptNo");
			try (
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rset = pstmt.executeQuery();
			){
				if(rset.next())
					lastScriptNo = rset.getInt(1);
			} catch (Exception e) {
				throw new NewsException(e);
			}
			
			
			return lastScriptNo;
		}

		public int insertnewsImage(Connection conn, NewsImage newsImage_) {
			int result = 0;
			String sql = prop.getProperty("insertnewsImage");
			try (
				PreparedStatement pstmt = conn.prepareStatement(sql)){
				pstmt.setInt(1, newsImage_.getScriptNo());
				pstmt.setString(2, newsImage_.getOriginalFilename());
				pstmt.setString(3, newsImage_.getRenamedFilename());
				
				result = pstmt.executeUpdate();
				
			} catch (Exception e) {
				throw new NewsException(e);
			}
			
			return result;
		}


		/**
		 * @author 전수경
		 *  - 뉴스번호로 뉴스 조회하기
		 *  - LikeList에서 newsTitle 설정용
		 */
		public News findNewsByNewsNo(Connection conn, int newsNo) {
			News news = null;
			String sql = prop.getProperty("findNewsByNewsNo");
			// select * from news where news_no = ?
			try(PreparedStatement pstmt = conn.prepareStatement(sql)){
				pstmt.setInt(1, newsNo);
				
				try(ResultSet rset = pstmt.executeQuery()){
					while(rset.next()) {
						news = handleNewsResultSet(rset);
					}
				}
			} catch (SQLException e) {
				throw new NewsException(e);
			}
			return news;
		}

		public List<News> findAllNewsName(Connection conn) {
			List<News> newsnames = new ArrayList<>();
			String sql = prop.getProperty("findAllNewsName");
			try(
				PreparedStatement pstmt = conn.prepareStatement(sql)) {
				try(ResultSet rset = pstmt.executeQuery()){
					while(rset.next()) {
						newsnames.add(handleNewsResultSet(rset));
					}
				}
			} catch (Exception e) {
				throw new NewsException(e);
			}
			
			
			
			return newsnames;
		}
		
		//----------
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

			return new NewsComment(
					commentNo,newsCommentLevel,newsNo,newsCommentWriter,commentNoRef,
					newsCommentNickname,newsCommentContent,commentRegDate,newsCommentReportCnt,commentState
					);
			
		}
		// 댓글 인서트 
				public int newCommentInsert(Connection conn, NewsComment newsComment) {
					int result = 0;
					
					// 
					String sql = prop.getProperty( "newsCommentInsert" );
					try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
				        pstmt.setInt(1, newsComment.getNewsNo());
				        pstmt.setInt(2, newsComment.getNewsCommentLevel());
				        pstmt.setString(3, newsComment.getNewsCommentWriter());
				        pstmt.setString(4, newsComment.getNewsCommentNickname());
				        pstmt.setString(5, newsComment.getNewsCommentContent());
				        
				        
				        //insert into news_comment values (seq_news_comment_no.NEXTVAL, ? , ? , ? , null , ? , ? , default, default, default)

				        result = pstmt.executeUpdate();
				    } catch (SQLException e) {
				        throw new NewsException(e);
				    }

				    return result;
				
				}

				public List<NewsComment> findNewsComment(Connection conn, int no) {
					List<NewsComment> newsComments = new ArrayList<>();
					String sql = prop.getProperty("findNewsComment");
					
					try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
						pstmt.setInt(1, no);
						try (ResultSet rset = pstmt.executeQuery()) {
							
							while(rset.next()) {
								NewsComment newsComment = handleCommentrResultSet(rset);
								newsComments.add(newsComment);
							}
						}
					} catch (SQLException e) {
						throw new NewsException(e);
					}
					
					return newsComments;
				}


				public News NewsDetail(Connection conn, int No) {
					News news = null;
					String sql = prop.getProperty("NewsDetail");
					
					try(PreparedStatement pstmt = conn.prepareStatement(sql)){
						pstmt.setInt(1, No);
						
						try(ResultSet rset = pstmt.executeQuery()){
							
							while(rset.next()) {
								news=handleNewsResultSet(rset);
								  
								}
						}
					} catch (SQLException e) {
						throw new NewsException(e);
					}
					
					return news;
				}

		// 댓글 삭제(업데이트)
				public int NewsCommentDelete(int commentNo, int commentState, Connection conn) {
					int result = 0;
					String sql = prop.getProperty("deleteComment");
					try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
						pstmt.setInt(1, commentState);
						pstmt.setInt(2, commentNo);
						
						result = pstmt.executeUpdate();
					} catch (SQLException e) {
						
						throw new NewsException(e);
					}
					
					return result;
				}
				

				public int newsLikeUpdate(int newsNo, Connection conn) {
					int result = 0;
					String sql = prop.getProperty("newsLikeUpdate");
					try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
						pstmt.setInt(1, newsNo);
					
						result = pstmt.executeUpdate();
					} catch (SQLException e) {
						
						throw new NewsException(e);
					}
					
					return result;
				}

				public List<News> findNewsRanking(Connection conn) {
					List<News> news = new ArrayList<>();
					String sql = prop.getProperty("findNewsRanking");
					try(
						PreparedStatement pstmt = conn.prepareStatement(sql)) {
						try(ResultSet rset = pstmt.executeQuery()){
							while(rset.next()) {
								news.add(handleNewsResultSet(rset));
							}
						}
					} catch (Exception e) {
						throw new NewsException(e);
				}
			return news;
		}

}
