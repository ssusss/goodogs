package com.sk.goodogs.bookmark.model.vo;

import java.sql.Timestamp;

/**
 * @author 이혜령, 전수경
 *
 */
public class BookMark extends BookMarkEntity {

	private String newsTitle;

	public BookMark() {
		super();
	}

	public BookMark(String newsTitle) {
		super();
		this.newsTitle = newsTitle;
	}

	public BookMark(String memberId, int newsNo, String newBookmarkedContent, Timestamp bookmarkDate) {
		super(memberId, newsNo, newBookmarkedContent, bookmarkDate);
	}
	
	public BookMark(String memberId, int newsNo, String newBookmarkedContent, Timestamp bookmarkDate, String newsTitle) {
		super(memberId, newsNo, newBookmarkedContent, bookmarkDate);
		this.newsTitle = newsTitle;
	}
	
	public String getNewsTitle() {
		return newsTitle;
	}

	public void setNewsTitle(String newsTitle) {
		this.newsTitle = newsTitle;
	}

	@Override
	public String toString() {
		return "BookMark [newsTitle=" + newsTitle + "]";
	}
	
	

	
}
