package com.sk.goodogs.member.model.dao;

import java.io.FileReader;
import java.sql.Array;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

import com.sk.goodogs.member.model.exception.MemberException;
import com.sk.goodogs.member.model.vo.Gender;
import com.sk.goodogs.member.model.vo.Member;
import com.sk.goodogs.member.model.vo.MemberRole;

public class MemberDao {
	private Properties prop = new Properties();
	
	/***
	 * @author 이혜령
	 * 정보수정
	 */
	public int memberUpdate(Connection conn, Member member) {
		int result = 0;
		String sql = prop.getProperty("memberUpdate");
		// update member set password = ?, nickname = ?, phone = ?, member_profile =?, gender = ? where member_id = ?
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, member.getPassword());
			pstmt.setString(2, member.getNickname());
			pstmt.setString(3, member.getPhone());
			pstmt.setString(4, member.getMemberProfile());
			pstmt.setString(5, member.getGender() != null? member.getGender().name() : null);
			pstmt.setString(6, member.getMemberId());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	/***
	 * @author 이혜령
	 */
	public Member findById(Connection conn, String memberId) {
		// select * from member where member_id = ?
		String sql = prop.getProperty("findById"); 
		Member member = null;
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, memberId);
			
			try(ResultSet rset = pstmt.executeQuery()) {
				while(rset.next()) {
					member = handleMemberResultSet(rset);
				}
			}
		} catch (SQLException e) {
			throw new MemberException(e);
		}
		return member;
	}
	
	/***
	 * @author 이혜령
	 */
	private Member handleMemberResultSet(ResultSet rset) throws SQLException {
		
		String memberId = rset.getString("member_id");
		String password = rset.getString("password");
		String nickname = rset.getString("nickname");
		String phone = rset.getString("phone");
		
		String _gender = rset.getString("gender");
		Gender gender = _gender != null ? Gender.valueOf(_gender) : null;
		
		String _memberRole = rset.getString("member_role");
		MemberRole memberRole = _memberRole != null ? MemberRole.valueOf(_memberRole) : null;
		
		Timestamp enrollDate = rset.getTimestamp("enroll_date");
		String memberProfile = rset.getString("member_profile");
		int isBanned = rset.getInt("is_banned");
		
		return new Member(memberId, password, nickname, phone, gender, memberRole, enrollDate, memberProfile, isBanned);

	}
		
		
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
	 *  회원가입 -> 회원테이블 삽입
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
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new MemberException(e);
		}
		return result;

	}

	/***
	 * @author 이혜령
	 * 회원탈퇴
	 */
	public int memberWithdraw(Connection conn, String memberId) {
		int result = 0;
		// delete from member where member_id = ?
		String sql = prop.getProperty("memberWithdraw");
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, memberId);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new MemberException(e);
		}
		return result;
	}


	/***
	 * @author 이혜령
	 * 회원탈퇴 사유
	 */
	
	public int getLastNo(Connection conn) {
		int no = 0;
		// select seq_withdraw_member_no.currval from dual
		String sql = prop.getProperty("getLastNo");
		
		try(
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rset = pstmt.executeQuery();
		) {
			if(rset.next())
				no = rset.getInt(1);
		} catch (SQLException e) {
			throw new MemberException(e);
		}
		return no;
	}
	
	public int UpdateWithdraw(Connection conn, int no, String[] reason) {
		int result = 0;
		// update withdraw_member set withdraw_reason = ? where withdraw_member_no = ?
		String sql = prop.getProperty("UpdateWithdraw");
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			String reasonString = Arrays.toString(reason);
			pstmt.setString(1, reasonString);
			pstmt.setInt(2, no);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new MemberException(e);
		}
		return result;
	}

	public int getTotalMember(Connection conn) {
		int totalMember = 0;
		String sql = prop.getProperty("getTotalMember");
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			try (ResultSet rset = pstmt.executeQuery()) {
				if(rset.next())
					totalMember = rset.getInt(1);
			}
		} catch (SQLException e) {
			throw new MemberException(e);
		}
		return totalMember;
	}
	


}
