<%@page import="java.io.Console"%>
<%@page import="com.sk.goodogs.news.model.vo.NewsAndImage"%>
<%@page import="com.sk.goodogs.like.model.vo.LikeList"%>
<%@page import="com.sk.goodogs.news.model.vo.NewsComment"%>
<%@page import="java.util.List"%>
<%@page import="com.sk.goodogs.news.model.vo.News"%>
<%@page import="com.sk.goodogs.news.model.vo.NewsScript"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/news.css" />
<!--  기사 페이지  -->
<%
	NewsAndImage newsAndImage = (NewsAndImage) request.getAttribute("newsAndImage");

	String _category = "";
    
	switch (newsAndImage.getNewsCategory()) {
		case "정치" : _category = "politics"; break;
		case "경제" : _category = "economy"; break;
		case "세계" : _category = "global"; break;
		case "테크" : _category = "tech"; break;
		case "환경" : _category = "environment"; break;
		case "스포츠" : _category = "sports"; break;
		case "사회" : _category = "society"; break;
	}
	
	String tagArr[] = newsAndImage.getNewsTag().split(",");
%>
<!-- ----------------------------------------------------- -->	



<!-- ----------------------------------------------------- -->	
<!--  기사 가져오기 ( 완료 )   -->
<div id="newHeader">
	<h4 id="news-category" name="news-category" style="color: #008000">
		<a href="<%= request.getContextPath() %>/tag/<%= _category %>">
			<%=newsAndImage.getNewsCategory()%>
		</a>
	</h4> <!--  카테고리  -->

	<h1 id="news-title" name="news-title" ><%=newsAndImage.getNewsTitle() %></h1><!--  제목  -->
 	
 	<h4 id="news-confirmed-date" name="news-confirmed-date" ><%= newsAndImage.getNewsConfirmedDate().toString().split(" ")[0] %></h4>
</div>  

<section id="news-container">
	<div id="img-container">
		<img id="news-img" name="news-img" style="width: 600px;" src="<%= request.getContextPath() %>/upload/newsImage/<%=newsAndImage.getRenamedFilename()%>"><!--  이미지  -->
	</div>
							 
	<div id="news-content" name="news-content"><%=newsAndImage.getNewsContent()%></div><!--  내용  -->
	 
	<br/><br/><br/>
	<div id="news-tag-container">
		<div class="news-tag">
			<a href="<%= request.getContextPath() %>/tag/<%= _category %>">#<%= tagArr[0] %></a>
		</div>
		<% for (int i = 1; i < tagArr.length; i++) { %>
		<div class="news-tag">
			<a href="">#<%= tagArr[i] %></a>
		</div>
		<% } %>
	</div>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
