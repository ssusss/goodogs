package com.sk.goodogs.admin.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sk.goodogs.admin.model.service.AdminService;
import com.sk.goodogs.news.model.vo.NewsScript;
import com.sk.goodogs.news.model.vo.NewsScriptRejected;

/**
 * Servlet implementation class AdminScriptReject
 */
@WebServlet("/admin/script/reject")
public class AdminScriptReject extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final AdminService adminService= new AdminService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int no= Integer.valueOf(request.getParameter("no"));
		String rejectReason= request.getParameter("rejectReason").trim();
		
		System.out.println(no);
		System.out.println(rejectReason);
		
		NewsScript script=adminService.findOneScript(no);
		System.out.println(script);
		
		
		script.setScriptState(3);

		int result=adminService.scriptUpdate(script);
		int result1=adminService.addRejextReason(no,rejectReason);
		
		response.setContentType("application/json; charset=utf-8");
		Map<String, Object> map = new HashMap<>();
		map.put("message", "반려가 성공적으로 처리되었습니다.");
		
		new Gson().toJson(map, response.getWriter());
		
	}
	
}
