package com.sk.goodogs.admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sk.goodogs.admin.model.service.AdminService;
import com.sk.goodogs.common.util.AdminMvcUtils;
import com.sk.goodogs.news.model.vo.NewsComment;

/**
 * Servlet implementation class MemberBanListServlet
 */
@WebServlet("/admin/adminMemberBanList")
public class AdminMemberBanListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final AdminService adminService = new AdminService();
	private final int LIMIT = 5; 

	/**
	 * @author na0 ( 페이지 로딩바 / 벤 리스트 가져오기 ) 
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		
		//1. 입력값 처리 
		int cpage = 1; 
		try {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}catch (NumberFormatException  e) {
			// 예외처리 없음
		}
		int start = (cpage - 1) * LIMIT + 1;
		int end = cpage * LIMIT;
		
		
		// 2, 업무로직
		List<NewsComment> newsComments  = adminService.findBanComment(start, end);
		System.out.println("newsComments = " + newsComments);
		request.setAttribute("newsComments", newsComments);
		

		int totalContent = adminService.getTotalContent();
		System.out.println("totalContent = " + totalContent);
		String url = request.getRequestURI(); // /mvc/board/boardList
		String pagebar = AdminMvcUtils.getPagebar(cpage, LIMIT, totalContent, url);
		System.out.println("pagebar = " + pagebar);
		
		request.setAttribute("pagebar", pagebar);
		
		
		// 3. 응답처리
		request.getRequestDispatcher("/WEB-INF/views/admin/adminMemberBanList.jsp")
		.forward(request, response);
	}



}
