package com.sk.goodogs.news.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *@author  김나영 / 좋아요 개수 업로드 서블렛
 */
@WebServlet("/news/newsCount")
public class NewsLikeCountServelt extends HttpServlet {
	private static final long serialVersionUID = 1L;
       


	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		int no = Integer.parseInt(request.getParameter("no"));
		
		BoardDAO manager = BoardDAO.getInstance();
		// 게시글 총 추천수를 구함
		
		int count = manager.recCount(no);
		// 뷰페이지(boardContent.jsp)에 추천수를 출력하도록 하는 역할
		out.println(count);
		out.close();
		
		return null;
	}

}
