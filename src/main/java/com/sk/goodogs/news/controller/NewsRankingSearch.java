package com.sk.goodogs.news.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sk.goodogs.news.model.service.NewsService;
import com.sk.goodogs.news.model.vo.News;

/**
 * Servlet implementation class NewsRankingSearch
 */
@WebServlet("/goodogs/ranking")
public class NewsRankingSearch extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final NewsService newsService = new NewsService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<News> news = newsService.findNewsRanking();
		
		response.setContentType("application/json; charset=utf-8");
		new Gson().toJson(news, response.getWriter());
		
	}

}
