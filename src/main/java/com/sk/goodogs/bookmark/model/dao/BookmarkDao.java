package com.sk.goodogs.bookmark.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.sk.goodogs.bookmark.model.exception.BookmarkException;
import com.sk.goodogs.bookmark.model.vo.Bookmark;

/**
 * @author 전수경
 *
 */
public class BookmarkDao {
	private Properties prop = new Properties();

	public BookmarkDao() {
		String filename = 
				BookmarkDao.class.getResource("/sql/bookmark/bookmark-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @author 전수경
	 */
	public List<Bookmark> findBookmarksByMemberId(Connection conn, String memberId) {
		List<Bookmark> bookmarks = new ArrayList<>();
		Bookmark bookmark = null;
		String sql = prop.getProperty("findBookmarksByMemberId");
		// select * from bookmark where member_id = ?
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, memberId);
			try(ResultSet rset = pstmt.executeQuery()){
				while(rset.next()) {
					bookmark = handleBookmarkResultSet(rset);
					bookmarks.add(bookmark);
				}
			}
			
		} catch (SQLException e) {
			throw new BookmarkException(e);
		}
		return bookmarks;
	}

	private Bookmark handleBookmarkResultSet(ResultSet rset) throws SQLException {
		// Bookmark(memberId, newsNo, newBookmarkedContent, bookmarkDate)
		String memberId = rset.getString("member_id");
		int newsNo = rset.getInt("news_no");
		String newBookmarkedContent = rset.getString("new_bookmarked_content");
		Timestamp bookmarkDate = rset.getTimestamp("bookmark_date");
		return new Bookmark(memberId, newsNo, newBookmarkedContent, bookmarkDate);
	}

}
