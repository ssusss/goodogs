package com.sk.goodogs.news.model.vo;

import java.sql.Timestamp;


/**
 * @author 나영
 * */
public class NewsComment {
	
	private int commentNo;
	private int newsCommentLevel;
	private int newsNo;
	private String newsCommentWriter;
	private int  commentNoRef;
	private String newsCommentNickname;
	private String newsCommentContent;
	private Timestamp commentRegDate;
	private int newsCommentReportCnt;
	private int commentState;
	public NewsComment() {
		
		super();
		// TODO Auto-generated constructor stub
	}
	
	public NewsComment(int commentNo, int newsCommentLevel, int newsNo, String newsCommentWriter, int commentNoRef,
			String newsCommentNickname, String newsCommentContent, Timestamp commentRegDate, int newsCommentReportCnt,
			int commentState) {
		super();
		this.commentNo = commentNo;
		this.newsCommentLevel = newsCommentLevel;
		this.newsNo = newsNo;
		this.newsCommentWriter = newsCommentWriter;
		this.commentNoRef = commentNoRef;
		this.newsCommentNickname = newsCommentNickname;
		this.newsCommentContent = newsCommentContent;
		this.commentRegDate = commentRegDate;
		this.newsCommentReportCnt = newsCommentReportCnt;
		this.commentState = commentState;
	}
	
	public int getCommentNo() {
		return commentNo;
	}
	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}
	public int getNewsCommentLevel() {
		return newsCommentLevel;
	}
	public void setNewsCommentLevel(int newsCommentLevel) {
		this.newsCommentLevel = newsCommentLevel;
	}
	public int getNewsNo() {
		return newsNo;
	}
	public void setNewsNo(int newsNo) {
		this.newsNo = newsNo;
	}
	public String getNewsCommentWriter() {
		return newsCommentWriter;
	}
	public void setNewsCommentWriter(String newsCommentWriter) {
		this.newsCommentWriter = newsCommentWriter;
	}
	public int getCommentNoRef() {
		return commentNoRef;
	}
	public void setCommentNoRef(int commentNoRef) {
		this.commentNoRef = commentNoRef;
	}
	public String getNewsCommentNickname() {
		return newsCommentNickname;
	}
	public void setNewsCommentNickname(String newsCommentNickname) {
		this.newsCommentNickname = newsCommentNickname;
	}
	public String getNewsCommentContent() {
		return newsCommentContent;
	}
	public void setNewsCommentContent(String newsCommentContent) {
		this.newsCommentContent = newsCommentContent;
	}
	public Timestamp getCommentRegDate() {
		return commentRegDate;
	}
	public void setCommentRegDate(Timestamp commentRegDate) {
		this.commentRegDate = commentRegDate;
	}
	public int getNewsCommentReportCnt() {
		return newsCommentReportCnt;
	}
	public void setNewsCommentReportCnt(int newsCommentReportCnt) {
		this.newsCommentReportCnt = newsCommentReportCnt;
	}
	public int getCommentState() {
		return commentState;
	}
	public void setCommentState(int commentState) {
		this.commentState = commentState;
	}
	
	@Override
	public String toString() {
		return "NewsComment [commentNo=" + commentNo + ", newsCommentLevel=" + newsCommentLevel + ", newsNo=" + newsNo
				+ ", newsCommentWriter=" + newsCommentWriter + ", commentNoRef=" + commentNoRef
				+ ", newsCommentNickname=" + newsCommentNickname + ", newsCommentContent=" + newsCommentContent
				+ ", commentRegDate=" + commentRegDate + ", newsCommentReportCnt=" + newsCommentReportCnt
				+ ", commentState=" + commentState + "]";
	}
	
	
	
	

}
