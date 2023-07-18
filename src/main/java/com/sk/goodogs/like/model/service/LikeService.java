package com.sk.goodogs.like.model.service;

import java.sql.Connection;
import java.util.List;
import static com.sk.goodogs.common.JdbcTemplate.*;

import com.sk.goodogs.like.model.dao.LikeDao;
import com.sk.goodogs.like.model.vo.LikeListEntity;

public class LikeService {
	private LikeDao likeDao = new LikeDao();

	public List<LikeListEntity> findLikesByMemberId(String memberId) {
		Connection conn = getConnection();
		List<LikeListEntity> likes = likeDao.findLikesByMemberId(conn, memberId);
		close(conn);
		return likes;
	}

}
