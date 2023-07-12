package com.sk.goodogs.member.controller;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sk.goodogs.member.model.service.MemberService;
import com.sk.goodogs.member.model.vo.Member;

/**
 * @author 이혜령
 * 회원탈퇴
 */
@WebServlet("/member/memberWithdraw")
public class MemberWIthdraw extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final MemberService memberService = new MemberService(); 
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/member/memberWithdraw.jsp")
			.forward(request, response);
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1. 사용자 입력값 처리
		HttpSession session = request.getSession();
		Member loginMember = (Member) session.getAttribute("loginMember");
		String memberId = loginMember.getMemberId();
		
		// 2. 서비스 로직 호출
		int result = memberService.memberWithdraw(memberId);
		
		// 세션 속성 삭제
		Enumeration<String> names = session.getAttributeNames();
		while(names.hasMoreElements()) {
			String name = names.nextElement();
			session.removeAttribute(name);
		}
		
		// 쿠키 삭제
		Cookie cookie = new Cookie("saveId", memberId);
		cookie.setPath(request.getContextPath());
		cookie.setMaxAge(0);
		response.addCookie(cookie);
		
		// 3. 리다이렉트 처리
		session.setAttribute("msg", "다음에 다시만나개!");
		response.sendRedirect(request.getContextPath() + "/");
	}

}



