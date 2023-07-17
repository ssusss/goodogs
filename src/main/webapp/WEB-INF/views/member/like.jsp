<%@page import="com.sk.goodogs.like.model.vo.LikeList"%>
<%@page import="com.sk.goodogs.member.model.vo.Gender"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	// 전수경 - 좋아요 테이블에서 로그인 회원의 좋아요 기사 조회해오기 GET 요청
	List<LikeList> likes = (List<LikeList>) request.getAttribute("likes");
%>
<!-- CSS 스타일 시트 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/member.css" />

<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>
<!-- 
	@author 이혜령 
	- 좋아요 목록 페이지
	@author 전수경
	- 좋아요 목록리스트 갯수, 테이블 작성
-->
<script>
bannerContainerLower = document.querySelector(".bannerContainerLower");
bannerContainerLower.style.display = "none";
bannerContainerUpper = document.querySelector(".bannerContainerUpper");
bannerContainerUpper.style.display = "none";
</script>

<!-- 좋아요한 기사의 개수 -->
<section id=like-container>
	<br>
	<div>
		<p>이 기사 좋았개</p>
	</div>
<% if(likes.isEmpty() || likes == null) { %>
	<h1>아직 좋아요한 기사가 없개!</h1>
<% } else { %>
	<h1><%= likes.size() %>개의 기사에 좋아요 눌렀개!</h1>
<% } %>
</section>

<div class="tbl-likeContainer">
	<!-- 좋아요목록 테이블 -->
	<table class="tbl-like" id="tbl-like">
	  <thead>
		  <tr>
		  	<th>기사 번호</th>
		  	<th>기사 제목</th>
		  	<th>좋아요한 날짜</th>
		  </tr>
	  </thead>
	  <tbody>
	  <%
	  if(!likes.isEmpty()&& likes != null) {
	  	  for(LikeList like : likes) {
	  %>
	  	<tr>
			<td><%= like.getNewsNo() %></td>
			<td>
				<a href="<%= request.getContextPath()%>/news/newsDetail?no=<%= like.getNewsNo() %>"><%= like.getNewsTitle() %></a>
			</td>
			<td><%= like.getLikeDate() %></td>
	  	</tr> 
	  <% 
		  }
	  	} 
	  %>
	  </tbody>
	</table>
</div>

<section>
	  <%
	  if(!likes.isEmpty()&& likes != null) {
	  	  for(LikeList like : likes) {
	  %>
		<div class="posts">
		<!-- 뉴스 페이지로 연결 -->
		<a class="card" href="<%= request.getContextPath()%>/news/newsDetail?no=<%= like.getNewsNo() %>">
			<div class="card-inner">
				<figure class="card-thumbnail"> <!-- 기사 썸네일 -->
					<img src="<%= request.getContextPath() %>/images/character/goodogs_face.png">
				</figure>			
				<div class="card-body">
				<!-- 기사 제목/날짜/카테고리 박스 -->
					<h3 class="card-title"><%= like.getNewsTitle() %></h3> <!-- 기사 제목 -->
					<time class="card-date"><%= like.getLikeDate() %></time> <!-- 기사 날짜 -->
					<span class="card-category">학원</span> <!-- 기사 카테고리 -->
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