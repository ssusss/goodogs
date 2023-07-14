package com.sk.goodogs.admin.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sk.goodogs.admin.model.service.AdminService;

/**
 * Servlet implementation class AdminMemberRoleUpdate
 */
@WebServlet("/admin/member/memberRoleUpdate")
public class AdminMemberRoleUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final AdminService adminService=new AdminService();

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String memberRole= request.getParameter("memberRoleVal");
		String memberId= request.getParameter("memberIdVal");
		
		
		int result=adminService.roleUpdate(memberRole,memberId);
	
		
		response.setContentType("application/json; charset=utf-8");
		Map<String, Object> map = new HashMap<>();
		map.put("message", "성공적으로 회원권한을 수정했습니다.");
		
		new Gson().toJson(map, response.getWriter());
	
	}

}
