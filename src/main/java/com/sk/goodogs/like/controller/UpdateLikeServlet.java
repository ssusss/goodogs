package com.sk.goodogs.like.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sk.goodogs.like.model.service.LikeService;

/**
 * Servlet implementation class UpdateLikeServlet
 */
@WebServlet("/like/updateLike")
public class UpdateLikeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final LikeService likeService = new LikeService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 사용자 입력값 처리
		String method = request.getParameter("method");
		int newsNo = Integer.parseInt(request.getParameter("newsNo"));
		String memberId = request.getParameter("memberId");
		
		// method : insert / delete
		int result = likeService.updateLike(method, memberId, newsNo);
		
		// 요청응답
		response.setContentType("application/json; charset=utf-8"); // 헤더
		new Gson().toJson(result, response.getWriter()); // 바디
	}

}
