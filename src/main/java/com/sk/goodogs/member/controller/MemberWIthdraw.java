package com.sk.goodogs.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sk.goodogs.member.model.service.MemberService;

/**
 * @author 이혜령
 * 회원탈퇴
 */
@WebServlet("/member/memberWithdraw")
public class MemberWIthdraw extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final MemberService memberService = new MemberService(); 

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
	
	}

}
