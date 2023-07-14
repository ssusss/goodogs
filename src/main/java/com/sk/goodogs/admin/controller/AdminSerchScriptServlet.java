package com.sk.goodogs.admin.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sk.goodogs.admin.model.service.AdminService;
import com.sk.goodogs.news.model.vo.NewsScript;

/**
 * Servlet implementation class AdminSerchScriptServlet
 */
@WebServlet("/admin/member/serchScript")
public class AdminSerchScriptServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final AdminService adminService = new AdminService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String searchTypeVal=request.getParameter("searchTypeVal");
		String searchKeywordVal=request.getParameter("searchKeywordVal");
		int scriptState=Integer.valueOf(request.getParameter("scriptState"));
		System.out.println(searchTypeVal);
		System.out.println(searchKeywordVal);
		System.out.println(scriptState);
		
		List<NewsScript> scripts=adminService.scriptSerch(scriptState,searchTypeVal,searchKeywordVal);
		
		response.setContentType("application/json; charset=utf-8");
		
		new Gson().toJson(scripts, response.getWriter());
	}

}
