package com.sk.goodogs.admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sk.goodogs.admin.model.service.AdminService;

/**
 * @author 김나영
 */
@WebServlet("/admin/memberbanUpdate")
public class AdminMemberBanUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final AdminService adminService = new AdminService();




	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1. 입력값 처리
		String memberId  = request.getParameter("memberId");
		System.out.println("memberId === " + memberId);
		request.setAttribute("memberId", memberId);

		// 2. 업무 로직
		int result = adminService.BanUpdate(memberId);
		
		
		// 3. 응답 
		
		response.sendRedirect(request.getContextPath() + "/admin/adminMemberBanList");
		
		
		
	}
	

}
