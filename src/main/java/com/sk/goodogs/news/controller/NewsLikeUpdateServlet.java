package com.sk.goodogs.news.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sk.goodogs.news.model.service.NewsService;

/**
 * @author 김나영 / 좋아요 리스트 
 */
@WebServlet("/news/newsLikeUpdate")
public class NewsLikeUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final NewsService newsService = new NewsService();


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.err.println("ㅈㅎ아");
		int newsNo = Integer.parseInt(request.getParameter("newsNo"));
		System.out.println(newsNo);
		
		
		int result = newsService.newsLikeUpdate(newsNo);
		
		response.setContentType("application/json; charset=utf-8");
		Map<String, Object> map = new HashMap<>();
		
		new Gson().toJson(map, response.getWriter());

	}

}
