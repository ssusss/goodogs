package com.sk.goodogs.news.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sk.goodogs.news.model.service.NewsService;

/**
 * @author 나영 / 신고 하는 메소드
 */
@WebServlet("/NewsCommentReportUpdate")
public class NewsCommentReportUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final NewsService newsService = new NewsService();
	  
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 사용자 입력값 처리
		 int commentNo  = Integer.parseInt( request.getParameter("commentNo"));
		String memberId = request.getParameter("memberId");
		
		
		// method : insert / delete
		int result = newsService.updateReport( memberId, commentNo);
		
		// 요청응답
		response.setContentType("application/json; charset=utf-8"); 
		
		new Gson().toJson(result, response.getWriter()); 
	
	}

}
