package com.sk.goodogs.admin.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.naming.spi.DirStateFactory.Result;

import static com.sk.goodogs.common.JdbcTemplate.*;

import com.sk.goodogs.admin.model.exception.AdminException;
import com.sk.goodogs.member.model.vo.Gender;
import com.sk.goodogs.member.model.vo.Member;
import com.sk.goodogs.member.model.vo.MemberRole;

public class AdminDao {
	private Properties prop = new Properties();
	
	public AdminDao() {
		String filename = 
				AdminDao.class.getResource("/admin/admin-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	public List<Member> memberFindAll(Connection conn) {
		List<Member> members= new ArrayList<>();
		String sql=prop.getProperty("memberFindAll");
		
		try(
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rset = pstmt.executeQuery();
			){
				while (rset.next()) {
					Member member = handleMemberResultSet(rset);
					members.add(member);
			}
		}catch (SQLException e) {
			throw new AdminException(e);
		}
		
		return members;
	}

	private Member handleMemberResultSet(ResultSet rset) throws SQLException{
		String memberId= rset.getString("member_id");
		String password= rset.getString("password");
		String nickname= rset.getString("nickname");
		String phone= rset.getString("phone");
		
		Gender gender= null;
		if(rset.getString("gender")!=null)
			gender=Gender.valueOf(rset.getString("gender"));
		MemberRole memberRole= null;
		if(rset.getString("member_role")!=null)
			memberRole=MemberRole.valueOf(rset.getString("member_role"));
		 
		
		Date enrollDate= rset.getDate("enroll_date");
		String memberProfile = rset.getString("member_profile");
		int isBanned =rset.getInt("is_banned");
		
		Member member = new Member(memberId, password, nickname, phone, gender, memberRole, enrollDate, memberProfile, isBanned);
				
		return member;
	}

	
}
