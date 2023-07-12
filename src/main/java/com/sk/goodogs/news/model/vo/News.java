package com.sk.goodogs.news.model.vo;

import java.util.Date;

public class News {
	private int newsNo;
	private String newsWriter;
	private String newsTitle;
	private String newsCategory;
	private String newsContent;
	private Date newsWriteDate;
	private String newsTag;
	private int newsLikeCnt;
	private int newsReadCnt;
	private Date newsConfirmedDate;
	
	public News() {
		super();
		// TODO Auto-generated constructor stub
	}

	public News(int newsNo, String newsWriter, String newsTitle, String newsCategory, String newsContent,
			Date newsWriteDate, String newsTag, int newsLikeCnt, int newsReadCnt, Date newsConfirmedDate) {
		super();
		this.newsNo = newsNo;
		this.newsWriter = newsWriter;
		this.newsTitle = newsTitle;
		this.newsCategory = newsCategory;
		this.newsContent = newsContent;
		this.newsWriteDate = newsWriteDate;
		this.newsTag = newsTag;
		this.newsLikeCnt = newsLikeCnt;
		this.newsReadCnt = newsReadCnt;
		this.newsConfirmedDate = newsConfirmedDate;
	}

	public int getNewsNo() {
		return newsNo;
	}

	public void setNewsNo(int newsNo) {
		this.newsNo = newsNo;
	}

	public String getNewsWriter() {
		return newsWriter;
	}

	public void setNewsWriter(String newsWriter) {
		this.newsWriter = newsWriter;
	}

	public String getNewsTitle() {
		return newsTitle;
	}

	public void setNewsTitle(String newsTitle) {
		this.newsTitle = newsTitle;
	}

	public String getNewsCategory() {
		return newsCategory;
	}

	public void setNewsCategory(String newsCategory) {
		this.newsCategory = newsCategory;
	}

	public String getNewsContent() {
		return newsContent;
	}

	public void setNewsContent(String newsContent) {
		this.newsContent = newsContent;
	}

	public Date getNewsWriteDate() {
		return newsWriteDate;
	}

	public void setNewsWriteDate(Date newsWriteDate) {
		this.newsWriteDate = newsWriteDate;
	}

	public String getNewsTag() {
		return newsTag;
	}

	public void setNewsTag(String newsTag) {
		this.newsTag = newsTag;
	}

	public int getNewsLikeCnt() {
		return newsLikeCnt;
	}

	public void setNewsLikeCnt(int newsLikeCnt) {
		this.newsLikeCnt = newsLikeCnt;
	}

	public int getNewsReadCnt() {
		return newsReadCnt;
	}

	public void setNewsReadCnt(int newsReadCnt) {
		this.newsReadCnt = newsReadCnt;
	}

	public Date getNewsConfirmedDate() {
		return newsConfirmedDate;
	}

	public void setNewsConfirmedDate(Date newsConfirmedDate) {
		this.newsConfirmedDate = newsConfirmedDate;
	}

	@Override
	public String toString() {
		return "News [newsNo=" + newsNo + ", newsWriter=" + newsWriter + ", newsTitle=" + newsTitle + ", newsCategory="
				+ newsCategory + ", newsContent=" + newsContent + ", newsWriteDate=" + newsWriteDate + ", newsTag="
				+ newsTag + ", newsLikeCnt=" + newsLikeCnt + ", newsReadCnt=" + newsReadCnt + ", newsConfirmedDate="
				+ newsConfirmedDate + "]";
	}
	
	
	
}
