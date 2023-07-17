package com.sk.goodogs.bookmark.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sk.goodogs.bookmark.model.service.BookmarkService;
import com.sk.goodogs.bookmark.model.vo.Bookmark;
import com.sk.goodogs.member.model.vo.Member;

// do get VS do POST 차이
// get, post 같이쓰려면 url 공유
// get : dql (조회)
// post : dml (인서트/업데이트/딜리트)

/***
 * @author 이혜령, 전수경
 * 북마크 페이지 조회
 */
@WebServlet("/bookmark/bookmarkPage")
public class BookmarkPage extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final BookmarkService bookmarkService = new BookmarkService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 로그인 회원정보
		HttpSession session = request.getSession();
		Member loginMember = (Member) session.getAttribute("loginMember");
		String memberId = loginMember.getMemberId();
		
		// 북마크 리스트
		// 1) memberId로 회원의 북마크 조회
		List<Bookmark> bookmarks = (List<Bookmark>) bookmarkService.findBookmarksByMemberId(memberId);
		// 2) newsNo로 뉴스 조회 및 세팅
		
		
		request.setAttribute("bookmarks", bookmarks);
		request.getRequestDispatcher("/WEB-INF/views/member/bookMark.jsp").forward(request, response);
	}

}
