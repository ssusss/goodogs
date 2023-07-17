package com.sk.goodogs.like.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.sk.goodogs.like.model.exception.LikeException;
import com.sk.goodogs.like.model.vo.LikeListEntity;

/**
 * @author Sookyeong
 *
 */
public class LikeDao {
	
	private Properties prop = new Properties();
	

	public LikeDao() {
		String filename = 
			LikeDao.class.getResource("/like/like-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public List<LikeListEntity> findLikesByMemberId(Connection conn, String memberId) {
		List<LikeListEntity> likes = new ArrayList<>();
		LikeListEntity likeListEntity = null;
		// select * from like_list where member_id =?
		String sql = prop.getProperty("findLikesByMemberId");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, memberId);
			try(ResultSet rset = pstmt.executeQuery()){
				while(rset.next()) {
					String _memberid = rset.getString("member_id");
					int newsNo = rset.getInt("news_no");
					Timestamp likeDate = rset.getTimestamp("like_date");
					likeListEntity = new LikeListEntity(_memberid, newsNo, likeDate);
					likes.add(likeListEntity);
				}
			}
		} catch (SQLException e) {
			throw new LikeException(e);
		}
		return likes;
	}

}
