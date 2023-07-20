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

/**
 * Servlet implementation class AdminAlarmReadServlet
 */
@WebServlet({"/alarm/alarmChecked","/alarm/liveAlarmChecked"})
public class AdminAlarmReadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final AdminService adminService = new AdminService();


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String memberId=request.getParameter("memberId");
		System.out.println(memberId);
		if(memberId.equals("비로그인")) 
			return;
		
		int result = adminService.alarmUpdate(memberId);
		System.out.println("%%%%%%%%%%%%%%%%%%%"+result);
		
		
		response.setContentType("application/json; charset=utf-8");
		Map<String,Object> map = new HashMap<>();
		map.put("result","성공");
		
		new Gson().toJson(map, response.getWriter());
		
	}

}
