package com.sk.goodogs.like.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sk.goodogs.like.model.service.LikeService;
import com.sk.goodogs.like.model.vo.LikeListEntity;
import com.sk.goodogs.member.model.dao.MemberDao;
import com.sk.goodogs.member.model.vo.Member;


//do get VS do POST 차이
//get, post 같이쓰려면 url 공유
//get : dql (조회)
//post : dml (인서트/업데이트/딜리트)

/***
 * @author 이혜령
 * 좋아요 페이지 조회
 * @author 전수경
 * 좋아요 정보 가져오기, 응답
 */
@WebServlet("/like/likePage")
public class LikeListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public final LikeService likeService = new LikeService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 로그인회원정보 가져오기
		HttpSession session = request.getSession();
		Member loginMember = (Member) session.getAttribute("loginMember");
		String memberId = loginMember.getMemberId();
		
		// 2. 업무로직 좋아요리스트 가져오기
		List<LikeListEntity> likes = likeService.findLikesByMemberId(memberId);
		
		// 3. 응답처리
		request.setAttribute("likes", likes);
		request.getRequestDispatcher("/WEB-INF/views/common/like.jsp").forward(request, response);
	}

}
