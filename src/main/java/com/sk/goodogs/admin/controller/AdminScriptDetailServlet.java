package com.sk.goodogs.admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sk.goodogs.admin.model.service.AdminService;
import com.sk.goodogs.news.model.vo.NewsScript;

/**
 * Servlet implementation class AdminScriptDetailServlet
 */
@WebServlet("/admin/scriptDetail")
public class AdminScriptDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final AdminService adminService = new AdminService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int no=Integer.valueOf(request.getParameter("no"));
		System.out.println(no);
		
		NewsScript script=adminService.findOneScript(no);
		System.out.println(script);
		
		request.setAttribute("script",script );
		request.getRequestDispatcher("/WEB-INF/views/admin/scriptDetail.jsp")
		.forward(request, response);
		
	}

	

}
