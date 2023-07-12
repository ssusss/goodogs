package com.sk.goodogs.admin.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.sk.goodogs.news.model.vo.NewsComment;

public class AdminDao {
	private Properties prop = new Properties();
	
	public AdminDao() {
		String filename = 
				AdminDao.class.getResource("/admin/admin-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}


	
// 벤용 ----------------------------------------
	

	public List<NewsComment> findBenComment(Connection conn) {
		List<NewsComment> newsComments = new ArrayList<>();
		String sql = prop.getProperty("findBanComment");
		
		try (
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rset = pstmt.executeQuery();
				){
			
			while(rset.next()) {
				NewsComment newsComment  =  handleCommentrResultSet(rset);
				newsComments.add(newsComment);
				
			}
			
		} catch (Exception e) {
//			throw new AdminrException(e);
		}

		return newsComments;
	}



private NewsComment handleCommentrResultSet(ResultSet rset) throws SQLException {
	 int commentNo = rset.getInt("comment_no");
	 int newsCommentLevel  = rset.getInt("news_comment_level");
	 int newsNo  = rset.getInt("news_no");
	 String newsCommentWriter = rset.getString("news_comment_writer");
	 int  commentNoRef  = rset.getInt("comment_no_ref");
	 String newsCommentNickname  = rset.getString("news_comment_nickname");
	String  newsCommentContent  = rset.getString("news_comment_content");
	 Date commentRegDate  = rset.getDate("comment_reg_date");
	 int newsCommentReportCnt  = rset.getInt("news_comment_report_cnt");
	 int commentState  = rset.getInt("comment_state");

	return new NewsComment( commentNo, newsCommentLevel,newsNo, newsCommentWriter, commentNoRef,
			 newsCommentNickname,  newsCommentContent,commentRegDate, newsCommentReportCnt, commentState);
	
}
// ---------------------------------------

	
}
