package com.sk.goodogs.admin.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sk.goodogs.admin.model.service.AdminService;
import com.sk.goodogs.news.model.vo.NewsScript;

/**
 * Servlet implementation class AdminScriptStatFind
 */
@WebServlet("/admin/member/findScriptState")
public class AdminScriptStatFind extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final AdminService adminService = new AdminService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int scriptState=Integer.valueOf(request.getParameter("sciptState"));
		System.out.println(scriptState);
		
		List<NewsScript> scripts=adminService.scriptFind(scriptState);
		
		response.setContentType("application/json; charset=utf-8");
		
		new Gson().toJson(scripts, response.getWriter());
	
	}

}
