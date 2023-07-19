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

	/**
	 * @author 전수경
	 * - 뉴스 좋아요수 조회
	 */
	public int getNewsLikeCnt(Connection conn, int no) {
		int newsLikeCnt =0;
		String sql = prop.getProperty("getNewsLikeCnt");
		// select count(*) from like_list where news_no = ?
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, no);
			try(ResultSet rset = pstmt.executeQuery()){
				if(rset.next()) {
					newsLikeCnt = rset.getInt(1);
				}
			}
			System.out.println("newsLikeCnt="+newsLikeCnt);
		} catch (SQLException e) {
			throw new LikeException(e);
		}
		return newsLikeCnt;
	}

	/**
	 * @author 전수경
	 * - 뉴스의 좋아요 상태 조회
	 */
	public int checkLikeState(Connection conn, String memberId, int newsNo) {
		int result =0;
		String sql = prop.getProperty("checkLikeState");
		// select count(*) from like_list where news_no = ? and member_id = ?
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, newsNo);
			pstmt.setString(2, memberId);
			try(ResultSet rset = pstmt.executeQuery()){
				if(rset.next()) {
					result = rset.getInt(1);
				}
			}
		} catch (SQLException e) {
			throw new LikeException(e);
		}
		return result;
	}

	public int updateLike(Connection conn, String method, String memberId, int newsNo) {
		int result =0;
		String sql = "";
		// sql 설정
		if("insert".equals(method)) {
			// insert into like_list values( ? , ? , default)
			sql = prop.getProperty("insertLike");
		} else if("delete".equals(method)) {
			// delete from like_list where news_no = ? and member_id = ?
			sql = prop.getProperty("deleteLike");
		}

		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, memberId);
			pstmt.setInt(2, newsNo);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new LikeException(e);
		}
		return result;
	}

}
