package com.sk.goodogs.news.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.sk.goodogs.news.model.vo.News;

/**
 * @author 김준한
 *
 */
public class NewsDao {
	private Properties prop = new Properties();

	public List<News> findAll(Connection conn, String memberId) {
		List<News> newsList = new ArrayList<>();
		String sql = prop.getProperty("findAll");
		
		try(
			PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, memberId);
			ResultSet rset = pstmt.executeQuery();
			
			while(rset.next()) {
				News news = new News();
				int newsNo = rset.getInt("news_no");
				String newsTitle = rset.getString("news_title");
				String newsCategory = rset.getString("news_category");
//				int 
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
			
		
		return newsList;
	}

}
