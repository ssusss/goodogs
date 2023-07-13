package com.sk.goodogs.reporter.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sk.goodogs.news.model.service.NewsService;

/**
 * Servlet implementation class ReporterScriptServlet
 */
/**
 * @author 김준한 ㅋ
 *
 */
@WebServlet("/reporter/myScript")
public class ReporterMyScriptServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final NewsService newsService = new NewsService();
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		request.getRequestDispatcher("/WEB-INF/views/reporter/myScript.jsp").forward(request, response);
		
		
	}

	

}
