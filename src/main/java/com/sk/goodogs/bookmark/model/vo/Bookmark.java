package com.sk.goodogs.bookmark.model.vo;

import java.sql.Timestamp;

import com.sk.goodogs.news.model.vo.News;

/**
 * @author 전수경
 * - BookmarkEntity 상속 변수
 * - 북마크한 뉴스정보를 담을 news 변수 추가
 */
public class Bookmark extends BookmarkEntity {
	// 북마크한 뉴스정보 담을 변수
	private News news;

	public Bookmark() {
		super();
	}
	
	public Bookmark(String memberId, int newsNo, String newsTitle, String newBookmarkedContent,
			Timestamp bookmarkDate) {
		super(memberId, newsNo, newsTitle, newBookmarkedContent, bookmarkDate);
	}
	
	public Bookmark(String memberId, int newsNo, String newsTitle, String newBookmarkedContent,
			Timestamp bookmarkDate, News news) {
		super(memberId, newsNo, newsTitle, newBookmarkedContent, bookmarkDate);
		this.news = news;
	}
	

	public News getNews() {
		return news;
	}


	public void setNews(News news) {
		this.news = news;
	}

	@Override
	public String toString() {
		return "Bookmark [news=" + news + "]";
	}
	
}
