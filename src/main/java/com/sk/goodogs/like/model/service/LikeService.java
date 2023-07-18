package com.sk.goodogs.like.model.service;

import java.sql.Connection;
import java.util.List;
import static com.sk.goodogs.common.JdbcTemplate.*;

import com.sk.goodogs.like.model.dao.LikeDao;
import com.sk.goodogs.like.model.vo.LikeListEntity;

/**
 * @author 전수경
 *
 */
public class LikeService {
	private LikeDao likeDao = new LikeDao();

	public List<LikeListEntity> findLikesByMemberId(String memberId) {
		Connection conn = getConnection();
		List<LikeListEntity> likes = likeDao.findLikesByMemberId(conn, memberId);
		close(conn);
		return likes;
	}

	// 뉴스 좋아요수 조회후 반환
	public int getNewsLikeCnt(int no) {
		Connection conn = getConnection();
		int newsLikeCnt = likeDao.getNewsLikeCnt(conn, no);
		close(conn);
		return newsLikeCnt;
	}

	// 회원이 좋아요했는지 확인
	public int checkLikeState(String memberId, int newsNo) {
		Connection conn = getConnection();
		int result = likeDao.checkLikeState(conn, memberId, newsNo);
		close(conn);
		return result;
	}

	// 좋아요 추가/삭제
	public int updateLike(String method, String memberId, int newsNo) {
		int result =0;
		Connection conn = getConnection();
		try {
			result = likeDao.updateLike(conn, method, memberId, newsNo);
			commit(conn);
		}catch (Exception e) {
			rollback(conn);
		} finally {
			close(conn);			
		}
		return result;
	}

}
