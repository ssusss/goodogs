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
 * @author 전수경
 * - 뉴스의 좋아요 상태 확인
 */
@WebServlet("/like/checkLikeState")
public class CheckLikeStateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final LikeService likeService = new LikeService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 사용자 입력값 처리
		int newsNo = Integer.parseInt(request.getParameter("newsNo"));
		String memberId = request.getParameter("memberId");
		
		// 좋아요:1 , 좋아요안함:0
		int result = likeService.checkLikeState(memberId, newsNo);
		
		// 요청응답
		response.setContentType("application/json; charset=utf-8"); // 헤더
		new Gson().toJson(result, response.getWriter()); // 바디
		
	}

}
