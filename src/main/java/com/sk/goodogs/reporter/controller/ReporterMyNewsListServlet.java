package com.sk.goodogs.reporter.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ReporterMyNewsListServlet
 */
@WebServlet("/reporter/myNewsList")
public class ReporterMyNewsListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		System.out.println("asdasd");
		
		request.getRequestDispatcher("/WEB-INF/views/reporter/myNewsList.jsp").forward(request, response);
	}

}
