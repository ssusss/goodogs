package com.sk.goodogs.reporter.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.sk.goodogs.news.model.service.NewsService;
import com.sk.goodogs.news.model.vo.News;

/**
 * Servlet implementation class ReporterMyNewsListServlet
 */
@WebServlet("/reporter/myNewsList")
public class ReporterMyNewsListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final NewsService newsService = new NewsService();
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("EasyLoginMember");
		
		System.out.println(memberId);
		
		List<News> newsList = newsService.findAll(memberId);
		
		response.setContentType("application/json; charset=utf-8");
		
		new Gson().toJson(newsList, response.getWriter());
		
//		request.getRequestDispatcher("/WEB-INF/views/reporter/myNewsList.jsp").forward(request, response);
	
	}
	
}	
	