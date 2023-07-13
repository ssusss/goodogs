package com.sk.goodogs.reporter.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.sk.goodogs.news.model.service.NewsService;
import com.sk.goodogs.news.model.vo.NewsScript;

/**
 * Servlet implementation class ScriptFindServlet
 */
@WebServlet("/reporter/scriptFind")
public class ReporterScriptListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final NewsService newsService = new NewsService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.getRequestDispatcher("/WEB-INF/views/myScript.jsp").forward(request, response);
		
	}

}
