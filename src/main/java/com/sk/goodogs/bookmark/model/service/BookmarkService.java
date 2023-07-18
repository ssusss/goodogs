package com.sk.goodogs.bookmark.model.service;

import java.sql.Connection;
import java.util.List;

import com.sk.goodogs.bookmark.model.dao.BookmarkDao;
import com.sk.goodogs.bookmark.model.vo.Bookmark;
import static com.sk.goodogs.common.JdbcTemplate.*;

/**
 * @author 전수경
 *
 */
public class BookmarkService {
	private final BookmarkDao bookmarkDao = new BookmarkDao();

	// 북마크한 내용을 회원아이디로 조회해서 가져옴
	public List<Bookmark> findBookmarksByMemberId(String memberId) {
		Connection conn = getConnection();
		List<Bookmark> bookmarks = bookmarkDao.findBookmarksByMemberId(conn, memberId);
		return bookmarks;
	}

	// 북마크 추가
	public int insertBookmark(String memberId, int newsNo, String bookmarkedContent) {
		int result =0;
		Connection conn = getConnection();
		try {
			result = bookmarkDao.insertBookmark(conn, memberId, newsNo, bookmarkedContent);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
		} finally {
			close(conn);
		}
		return result;
	}

	// 북마크 삭제
	public int deleteBookmark(String memberId, int newsNo) {
		int result =0;
		Connection conn = getConnection();
		try {
			result = bookmarkDao.deleteBookmark(conn, memberId, newsNo);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
		} finally {
			close(conn);
		}
		return result;
	}
}
