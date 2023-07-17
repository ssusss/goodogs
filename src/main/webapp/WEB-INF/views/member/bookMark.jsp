<%@page import="com.sk.goodogs.bookmark.model.vo.Bookmark"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
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
	<div>
		<p>어떤 부분이 인상깊었개</p>
	</div>
	<br>
	<h1><%= bookmarks.size() %>개의 기사에 북마크 눌렀개!</h1>

</section>

<section>
	  <%
	  if(!bookmarks.isEmpty()&& bookmarks != null) {
	  	  for(Bookmark bookmark : bookmarks) {
	  %>
		<div class="posts">
		<!-- 뉴스 페이지로 연결 -->
		<a class="card" href="<%= request.getContextPath()%>/news/newsDetail?no=<%= bookmark.getNewsNo() %>">
			<div class="card-inner">
				<figure class="card-thumbnail"> <!-- 기사 썸네일 -->
					<img src="<%= request.getContextPath() %>/images/character/goodogs_face.png">
				</figure>			
				<div class="card-body">
				<!-- 기사 제목/날짜/카테고리 박스 -->
					<!-- 기사 제목 -->
					<h3 class="card-title"><%= bookmark.getNews().getNewsTitle() %></h3> 
					<!-- 기사 날짜 -->
					<time class="card-date"><%= bookmark.getNews().getNewsConfirmedDate() %></time> 
					<!-- 기사 카테고리 -->
					<span class="card-category"><%= bookmark.getNews().getNewsCategory() %></span> 
				</div>
			</div>
		</a>	
	</div>
	  <% 
		  }
	  	} 
	  %>
</section>






<%@ include file="/WEB-INF/views/common/footer.jsp" %>