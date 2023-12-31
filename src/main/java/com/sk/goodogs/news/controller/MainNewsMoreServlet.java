package com.sk.goodogs.news.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.sk.goodogs.news.model.service.NewsService;
import com.sk.goodogs.news.model.vo.News;
import com.sk.goodogs.news.model.vo.NewsAndImage;

/***
 * @author 이혜령
 * 메인메뉴 더보기 페이지 구현
 */
@WebServlet("/goodogs/more")
public class MainNewsMoreServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
   private final NewsService newsService = new NewsService();
   private final int LIMIT = 12;
   /**
    * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
    */
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
      // 1. 사용자 입력값 처리
      int cpage = 1;
      
      try {
         cpage = Integer.parseInt(request.getParameter("cpage"));
      } catch(NumberFormatException e) {
      }
      
      int start = (cpage - 1) * LIMIT + 1;
      int end = cpage * LIMIT;
      
      // 2. 업무로직 (
      List<NewsAndImage> newsAndImages = newsService.findNews(start, end);
//      System.out.println("newsAndImage : " + newsAndImages);
      
      // 3. 응답처리 (json)
      response.setContentType("application/json; charset=utf-8");
      new Gson().toJson(newsAndImages, response.getWriter());
   }

}