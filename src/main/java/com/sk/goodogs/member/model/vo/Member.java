package com.sk.goodogs.member.model.vo;

import java.sql.Timestamp;

/**
 * @author 전수경, 이혜령
 * - 전수경: 생성자, getter/setter 생성, toString 오버라이드
 * - 이혜령 : 생성자 추가
 */
public class Member {
	
	private String memberId;
	private String password;
	private String nickName;
	private String phone;
	
	private Gender gender; // M, F, N
	private MemberRole memberRole; // A, R, M
	
	private Timestamp enrollDate;


	public Member() {
		super();
	}

	public Member(String memberId, String password, String nickName, String phone, Gender gender, MemberRole memberRole,
			Timestamp enrollDate) {
		super();
		this.memberId = memberId;
		this.password = password;
		this.nickName = nickName;
		this.phone = phone;
		this.gender = gender;
		this.memberRole = memberRole;
		this.enrollDate = enrollDate;
	}

	public Member(String memberId, String password, String nickName, String phone, Gender gender) {
		super();
		this.memberId = memberId;
		this.password = password;
		this.nickName = nickName;
		this.phone = phone;
		this.gender = gender;
	}

	public String getMemberId() {
		return memberId;
	}


	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public String getNickname() {
		return nickName;
	}


	public void setNickname(String nickname) {
		this.nickName = nickname;
	}


	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}


	public Gender getGender() {
		return gender;
	}


	public void setGender(Gender gender) {
		this.gender = gender;
	}


	public MemberRole getMemberRole() {
		return memberRole;
	}


	public void setMemberRole(MemberRole memberRole) {
		this.memberRole = memberRole;
	}


	public Timestamp getEnrollDate() {
		return enrollDate;
	}


	public void setEnrollDate(Timestamp enrollDate) {
		this.enrollDate = enrollDate;
	}


	@Override
	public String toString() {
		return "Member [memberId=" + memberId + ", password=" + password + ", nickName=" + nickName + ", phone=" + phone
				+ ", gender=" + gender + ", memberRole=" + memberRole + ", enrollDate=" + enrollDate + "]";
	}
	
	
	
}
