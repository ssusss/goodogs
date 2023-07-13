package com.sk.goodogs.reporter.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sk.goodogs.news.model.service.NewsService;

/**
 * 김준한 ㅋ
 */
@WebServlet("/reporter/scriptUpdate")
public class ScriptUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final NewsService newsService = new NewsService();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int scriptNo = Integer.parseInt(request.getParameter("scriptNo"));
//		int result = newsService.scriptUpdate(scriptNo);
		
		response.setContentType("application/json; charset=utf-8");
		
	}

}
