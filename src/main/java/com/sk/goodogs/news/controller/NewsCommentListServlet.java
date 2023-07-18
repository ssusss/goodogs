package com.sk.goodogs.news.controller;

import java.io.IOException;
import java.io.PrintWriter;
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
import com.sk.goodogs.news.model.vo.NewsComment;

/**
 *@author 김나영 / 댓글 가져옴 
 */
@WebServlet("/news/newsCommentList")
public class NewsCommentListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final NewsService newsService = new NewsService();


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("댓글  리스트");
		
		HttpSession session = request.getSession();
		
		int No = Integer.valueOf(request.getParameter("no"));
		System.out.println(No);
		
		List<NewsComment> newsComments  = newsService.findNewsComment(No);
			
		response.setContentType("application/json; charset=utf-8");
		request.setAttribute("newsComments", newsComments );
		
		
		new Gson().toJson(newsComments, response.getWriter());			
		
	}



}
