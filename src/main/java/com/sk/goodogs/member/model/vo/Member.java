package com.sk.goodogs.member.model.vo;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.Date;

/**
 * @author 전수경, 이혜령
 * - 전수경: 생성자, getter/setter 생성, toString 오버라이드
 * - 이혜령 : 생성자 추가
 */
public class Member {
	
	private String memberId;
	private String password;
	private String nickname;
	private String phone;
	
	private Gender gender; // M, F, N
	private MemberRole memberRole; // A, R, M
	
	private Date enrollDate;
	private String memberProfile;
	private int isBanned;

	public Member() {
		super();
	}

	public Member(String memberId, String password, String nickname, String phone, Gender gender, MemberRole memberRole,
			Date enrollDate, String memberProfile, int isBanned) {
		super();
		this.memberId = memberId;
		this.password = password;
		this.nickname = nickname;
		this.phone = phone;
		this.gender = gender;
		this.memberRole = memberRole;
		this.enrollDate = enrollDate;
		this.memberProfile = memberProfile;
		this.isBanned = isBanned;
	}

	public Member(String memberId, String password, String nickname, String phone, Gender gender) {
		super();
		this.memberId = memberId;
		this.password = password;
		this.nickname = nickname;
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
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
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

	public Date getEnrollDate() {
		return enrollDate;
	}

	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}

	public String getMemberProfile() {
		return memberProfile;
	}

	public void setMemberProfile(String memberProfile) {
		this.memberProfile = memberProfile;
	}

	public int getIsBanned() {
		return isBanned;
	}

	public void setIsBanned(int isBanned) {
		this.isBanned = isBanned;
	}

	@Override
	public String toString() {
		return "Member [memberId=" + memberId + ", password=" + password + ", nickname=" + nickname + ", phone=" + phone
				+ ", gender=" + gender + ", memberRole=" + memberRole + ", enrollDate=" + enrollDate
				+ ", memberProfile=" + memberProfile + ", isBanned=" + isBanned + "]";
	}
	
	
}
