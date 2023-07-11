package com.sk.goodogs.member.model.vo;

import java.sql.Timestamp;

// 회원
public class Member {
	
	private String memberId;
	private String password;
	private String nickname;
	private String phone;
	
	private Gender gender;
	private MemberRole memberRole;
	
	
	private Timestamp enrollDate;
	
	
}
