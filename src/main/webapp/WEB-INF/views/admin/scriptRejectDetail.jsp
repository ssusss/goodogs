<%@page import="com.sk.goodogs.news.model.vo.NewsImage"%>
<%@page import="com.sk.goodogs.news.model.vo.NewsScriptRejected"%>
<%@page import="java.util.Date"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.sk.goodogs.news.model.vo.NewsScript"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	NewsScriptRejected script=(NewsScriptRejected)request.getAttribute("rejectedScript");
	NewsImage image = (NewsImage)request.getAttribute("image");
	
	String _category = "";
    
	switch (script.getScriptCategory()) {
		case "정치" : _category = "politics"; break;
		case "경제" : _category = "economy"; break;
		case "세계" : _category = "global"; break;
		case "테크" : _category = "tech"; break;
		case "환경" : _category = "environment"; break;
		case "스포츠" : _category = "sports"; break;
		case "사회" : _category = "society"; break;
	}
	
	String tagArr[] = script.getScriptTitle().split(",");
%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/news.css" />
<script>
	const bannerContainerLower = document.querySelector(".bannerContainerLower");
	bannerContainerLower.style.display = "none";
</script>
<style>
	.adminComent {
		display: none;
	}

</style>
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>

<div id="newHeader">
	<h4 id="news-category" name="news-category" style="color: #008000">
		<a href="">
			<%=script.getScriptCategory()%>
		</a>
	</h4> <!--  카테고리  -->

	<h1 id="news-title" name="news-title" ><%=script.getScriptTitle() %></h1><!--  제목  -->
 	
 	<h4 id="news-confirmed-date" name="news-confirmed-date" ><%= script.getScriptWriteDate().toString().split(" ")[0] %></h4>
</div>  

<section id="news-container">
	<div id="img-container">
		<img id="news-img" name="news-img" style="width: 600px;" src="<%= request.getContextPath() %>/upload/newsImage/<%=image.getRenamedFilename()%>"><!--  이미지  -->
	</div>
							 
	<div id="news-content" name="news-content"><%=script.getScriptContent()%></div><!--  내용  -->
	 
	<br/><br/><br/>
	<div id="news-tag-container">
		<div class="news-tag">
			<a href="<%= request.getContextPath() %>/tag/<%= _category %>">#<%= tagArr[0] %></a>
		</div>
		<% for (int i = 1; i < tagArr.length; i++) { %>
		<div class="news-tag">
			<a href="<%=request.getContextPath()%>/search/news/?keyword=<%= tagArr[i] %>">#<%= tagArr[i] %></a>
		</div>
		<% } %>
		
	</div>
	<br>
	<br>
	<br>
	<div class="rejectedReasonContainer">
		<h2>반려사유</h2>
		<h3> <%= script.getRejectedReson() %></h3>
	</div>
	

</section>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>