package com.sk.goodogs.like.model.vo;

import java.sql.Date;

/**
 * @author 전수경
 * - 테이블에는 없지만 뉴스 제목을 담는 편의용 변수 newsTitle 추가 
 */
public class LikeList {
	private String memberId;
	private int newsNo;
	private Date likeDate;
	
	public LikeList() {
		super();
	}

	public LikeList(String memberId, int newsNo, Date likeDate) {
		super();
		this.memberId = memberId;
		this.newsNo = newsNo;
		this.likeDate = likeDate;
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

	public Date getLikeDate() {
		return likeDate;
	}

	public void setLikeDate(Date likeDate) {
		this.likeDate = likeDate;
	}

	@Override
	public String toString() {
		return "LikeList [memberId=" + memberId + ", newsNo=" + newsNo + ", likeDate=" + likeDate + "]";
	}


}
