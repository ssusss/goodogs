package com.sk.goodogs.like.model.dao;

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
import com.sk.goodogs.like.model.vo.LikeList;

/**
 * @author Sookyeong
 *
 */
public class LikeDao {
	
	private Properties prop = new Properties();

	public List<LikeList> findLikesByMemberId(Connection conn, String memberId) {
		List<LikeList> likes = new ArrayList<>();
		LikeList likeList = null;
		// select * from like_list where member_id =?
		String sql = "select * from like_list where member_id =?";
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, memberId);
			try(ResultSet rset = pstmt.executeQuery()){
				while(rset.next()) {
					String _memberid = rset.getString("member_id");
					int newsNo = rset.getInt("news_no");
					Timestamp likeDate = rset.getTimestamp("like_date");
					likeList = new LikeList(_memberid, newsNo, likeDate);
					likes.add(likeList);
				}
			}
		} catch (SQLException e) {
			throw new LikeException(e);
		}
		return likes;
	}

}
