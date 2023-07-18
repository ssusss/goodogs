package com.sk.goodogs.news.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sk.goodogs.news.model.service.NewsService;
import com.sk.goodogs.news.model.vo.News;

/**
 * Servlet implementation class AutocompleteServlet
 */
@WebServlet("/news/csv/autocomplete")
public class AutocompleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final NewsService newsService = new NewsService();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String term = request.getParameter("term");
		System.out.println("term = " + term);
		
		List<News> results = newsService.findByNewsName(term);
		
		response.setContentType("text/csv; charset=utf-8");
		PrintWriter out = response.getWriter();
		if(results != null && !results.isEmpty()) {
			for(int i = 0; i < results.size(); i++) {
				News News = results.get(i);
				out.append(News.getNewsTitle());
				if(i != results.size() - 1) 
					out.append("$");
			}
		}
		
	}

}
