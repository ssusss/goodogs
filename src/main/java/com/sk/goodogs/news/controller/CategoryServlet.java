package com.sk.goodogs.news.controller;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sk.goodogs.news.model.service.NewsService;

/**
 * Servlet implementation class CategoryPoliticsServlet
 */
@WebServlet({
	"/tag/politics",
	"/tag/economy",
	"/tag/global",
	"/tag/tech",
	"/tag/environment",
	"/tag/sports",
	"/tag/society"
	})
public class CategoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final NewsService newsService = new NewsService();
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 현재 URL 가져오기
        String currentURL = request.getRequestURL().toString();
        String[] URLarr = currentURL.split("/");
        String tag = URLarr[URLarr.length - 1];
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

		
		int categoryContent = newsService.getContentByCategory(category);
		
		int limit = 5;
		int totalPage = (int) Math.ceil((double) categoryContent / limit);
		request.setAttribute("totalPage", totalPage);
		
		System.out.println("totalPage : " + totalPage);
		
		request.getRequestDispatcher("/WEB-INF/views/tag/" + tag + ".jsp")
			.forward(request, response);
		
	}

}