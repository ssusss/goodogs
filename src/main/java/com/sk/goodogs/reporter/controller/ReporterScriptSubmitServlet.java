package com.sk.goodogs.reporter.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FileRenamePolicy;
import com.sk.goodogs.news.model.service.NewsService;

/**
 * Servlet implementation class ReporterScriptSubmitServlet
 */
@WebServlet("/reporter/scriptSubmit")
public class ReporterScriptSubmitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final NewsService newsService = new NewsService();

	/**
	 * 동찬
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 0. MultipartRequest객체 생성
		String saveDirectory = getServletContext().getRealPath("/images");
		int maxPostSize = 1024 * 1024 * 10; 
		String encoding = "utf-8";
		FileRenamePolicy policy = new DefaultFileRenamePolicy();
		MultipartRequest multiReq = 
			new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
		
		// 1. 사용자입력값 처리
		String scriptWriter = "asd";
		String scriptTitle = multiReq.getParameter("titleArea");
		String scriptCategory = multiReq.getParameter("category");
		String scriptContent = multiReq.getParameter("category");
		String newsImage = multiReq.getFilesystemName("newsImage"); // 저장된 파일명 
		
	}

}
