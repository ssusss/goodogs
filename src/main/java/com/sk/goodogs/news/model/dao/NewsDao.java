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


import com.sk.goodogs.news.model.exception.NewsException;
import com.sk.goodogs.news.model.vo.News;

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
	
	public List<News> findAll(Connection conn, String memberId) {
		List<News> newsList = new ArrayList<>();
		String sql = prop.getProperty("findAll");
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, memberId);
			try(ResultSet rset = pstmt.executeQuery()) {
				while(rset.next()) {
					News news = handleCelebResultSet(rset);
					
					newsList.add(news);
					}
				}
			} catch (SQLException e) {
				throw new NewsException(e);
			}
			
			return newsList;
			}
		
		private News handleCelebResultSet(ResultSet rset) throws SQLException {
			int no = rset.getInt("news_no");
			String newsWriter = rset.getString("news_writer");
			String newsTitle = rset.getString("news_title");
			String newsCategory = rset.getString("news_category");
			String newsContent = rset.getString("news_content");
			Date newsWriteDate = rset.getDate("news_write_date");
			String newsTag = rset.getString("news_tag");
			int newsLikeCnt = rset.getInt("news_like_cnt");
			int newsReadCnt = rset.getInt("news_read_cnt");
			Date newsConfirmedDate = rset.getDate("news_confirmed_date");
			
			return new News(newsReadCnt, newsWriter, newsTitle, newsCategory, newsContent, newsWriteDate, newsTag, newsLikeCnt, newsReadCnt, newsConfirmedDate);
		}

}
