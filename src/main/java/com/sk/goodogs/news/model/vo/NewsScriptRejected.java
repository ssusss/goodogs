package com.sk.goodogs.news.model.vo;

import java.sql.Date;
import java.sql.Timestamp;

public class NewsScriptRejected extends NewsScript{
	
	private int rejectedNo;
	private String rejectedReson;
	
	public NewsScriptRejected() {}


	public NewsScriptRejected(int rejectedNo, int scriptNo, String scriptWriter, String scriptTitle, String scriptCategory,
			String scriptContent, Timestamp scriptWriteDate, String scriptTag, int scriptState,String rejectedReson) {
		super();
		this.rejectedNo = rejectedNo;
		this.rejectedReson = rejectedReson;
	}



	public int getRejectedNo() {
		return rejectedNo;
	}
	public void setRejectedNo(int rejectedNo) {
		this.rejectedNo = rejectedNo;
	}
	public String getRejectedReson() {
		return rejectedReson;
	}
	public void setRejectedReson(String rejectedReson) {
		this.rejectedReson = rejectedReson;
	}

	@Override
	public String toString() {
		return "NewsScriptRejected [rejectedNo=" + rejectedNo + ", rejectedReson=" + rejectedReson +
				", toString()=" + super.toString() + "]";
	
	}



	
	
	

}
