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
 * Servlet implementation class AdminMemberFindSelected
 */
@WebServlet("/admin/member/findMember")
public class AdminMemberFindSelected extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final AdminService adminService=new AdminService();
       

	/**
	 * yoon- 검색한 정보로 멤버 찾기 (비동기처리)
	 * 
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//입력값 확인
		String searchType=request.getParameter("searchType");
		String searchKeyword=request.getParameter("searchKeyword");
		
		
		System.out.println(searchType);
		System.out.println(searchKeyword);
		
		List<Member>members = adminService.memberFindSelected(searchType,searchKeyword);
		System.out.println(members);
		
		Gson gson= new Gson();
		String jsonStr=gson.toJson(members);
		System.out.println("jsonStr = " + jsonStr);
		response.getWriter().append(jsonStr);
		
	}



}
