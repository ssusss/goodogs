package com.sk.goodogs.news.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class KeywordServlet
 */
@WebServlet("/search/news/*")
public class KeywordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		int keywordContent = 0;
		
		
		int limit = 5;
		int totalPage = (int) Math.ceil((double) keywordContent / limit);
		request.setAttribute("totalPage", totalPage);
		
		System.out.println("totalPage : " + totalPage);
		
		request.getRequestDispatcher("/WEB-INF/views/search/searchKeyword.jsp").forward(request, response);
	}

}
