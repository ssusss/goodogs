package com.sk.goodogs.admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sk.goodogs.admin.model.service.AdminService;
import com.sk.goodogs.member.model.vo.Member;

/**
 * Servlet implementation class AdminMemberFindAll
 */
@WebServlet("/admin/member/findAll")
public class AdminMemberFindAll extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final AdminService adminService = new AdminService();

	/**
	 * afteryoon
	 * 전체 멤버 찾기 서블렛
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//기본 윈도우 로드시 발동하는 전체 멤버 조회 
		
		List<Member> members = adminService.memberFindAll();
		System.out.println(members);
		
		//헤더값
		response.setContentType("application/json; charset=utf-8");
		
		
		Gson gson = new Gson();
		String jsonStr = gson.toJson(members);
		System.out.println("jsonStr = " + jsonStr);
		response.getWriter().append(jsonStr);
	}

	

}
