package com.sk.goodogs.news.model.vo;

import java.sql.Date;

public class NewsScriptRejected extends NewsScript{
	
	private int rejectedNo;
	private String rejectedReson;
	
	public NewsScriptRejected() {}
	

	public NewsScriptRejected(int rejectedNo, String rejectedReson) {
		super();
		this.rejectedNo = rejectedNo;
		this.rejectedReson = rejectedReson;
	}
	
	
	


	public NewsScriptRejected(int scriptNo, String scriptWriter, String scriptTitle, String scriptCategory,
			String scriptContent, Date scriptWriteDate, String scriptTag, int scriptState, int rejectedNo,
			String rejectedReson) {
		super(scriptNo, scriptWriter, scriptTitle, scriptCategory, scriptContent, scriptWriteDate, scriptTag,
				scriptState);
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
	
	
	
	
	

}
