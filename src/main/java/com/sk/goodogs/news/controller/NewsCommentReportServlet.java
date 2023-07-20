package com.sk.goodogs.news.controller;

import java.io.Console;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sk.goodogs.news.model.service.NewsService;

/**
 * @author 김나영 / 댓글 신고
 */
@WebServlet("/news/newsCommentReport")
public class NewsCommentReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final NewsService newsService = new NewsService();
       


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 사용자 입력값 처리
		 int commentNo  = Integer.parseInt( request.getParameter("commentNo"));
		String memberId = request.getParameter("memberId");
		System.out.println( " 확인하깅"  );
		
		// 
		int result = newsService.checkReport(memberId, commentNo);
		System.out.println( " 신고 여부 " + result );
		
		// 요청응답
		response.setContentType("application/json; charset=utf-8"); // 헤더
		new Gson().toJson(result, response.getWriter()); // 바디
		
	}


}
