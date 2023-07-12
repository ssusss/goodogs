package com.sk.goodogs.admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sk.goodogs.admin.model.service.AdminService;

/**
 * Servlet implementation class MemberBanListServlet
 */
@WebServlet("/admin/adminMemberBanList")
public class AdminMemberBanListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
//	private final AdminService adminService = new AdminService();
//	private final int LIMIT = 15; 

	/**
	 * @author na0
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		
		//1. 입력값 처리 
//		int cpage = 1; 
//		
//		try {
//			cpage = Integer.parseInt(request.getParameter("cpage"));
//			
//		}catch (NumberFormatException  e) {
//			// 예외처리 없음
//		}
//		
//		int start = (cpage - 1) * LIMIT + 1;
//		int end = cpage * LIMIT;
//		
		
		// 2, 업무로직
	
		
		
		// 3. 응답처리
		request.getRequestDispatcher("/WEB-INF/views/admin/adminMemberBanList.jsp")
		.forward(request, response);
	}



}
