package com.sk.goodogs.news.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.sk.goodogs.news.model.vo.News;

public class NewsDao {
	private Properties prop = new Properties();

	public List<News> findAll(Connection conn, String memberId) {
		List<News> newsList = new ArrayList<>();
		String sql = prop.getProperty("findAll");
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rset = pstmt.executeQuery();
		){
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
			
		
		return newsList;
	}

}
