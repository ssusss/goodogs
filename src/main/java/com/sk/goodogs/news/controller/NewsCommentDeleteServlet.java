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
 * @author 김나영 / 댓글 삭제
 */
@WebServlet("/News/NewsCommentDelete")
public class NewsCommentDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final NewsService newsService = new NewsService();


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.err.println( "삭제!!!!!!!!" );
		

		 int commentState  = Integer.parseInt( request.getParameter("commentState"));
			System.err.println( "commentState!!!!!!!!" + commentState);
			
			 int Newsno  = Integer.parseInt( request.getParameter("newsNo"));
				System.err.println( "Newsno!!!!!!!!" + Newsno);
		 int commentNo  = Integer.parseInt( request.getParameter("commentNo"));
			System.err.println( "commentNo!!!!!!!!" + commentNo);

		
		int result = newsService.NewsCommentDelete(commentNo, commentState);
		

		request.getSession().setAttribute("msg", "댓글이 삭제되었습니다.");
		response.sendRedirect(request.getContextPath() + "/news/newsDetail?no=" + Newsno);
	}

}
