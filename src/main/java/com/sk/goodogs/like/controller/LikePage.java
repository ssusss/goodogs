package com.sk.goodogs.like.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


//do get VS do POST 차이
//get, post 같이쓰려면 url 공유
//get : dql (조회)
//post : dml (인서트/업데이트/딜리트)

/***
 * @author 이혜령
 * 좋아요 페이지 조회
 */

@WebServlet("/like/likePage")
public class LikePage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/common/like.jsp").forward(request, response);
	}

}
