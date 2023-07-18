package com.sk.goodogs.bookmark.model.service;

import java.sql.Connection;
import java.util.List;

import com.sk.goodogs.bookmark.model.dao.BookmarkDao;
import com.sk.goodogs.bookmark.model.vo.Bookmark;
import static com.sk.goodogs.common.JdbcTemplate.*;

public class BookmarkService {
	private final BookmarkDao bookmarkDao = new BookmarkDao();

	public List<Bookmark> findBookmarksByMemberId(String memberId) {
		Connection conn = getConnection();
		List<Bookmark> bookmarks = bookmarkDao.findBookmarksByMemberId(conn, memberId);
		return bookmarks;
	}

	public int insertBookmark(String memberId, int newsNo, String bookmarkedContent) {
		// TODO Auto-generated method stub
		return 0;
	}

}
