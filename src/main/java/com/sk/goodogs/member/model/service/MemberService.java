package com.sk.goodogs.member.model.service;

import com.sk.goodogs.member.model.dao.MemberDao;
import com.sk.goodogs.member.model.vo.Member;
import static com.sk.goodogs.common.JdbcTemplate.*;

import java.sql.Connection;

/**
 * @author user1
 *
 */
public class MemberService {
	public final MemberDao memberDao = new MemberDao();
	
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

}
