<%@page import="com.sk.goodogs.bookmark.model.vo.Bookmark"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>

<%
	List<Bookmark> bookmarks = (List<Bookmark>) request.getAttribute("bookmarks");
%>
<!-- 
	@author 이혜령, 전수경
	- 북마크 목록 페이지
-->
<script>
bannerContainerLower = document.querySelector(".bannerContainerLower");
bannerContainerLower.style.display = "none";
bannerContainerUpper = document.querySelector(".bannerContainerUpper");
bannerContainerUpper.style.display = "none";
</script>

<section id=bookMark-container>
	<br>
		<h1>어떤 부분이 인상깊었개</h1>

	<% if(bookmarks.isEmpty() || bookmarks == null) { %>
	<h1>아직 북마크 한 기사가 없개!</h1>
	<% } else { %>
	<h1><%= bookmarks.size() %>개의 기사에 북마크 눌렀개!</h1>
	<% } %>
</section>

<section class="posts-container">
	<div class="posts">
	  <%
	  if(!bookmarks.isEmpty()&& bookmarks != null) {
	  	  for(Bookmark bookmark : bookmarks) {
	  %>
		<div class="card">
		<!-- 뉴스 페이지로 연결 -->
		<a href="<%= request.getContextPath()%>/news/newsDetail?no=<%= bookmark.getNewsNo() %>">
			<figure class="card-thumbnail"> <!-- 기사 썸네일 -->
				<img src="<%= request.getContextPath() %>/images/character/goodogs_face.png">
			</figure>			
			<div class="card-body">
				<!-- 기사 제목/날짜/카테고리 박스 -->
				<h3 class="card-title"><%= bookmark.getNews().getNewsTitle() %></h3> 
				<time class="card-date"><%= bookmark.getNews().getNewsConfirmedDate() %></time> 
				<span class="card-category"><%= bookmark.getNews().getNewsCategory() %></span> 
			</div>
		</a>	
	</div>
	  <% 
		  }
	  	} 
	  %>
	</div>
</section>






<%@ include file="/WEB-INF/views/common/footer.jsp" %>