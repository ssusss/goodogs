package com.sk.goodogs.bookmark.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.sk.goodogs.bookmark.model.service.BookmarkService;
import com.sk.goodogs.member.model.vo.Member;
import com.sk.goodogs.news.model.service.NewsService;

/**
 * @author 전수경
 * - 북마크 DB에 추가
 */
@WebServlet("/bookmark/bookmarkInsert")
public class InsertBookmarkServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final BookmarkService bookmarkService = new BookmarkService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 사용자입력정보 처리
		HttpSession session = request.getSession();
		Member loginMember = (Member) session.getAttribute("loginMember");
		String memberId = loginMember.getMemberId();
		int newsNo = Integer.parseInt(request.getParameter("newsNo"));
		String newsTitle = request.getParameter("newsTitle");
		String bookmarkedContent = request.getParameter("bookmarkedContent");
		
		// System.out.println("bookmarkedContent" + bookmarkedContent);
		
		// 업무로직 (dml - insert)
		int result = bookmarkService.insertBookmark(memberId, newsNo, newsTitle, bookmarkedContent);
		
		// 요청응답 (json)
		response.setContentType("application/json; charset=utf-8"); // 헤더
		new Gson().toJson(result, response.getWriter()); // 바디
	}

}
