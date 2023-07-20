package com.sk.goodogs.reporter.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sk.goodogs.admin.model.service.AdminService;
import com.sk.goodogs.news.model.vo.NewsScriptRejected;

/**
 * Servlet implementation class ReporterScriptRejectedReasonServlet
 */
@WebServlet("/reporter/scriptRejectedReason")
public class ReporterScriptRejectedReasonServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final AdminService adminService = new AdminService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int no = Integer.parseInt(request.getParameter("scriptNo"));
		
		NewsScriptRejected newsScriptRejected = adminService.findOneRejectedScript(no);
		
		String rejectedReason = newsScriptRejected.getRejectedReson();
		
		response.setContentType("application/json; charset=utf-8");
		new Gson().toJson(rejectedReason,response.getWriter());
	}

}
