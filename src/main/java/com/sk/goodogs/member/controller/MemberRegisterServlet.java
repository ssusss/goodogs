package com.sk.goodogs.member.controller;

import java.io.IOException;

import java.io.IOException;
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
 * @author 전수경
 *  회원가입
 *
 */
@WebServlet("/member/memberRegister")
public class MemberRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final MemberService memberService = new MemberService();

	/**
	 * GET /member/memberRegister
	 *  - 회원가입 페이지 요청에 응답
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/member/memberRegister.jsp")
			.forward(request, response);
		
	}

	/**
	 * POST /member/memberRegister
	 *  - 멤버 테이블에 가입회원 정보 insert
	 *  - insert into member values(?, ?, ?, ?, ?, default, default, default, default);
	 *  - 아이디(이메일), 성별, 비밀번호, 닉네임, 전화번호, 가입일(기본), 역할(기본), 회원프로필(기본), 밴여부(기본))
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		// 1. 사용자 입력값 처리
		String memberId = request.getParameter("_memberId");
		String _password = request.getParameter("_password");
		// String password = HelloMvcUtils.getEncryptedPassword(request.getParameter("password"), memberId);
		String nickname = request.getParameter("nickname");
		String _gender = request.getParameter("gender");
		Gender gender = _gender != null ? Gender.valueOf(_gender) : null;
		String phone = request.getParameter("phone");
		
		// Member 객체 변환
		Member newMember = new Member(memberId, _password, nickname, phone, gender, null, null, null, 0);
		System.out.println("newMember : " + newMember);
		
		// 2. 업무로직 - db 저장 요청
		int result = memberService.insertMember(newMember);
		System.out.println("회원가입 완료! result="+result);
		
		// 결과메세지 속성 등록
		HttpSession session = request.getSession();
		session.setAttribute("message", "성공적으로 회원등록을 했습니다.");
		
		// 3. 인덱스 페이지 리다이렉트
		response.sendRedirect(request.getContextPath() + "/");
		
	}

}
