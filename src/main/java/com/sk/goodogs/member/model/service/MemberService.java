package com.sk.goodogs.member.model.service;


import com.sk.goodogs.member.model.dao.MemberDao;
import com.sk.goodogs.member.model.vo.Member;
import static com.sk.goodogs.common.JdbcTemplate.*;

import java.sql.Connection;

public class MemberService {
	public final MemberDao memberDao = new MemberDao();
	
	/***
	 * @author 이혜령
	 * 정보수정
	 */
	public int memberUpdate(Member member) {
		int result = 0;
		Connection conn = getConnection();
		try {
			result = memberDao.memberUpdate(conn, member);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	
	/**
	 * @author 전수경
	 *  - 회원가입 멤버 테이블에 추가
	 * @param 
	 * @return
	 */
	public int insertMember(Member newMember) {
		int result =0;
		Connection conn = getConnection();
		try {
			result = memberDao.insertMember(conn, newMember);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	
	/***
	 * @author 이혜령
	 */
	public Member findById(String memberId) {
		Connection conn = getConnection();
		Member member = memberDao.findById(conn, memberId);
		close(conn);
		return member;
	}

	/***
	 * @author 이혜령
	 * 회원탈퇴
	 */
	//public int memberWithdraw(String memberId) {
		public int memberWithdraw(String memberId, String[] reason) {
		int result = 0;
		int no = 0;
		Connection conn = getConnection();
		try {
			result = memberDao.memberWithdraw(conn, memberId); // 회원탈퇴
			no = memberDao.getLastNo(conn);
			result = memberDao.UpdateWithdraw(conn, no, reason); // 회원탈퇴 사유
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

}
