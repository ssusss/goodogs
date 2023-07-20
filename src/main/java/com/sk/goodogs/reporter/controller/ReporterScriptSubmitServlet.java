package com.sk.goodogs.reporter.controller;

import java.io.File;
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
import com.sk.goodogs.common.GoodogsFileRenamePolicy;
import com.sk.goodogs.news.model.service.NewsService;
import com.sk.goodogs.news.model.vo.NewsImage;
import com.sk.goodogs.news.model.vo.NewsScript;

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
		String saveDirectory = getServletContext().getRealPath("/upload/newsImage");
		int maxPostSize = 1024 * 1024 * 10; 
		String encoding = "utf-8";
		FileRenamePolicy policy = new GoodogsFileRenamePolicy();
		
		MultipartRequest multiReq = 
			new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
		
		// 1. 사용자입력값 처리
		String scriptWriter = multiReq.getParameter("scriptWriter");
		String scriptTitle = multiReq.getParameter("titleArea");
		String scriptCategory = multiReq.getParameter("category");
		String scriptContent = multiReq.getParameter("editordata");
		String scriptTag = multiReq.getParameter("newsTagList");
		
		NewsScript newNewsScript = new NewsScript(0, scriptWriter, scriptTitle, scriptCategory, scriptContent, null, scriptTag, 0);
		
		System.out.println("newNewsScript = " +  newNewsScript);
		
		int result1 = newsService.newsScriptSubmit(newNewsScript);
		
		// 첨부파일로 Newsimage 객체 생성
		String image = multiReq.getFilesystemName("newsImage"); // 저장된 파일명 
		System.out.println(image);
		
		
//		File newsImage = multiReq.getFile("newsImage");
//		System.out.println(newsImage);
		
		// 1. 뉴스이미지 (스크립스 넘버 가져와서) 객체 생성 
		int lastScriptNo = newsService.getLastScriptNo();
		
//		System.out.println(lastScriptNo);
		
		NewsImage newsImage_ = new NewsImage(lastScriptNo, null, null, null);
		newsImage_.setOriginalFilename(multiReq.getOriginalFileName("newsImage"));
		newsImage_.setRenamedFilename(multiReq.getFilesystemName("newsImage"));
		System.out.println("이거 되는거냐?"+newsImage_);
		
		// 2. 업무로직 - db저장
		int result = newsService.insertnewsImage(newsImage_);
		
//		System.out.println("newNewsScript = " +  newNewsScript);
		// 3. 응답처리 - 비동기식 POST요청은 redirect없이 결과값을 json으로 전송
		response.setContentType("application/json; charset=utf-8");
		
		String newNewsScriptNo= String.valueOf(newNewsScript.getScriptNo());
		System.out.println(newNewsScriptNo+"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		Map<String, Object> map = new HashMap<>();
		map.put("message", "성공적으로 원고를 제출했습니다.");
		map.put("newNewsScriptNo", newNewsScriptNo);
		new Gson().toJson(map, response.getWriter());
	}

}