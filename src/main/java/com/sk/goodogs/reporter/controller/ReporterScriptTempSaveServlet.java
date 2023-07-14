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
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FileRenamePolicy;
import com.sk.goodogs.news.model.service.NewsService;
import com.sk.goodogs.news.model.vo.NewsScript;

/**
 * Servlet implementation class ReporterScriptTempSaveServlet
 */
@WebServlet("/reporter/scriptTempSave")
public class ReporterScriptTempSaveServlet extends HttpServlet {
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
		String scriptWriter = multiReq.getParameter("scriptWriter");
		String scriptTitle = multiReq.getParameter("titleArea");
		String scriptCategory = multiReq.getParameter("category");
		String scriptContent = multiReq.getParameter("editordata");
		String scriptTag = multiReq.getParameter("newsTagList");
		
		
		NewsScript tempNewsScript = new NewsScript(0, scriptWriter, scriptTitle, scriptCategory, scriptContent, null, scriptTag, 0);
		
		System.out.println("newNewsScript = " +  tempNewsScript);
		
		int result = newsService.newsScriptTempSave(tempNewsScript);
		// 5개만 임시저장 되게 수정해야함
		
		
		String newsImage = multiReq.getFilesystemName("newsImage"); // 저장된 파일명 
		
		// 3. 응답처리 - 비동기식 POST요청은 redirect없이 결과값을 json으로 전송
		response.setContentType("application/json; charset=utf-8");
		
		Map<String, Object> map = new HashMap<>();
		map.put("message", "원고를 임시 저장했습니다.");
		new Gson().toJson(map, response.getWriter());
	}

}
