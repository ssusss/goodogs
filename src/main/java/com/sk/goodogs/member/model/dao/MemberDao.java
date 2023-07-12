package com.sk.goodogs.member.model.dao;

import java.io.FileReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;

import com.sk.goodogs.member.model.exception.MemberException;
import com.sk.goodogs.member.model.vo.Member;

public class MemberDao {
	private Properties prop = new Properties();
	
	public MemberDao() {
		String filename = 
				MemberDao.class.getResource("/member/member-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @author 전수경
	 *  회원가입 -> 회원테이블 
	 */
	public int insertMember(Connection conn, Member newMember) {
		int result =0;
		String sql = prop.getProperty("insertMember");
		// insert into member values(?, ?, ?, ?, ?, default, default, default, default);
		// 5개 설정 : 아이디(이메일), 성별, 비밀번호, 닉네임, 전화번호
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, newMember.getMemberId());
			pstmt.setString(2, newMember.getGender().name());
			pstmt.setString(3, newMember.getPassword());
			pstmt.setString(4, newMember.getNickname());
			pstmt.setString(5, newMember.getPhone());
			
		} catch (SQLException e) {
			throw new MemberException(e);
		}
		return result;
	}

	public Member findById(Connection conn, String memberId) {
		// TODO Auto-generated method stub
		return null;
	}

}
