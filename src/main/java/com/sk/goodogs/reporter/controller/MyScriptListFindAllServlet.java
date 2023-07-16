package com.sk.goodogs.reporter.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.sk.goodogs.member.model.vo.Member;
import com.sk.goodogs.news.model.service.NewsService;
import com.sk.goodogs.news.model.vo.NewsScript;

/**
 * 김준한 ㅋ
 */
@WebServlet("/reporter/reporterFindAllScript")
public class MyScriptListFindAllServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final NewsService newsService = new NewsService();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Member loginMember = (Member)session.getAttribute("loginMember");
		
		
		List<NewsScript> scripts =  newsService.findAllScriptById(loginMember);
		
		System.out.println(scripts);
		

		response.setContentType("application/json; charset=utf-8");
		
		new Gson().toJson(scripts,response.getWriter());
		
		
		
	}

}
