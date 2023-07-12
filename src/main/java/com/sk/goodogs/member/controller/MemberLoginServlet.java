package com.sk.goodogs.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sk.goodogs.member.model.service.MemberService;
import com.sk.goodogs.member.model.vo.Gender;
import com.sk.goodogs.member.model.vo.Member;

/**
 * Servlet implementation class MemberLoginServlet
 */
@WebServlet("/member/login")
public class MemberLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final MemberService memberService = new MemberService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		// 1. 사용자입력값 처리 (아이디, 비밀번호, saveId)
		String memberId = request.getParameter("memberId");
		String password = request.getParameter("password");
		String saveId = request.getParameter("saveId");
		
		// 2. 로그인 확인
		// 2.1) 아이디 일치 회원 조회
		// select * from member where member_id = ?
		Member member = memberService.findById(memberId);
		System.out.println("loginMember : "+ member);
		
		HttpSession session = request.getSession();
		
		// 2.2) 멤버 객체가 null이 아니고, 비밀번호가 일치한다면 세션에 loginMember 저장
		if(member != null && password.equals(member.getPassword())) {
			session.setAttribute("loginMember", member);
			
			// 아이디 저장 (쿠키 처리)
			Cookie cookie = new Cookie("saveId", memberId);
			cookie.setPath(request.getContextPath()); // 쿠키를 사용할 url
			if(saveId != null) {
				cookie.setMaxAge(60 * 60 * 24 * 7); // 쿠키 유효기간 7일
			}
			else {
				// 기존의 쿠키 삭제
				cookie.setMaxAge(0); // 클라이언트 있던 쿠기의 만료기간을 0으로 변경함과 동시에 삭제 
			}
			response.addCookie(cookie); // 응답 헤더 Set-Cookie : saveId=honggd
			
		} else {
			// 로그인 실패 시
		}
		
		// 3. 응답처리 (메인페이지로 리다이렉트)
		response.sendRedirect(request.getContextPath() + "/");
	}

}
