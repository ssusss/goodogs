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
import com.sk.goodogs.news.model.vo.NewsAndImage;

/**
 * Servlet implementation class CategoryMoreServlet
 */
@WebServlet({
		"/more/politics",
		"/more/economy",
		"/more/global",
		"/more/tech",
		"/more/environment",
		"/more/sports",
		"/more/society"
		})
public class CategoryMoreServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final NewsService newsService = new NewsService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 현재 URL 가져오기
        String currentURL = request.getRequestURL().toString();
        String[] URLarr = currentURL.split("/");
        System.out.println("tag = " + URLarr[URLarr.length - 1]);
        
        String category = "";
        
		switch (URLarr[URLarr.length - 1]) {
			case "politics" : category = "정치"; break;
			case "economy" : category = "경제"; break;
			case "global" : category = "세계"; break;
			case "tech" : category = "테크"; break;
			case "environment" : category = "환경"; break;
			case "sports" : category = "스포츠"; break;
			case "society" : category = "사회"; break;
		}
		
		// 1. 사용자 입력값 처리
		int limit = 5;
		int cpage = 1;
		
		try {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		} catch(NumberFormatException e) {
		}
		
		int start = (cpage - 1) * limit + 1;
		int end = cpage * limit;
		
		// 2. 업무로직 (
		List<NewsAndImage> newsAndImages = newsService.findNewsByCategory(start, end, category);
		System.out.println("newsAndImages : " + newsAndImages);
		
		// 3. 응답처리 (json)
		response.setContentType("application/json; charset=utf-8");
		new Gson().toJson(newsAndImages, response.getWriter());
	}

}