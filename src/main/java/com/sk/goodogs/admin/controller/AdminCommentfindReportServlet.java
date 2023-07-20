package com.sk.goodogs.admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sk.goodogs.admin.model.service.AdminService;
import com.sk.goodogs.news.model.vo.NewsComment;

/**
 * Servlet implementation class AdminCommentfindReportSelected
 */
@WebServlet({ "/AdminCommentfindReportSelected", "/admin/CommentfindReport" })
public class AdminCommentfindReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final AdminService adminService = new AdminService();
	

	/**
	 * @author  김나영 / 댓글 목록에서 신고 조회 사용
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String searchType = request.getParameter("searchType");
		String searchKeyword = request.getParameter("searchKeyword");
		
		List<NewsComment> newsComments  = adminService.CommentfindReport(searchType, searchKeyword);
		System.out.println("newsComments = " + newsComments);
		request.setAttribute("newsComments", newsComments);
		
		// 3. 응답처리
		request.getRequestDispatcher("/WEB-INF/views/admin/adminMemberBanList.jsp")
		.forward(request, response);
		
		
	}

	
}
