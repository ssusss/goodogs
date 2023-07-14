package com.sk.goodogs.news.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sk.goodogs.news.model.service.NewsService;

/***
 * @author 이혜령
 * 메인메뉴 페이지 구현
 */
@WebServlet("")
public class MainNewsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final NewsService newsService = new NewsService();
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int totalContent = newsService.getTotalContent();
		
		int limit = 5;
		int totalPage = (int) Math.ceil((double) totalContent / limit);
		request.setAttribute("totalPage", totalPage);
		
		System.out.println("toalPage : " + totalPage);
		
		request.getRequestDispatcher("/index.jsp")
			.forward(request, response);
		
	}

}
