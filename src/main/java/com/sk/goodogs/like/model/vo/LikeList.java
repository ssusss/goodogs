package com.sk.goodogs.like.model.vo;

import java.sql.Date;

/**
 * @author 전수경
 *
 */
public class Like {
	private String memberId;
	private int newsNo;
	private Date likeDate;
	
	public Like() {
		super();
	}

	public Like(String memberId, int newsNo, Date likeDate) {
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
		return "Like [memberId=" + memberId + ", newsNo=" + newsNo + ", likeDate=" + likeDate + "]";
	}
	

}
