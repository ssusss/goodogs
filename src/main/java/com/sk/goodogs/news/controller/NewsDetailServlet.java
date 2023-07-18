package com.sk.goodogs.news.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;import com.sk.goodogs.like.model.service.LikeService;
import com.sk.goodogs.member.model.vo.Member;
import com.sk.goodogs.news.model.service.NewsService;
import com.sk.goodogs.news.model.vo.News;
import com.sk.goodogs.news.model.vo.NewsAndImage;
import com.sk.goodogs.news.model.vo.NewsComment;

/**
 *@author  김나영 뉴스 페이지
 */
@WebServlet( {"/news/newsDetail" , "/news/adminlink/newsDetail"})
public class NewsDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final NewsService newsService = new NewsService();
	private final LikeService likeService = new LikeService();


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		int No = Integer.valueOf(request.getParameter("no"));
		System.out.println("기사  리스트");

		NewsAndImage newsAndImage = newsService.newsDetail(No);
		request.setAttribute("newsAndImage", newsAndImage );

		// 뉴스 좋아요수 세팅 (전수경)
		
		newsAndImage.setNewsLikeCnt(likeService.getNewsLikeCnt(No));

		response.setContentType("application/json; charset=utf-8");
		
		
//		List<NewsComment> newsComments  = newsService.findNewsComment(No);
//		request.setAttribute("newsComments", newsComments);
		
		request.getRequestDispatcher("/WEB-INF/views/news/newsDetail.jsp")
		.forward(request, response);
	}


}
