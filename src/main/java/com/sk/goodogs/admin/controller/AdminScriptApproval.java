package com.sk.goodogs.admin.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.sk.goodogs.admin.model.service.AdminService;
import com.sk.goodogs.news.model.vo.News;
import com.sk.goodogs.news.model.vo.NewsScript;

/**
 * Servlet implementation class AdminScriptApproval
 */
@WebServlet("/admin/script/approval")
public class AdminScriptApproval extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final AdminService adminservice= new AdminService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		BufferedReader reader = request.getReader();
		
		if (reader != null) {
			String json = reader.lines().collect(Collectors.joining());
        
			Gson gson = new GsonBuilder().setDateFormat("MMM dd, yyyy").create();
			NewsScript script = gson.fromJson(json, NewsScript.class);
			
			script.setScriptState(2);

			int result=adminservice.scriptUpdate(script);
			
			response.setContentType("application/json; charset=utf-8");
			Map<String, Object> map = new HashMap<>();
			map.put("message", "승인이 성공적으로 처리되었습니다.");
			
			new Gson().toJson(map, response.getWriter());
			
			
		}
		
	}

}
