package com.sk.goodogs.bookmark.model.vo;

import java.sql.Timestamp;

public class BookmarkEntity {
	
	private String memberId;
	private int newsNo;
	private String newBookmarkedContent;
	private Timestamp bookmarkDate;
	
	public BookmarkEntity() {
		super();
	}

	public BookmarkEntity(String memberId, int newsNo, String newBookmarkedContent, Timestamp bookmarkDate) {
		super();
		this.memberId = memberId;
		this.newsNo = newsNo;
		this.newBookmarkedContent = newBookmarkedContent;
		this.bookmarkDate = bookmarkDate;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public int getNewsNo() {
		return newsNo;
	}

	public void setNewsNo(int newsNo) {
		this.newsNo = newsNo;
	}

	public String getNewBookmarkedContent() {
		return newBookmarkedContent;
	}

	public void setNewBookmarkedContent(String newBookmarkedContent) {
		this.newBookmarkedContent = newBookmarkedContent;
	}

	public Timestamp getBookmarkDate() {
		return bookmarkDate;
	}

	public void setBookmarkDate(Timestamp bookmarkDate) {
		this.bookmarkDate = bookmarkDate;
	}

	@Override
	public String toString() {
		return "BookmarkEntity [memberId=" + memberId + ", newsNo=" + newsNo + ", newBookmarkedContent="
				+ newBookmarkedContent + ", bookmarkDate=" + bookmarkDate + "]";
	}

}
