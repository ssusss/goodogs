package com.sk.goodogs.admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sk.goodogs.admin.model.service.AdminService;
import com.sk.goodogs.news.model.vo.NewsScriptRejected;

/**
 * Servlet implementation class AdminScriptRejectedDetail
 */
@WebServlet("/admin/script/rejectedDetail")
public class AdminScriptRejectedDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final AdminService adminService= new AdminService();


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int no=Integer.valueOf(request.getParameter("no"));
		System.out.println(no);

		NewsScriptRejected rejectedScript =adminService.findOneRejectedScript(no);
		System.out.println(rejectedScript);
		
		request.setAttribute("rejectedScript", rejectedScript);
		request.getRequestDispatcher("/WEB-INF/views/admin/scriptRejectDetail.jsp")
		.forward(request, response);
		
	}


}
