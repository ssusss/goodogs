package com.sk.goodogs.like.model.vo;

import java.sql.Timestamp;

public class LikeList extends LikeListEntity {
	// 편의용 변수 추가
	String newsTitle;

	public LikeList() {
		super();
	}

	public LikeList(String newsTitle) {
		super();
		this.newsTitle = newsTitle;
	}
	
	public LikeList(String memberId, int newsNo, Timestamp likeDate) {
		super(memberId, newsNo, likeDate);
	}

	public LikeList(String memberId, int newsNo, Timestamp likeDate, String newsTitle) {
		super(memberId, newsNo, likeDate);
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
		return "LikeList [newsTitle=" + newsTitle + "]";
	}
	

}
