package com.sk.goodogs.news.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sk.goodogs.news.model.service.NewsService;

/**
 * @author 김나영 / 관리자 뉴스 삭제 테이블
 */
@WebServlet("/News/NewsDelete")
public class NewsAdminDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final NewsService newsService = new NewsService();
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 파라미터값 가져오기
		int Newsno = Integer.parseInt(request.getParameter("Newsno"));
	
	
		//2. 비지니스로직 호출
		int result = newsService.NewsAdminDelete(Newsno);		
		
		//3. 리다이렉트
		request.getSession().setAttribute("msg", "뉴스가 삭제되었습니다.");
		response.sendRedirect(request.getContextPath() + "/board/boardDetail?no=" + Newsno);

	
	
	}

}
