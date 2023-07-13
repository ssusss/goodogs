package com.sk.goodogs.reporter.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sk.goodogs.news.model.service.NewsService;

/**
 * 김준한 ㅋ
 */
@WebServlet("/reporter/scriptDelete")
public class ScriptDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final NewsService newsService = new NewsService();

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int scriptNo = Integer.parseInt(request.getParameter("scriptNo"));
		System.out.println(scriptNo);
		int result = newsService.scriptDelete(scriptNo);
		
		response.setContentType("application/json; charset=utf-8");
		Map<String, Object> map = new HashMap<>();
		map.put("message", "성공적으로 삭제 했습니다.");
		
		new Gson().toJson(map, response.getWriter());
		
	}
	
}
