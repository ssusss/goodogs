package com.sk.goodogs.admin.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sk.goodogs.admin.model.service.AdminService;
import com.sk.goodogs.admin.model.vo.Alarm;

/**
 * Servlet implementation class AdminAlarmCheckServlet
 */
@WebServlet("/alarm/check")
public class AdminAlarmCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final AdminService adminService = new AdminService();

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String memberId=request.getParameter("memberId");
		
		List<Alarm> alarms = adminService.checkById(memberId);
		System.out.println(memberId);
		System.out.println(alarms);
		

		response.setContentType("application/json; charset=utf-8");
		
		new Gson().toJson(alarms, response.getWriter());
	}

}
