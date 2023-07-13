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
import com.sk.goodogs.member.model.vo.Member;
import com.sk.goodogs.news.model.service.NewsService;
import com.sk.goodogs.news.model.vo.News;

/**
 * 김준한 (기사찾는서블릿)
 */
@WebServlet("/reporter/reporterNewsFindAll")
public class MyNewsListFindAllServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final NewsService newsService = new NewsService();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Member loginMember = (Member) session.getAttribute("loginMember");
		
		System.out.println(loginMember);
		
		List<News> newsList = newsService.findAllNewsById(loginMember);
		
		response.setContentType("application/json; charset=utf-8");
		
		new Gson().toJson(newsList, response.getWriter());
		
	}

}
