package com.sk.goodogs.like.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sk.goodogs.like.model.service.LikeService;
import com.sk.goodogs.like.model.vo.LikeList;
import com.sk.goodogs.like.model.vo.LikeListEntity;
import com.sk.goodogs.member.model.dao.MemberDao;
import com.sk.goodogs.member.model.vo.Member;
import com.sk.goodogs.news.model.service.NewsService;
import com.sk.goodogs.news.model.vo.News;


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
	public final NewsService newsService = new NewsService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 로그인회원정보 가져오기
		HttpSession session = request.getSession();
		Member loginMember = (Member) session.getAttribute("loginMember");
		String memberId = loginMember.getMemberId();
		
		// 2. 업무로직 좋아요리스트 가져오기
		List<LikeListEntity> _likes = likeService.findLikesByMemberId(memberId);
		List<LikeList> likes = new ArrayList<>();
		for(LikeListEntity entity : _likes) {
			// 기사 넘버로 기사 가져오기
			int newsNo = entity.getNewsNo();
			Timestamp likeDate = entity.getLikeDate();
			News news = newsService.findNewsByNewsNo(newsNo);
			String newsTitle = news.getNewsTitle();
			likes.add(new LikeList(memberId, newsNo, likeDate, newsTitle));
		}
		
		// 3. 응답처리
		request.setAttribute("likes", likes);
		request.getRequestDispatcher("/WEB-INF/views/member/like.jsp").forward(request, response);
	}

}
