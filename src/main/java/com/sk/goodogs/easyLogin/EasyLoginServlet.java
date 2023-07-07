package com.sk.goodogs.easyLogin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class EasyLoginServlet
 */
@WebServlet("/easyLogin")
public class EasyLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String memberRole = request.getParameter("radio-group");
		System.out.println(memberRole);
		
		HttpSession session = request.getSession();
		session.setAttribute("EasyLoginMember", memberRole);
		
		response.sendRedirect(request.getContextPath() + "/");
	}

}
