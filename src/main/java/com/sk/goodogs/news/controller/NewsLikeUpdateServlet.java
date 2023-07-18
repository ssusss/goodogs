package com.sk.goodogs.news.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.sk.goodogs.member.model.vo.Member;
import com.sk.goodogs.news.model.service.NewsService;

/**
 * @author  김나영
 * 좋아요 클릭 
 * 
 */
@WebServlet("/news/newsLikeupdate")
public class NewsLikeUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final NewsService newsService = new NewsService();


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		
		request.setCharacterEncoding("utf-8");
		
		// 로그인회원정보 가져오기
		HttpSession session = request.getSession();
		Member loginMember = (Member) session.getAttribute("loginMember");
		String memberId = loginMember.getMemberId();
		int newsNo  =  Integer.parseInt(request.getParameter("newsNo"));
		

		//( 로그인 회원정보 아이디 와 뉴스 아이디를 조회 ) // 동일 게시글에 대한 이전 추천 여부 검색
		
		// 0. 기존 좋아요 정보 조회
		
		int result = newsService.checkLike(memberId,newsNo);
		
		
		if(result == 0){ //  좋아요 조회 안되면  추가
			
			newsService.updateLike(loginMember,newsNo); // <-- 좋아요 추가 
			
		}else{ // 좋아요 조회시 추천 삭제
			
			newsService.deleteLike(loginMember,newsNo);; // // <-- 좋아요 삭제
			
		}
		
		
		response.setContentType("application/json; charset=utf-8");
		Map<String, Object> map = new HashMap<>();
		
		new Gson().toJson(map, response.getWriter());
		
		

	}

}
