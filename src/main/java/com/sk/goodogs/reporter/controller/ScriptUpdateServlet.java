package com.sk.goodogs.reporter.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sk.goodogs.news.model.service.NewsService;
import com.sk.goodogs.news.model.vo.NewsScript;

/**
 * 김준한 ㅋ
 */
@WebServlet("/reporter/scriptUpdate")
public class ScriptUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final NewsService newsService = new NewsService();
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		int scriptNo = Integer.parseInt(request.getParameter("scriptNo"));
		NewsScript newsScript = newsService.findByScriptNo(scriptNo);
		
		
		session.setAttribute("newsScript", newsScript);

	    // 페이지로 이동
	    RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/reporter/scriptWrite.jsp");
	    dispatcher.forward(request, response);
		
	}

}
