package com.sk.goodogs.news.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sk.goodogs.news.model.service.NewsService;
import com.sk.goodogs.news.model.vo.NewsComment;
import com.sk.goodogs.news.model.vo.NewsScript;

/**
 * @author 김나영 / 댓글 작성
 */
@WebServlet("/news/newsCommentCreate")
public class NewsCommentCreateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final NewsService newsService = new NewsService();

	/**
	 * @see 김나영 ㅇ뉴스 댓글 작성 
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 // 1. 사용자 입력값 처리	
		
		//   -- 댓글 넘버 / 기사 넘버 / 댓글 레벨 ( 1, 2 ) / 작성자 
		//  					/ (대댓글일경우 댓글넘버 참조값/댓글일시 null/ 닉네임 / 내용 / 시간 / 신고 수 / 게시상태
		
		
		//insert into news_comment values (comment_no.NEXTVAL, ? , ?, ? , ? , ? , ? , default , default , default);
		// 필요한 값은.,... 두근두근 
		// newsCommentLevel ,  newsNo,  newsCommentWriter. comment_no_ref ,  newsCommentNickname, newsCommentContent
		System.out.println(" 댓글 작성 중 ! ");
		
		 int newsCommentLevel  = Integer.parseInt( request.getParameter("newsCommentLevel"));
		 int newsNo  =  Integer.parseInt(request.getParameter("newsNo"));
		 String newsCommentWriter  = request.getParameter("newsCommentWriter");
		 String newsCommentNickname  = request.getParameter("newsCommentNickname");
		 String newsCommentContent  = request.getParameter("newsCommentContent");
		 int  commentNoRef  = Integer.parseInt(request.getParameter("commentNoRef"));
	
		NewsComment newsComment = new NewsComment( 0 , newsCommentLevel, newsNo, 
				newsCommentWriter, commentNoRef, 
				newsCommentNickname, newsCommentContent, null, 0, 0);
		
		System.out.println("newsComment = " +  newsComment);
		
		int result = newsService.newCommentInsert(newsComment);
		
//		System.out.println("newNewsScript = " +  newsComment);
		
		// 댓글 등록 실시간 알림
		response.sendRedirect(request.getContextPath() + "/news/newsDetail?no=" + newsNo);
		
      
	}

}
