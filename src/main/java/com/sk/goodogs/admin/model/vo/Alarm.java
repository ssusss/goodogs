package com.sk.goodogs.admin.model.vo;

import java.security.Timestamp;
import java.util.Date;

public class Alarm {
	
	private int alarmNo;
	private String alarmMessageType;
	private int alarmScriptNo;
	private String alarmComment;
	private String alarmReceiver;
	private int alarmHasRead;
	
	
	public Alarm(int alarmNo, String alarmMessageType, int alarmScriptNo, String alarmComment, String alarmReceiver,
			int alarmHasRead, Timestamp alarmCreatedAt) {
		super();
		this.alarmNo = alarmNo;
		this.alarmMessageType = alarmMessageType;
		this.alarmScriptNo = alarmScriptNo;
		this.alarmComment = alarmComment;
		this.alarmReceiver = alarmReceiver;
		this.alarmHasRead = alarmHasRead;
	}


	public int getAlarmNo() {
		return alarmNo;
	}


	public void setAlarmNo(int alarmNo) {
		this.alarmNo = alarmNo;
	}


	public String getAlarmMessageType() {
		return alarmMessageType;
	}


	public void setAlarmMessageType(String alarmMessageType) {
		this.alarmMessageType = alarmMessageType;
	}


	public int getAlarmScriptNo() {
		return alarmScriptNo;
	}


	public void setAlarmScriptNo(int alarmScriptNo) {
		this.alarmScriptNo = alarmScriptNo;
	}


	public String getAlarmComment() {
		return alarmComment;
	}


	public void setAlarmComment(String alarmComment) {
		this.alarmComment = alarmComment;
	}


	public String getAlarmReceiver() {
		return alarmReceiver;
	}


	public void setAlarmReceiver(String alarmReceiver) {
		this.alarmReceiver = alarmReceiver;
	}


	public int getAlarmHasRead() {
		return alarmHasRead;
	}


	public void setAlarmHasRead(int alarmHasRead) {
		this.alarmHasRead = alarmHasRead;
	}


	


	@Override
	public String toString() {
		return "Alarm [alarmNo=" + alarmNo + ", alarmMessageType=" + alarmMessageType + ", alarmScriptNo="
				+ alarmScriptNo + ", alarmComment=" + alarmComment + ", alarmReceiver=" + alarmReceiver
				+ ", alarmHasRead=" + alarmHasRead + ", alarmCreatedAt=" + "]";
	}
	
	
	
	
	
	
	
}
