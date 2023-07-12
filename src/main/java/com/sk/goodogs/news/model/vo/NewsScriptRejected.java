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
	
	
	


	public NewsScriptRejected(int rejectedNo, int scriptNo, String scriptTitle, String scriptCategory, String scriptContent,
			Date scriptWriteDate, String scriptTag, int scriptState, String scriptWriter, String rejectedReson) {
		super(scriptNo,
				scriptTitle,
				scriptCategory, 
				scriptContent, 
				scriptWriteDate, 
				scriptTag, 
				scriptState, 
				scriptWriter);
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
