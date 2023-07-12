package com.sk.goodogs.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sk.goodogs.member.model.service.MemberService;
import com.sk.goodogs.member.model.vo.Gender;
import com.sk.goodogs.member.model.vo.Member;

/**
 * @author 이혜령
 * 내 정보 수정
 */
@WebServlet("/member/memberUpdate")
public class MemberUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final MemberService memberService = new MemberService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 사용자 입력값 처리
		String memberId = request.getParameter("memberId");
		String password = request.getParameter("password");
		String nickName = request.getParameter("nickName");
		String phone = request.getParameter("phone");
		
		String _gender = request.getParameter("gender");
		Gender gender = _gender != null? Gender.valueOf(_gender) : null;
		
		// Member 객체로 변환
		Member member = new Member(memberId, password, nickName, phone, gender);
		
		// 업무로직
		int result = memberService.memberUpdate(member);
		HttpSession session = request.getSession();
		session.setAttribute("loginMember", memberService.findById(memberId));
		
		// 사용자 피드백 및 리다이렉트 처리
		session.setAttribute("msg", "회원정보를 수정했개!");
		
		response.sendRedirect(request.getContextPath() + "/member/memberInfo");
		
		
	}

}
