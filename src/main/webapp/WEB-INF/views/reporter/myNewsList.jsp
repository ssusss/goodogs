<%@page import="com.sk.goodogs.news.model.vo.News"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<News> newsList = (List<News>)request.getAttribute("news");
%>
<script>
bannerContainerLower = document.querySelector(".bannerContainerLower");
bannerContainerLower.style.display = "none";
</script>
<div class="myPostList">
	<h1>기사 목록</h1>
	<table>
		<thead>
			<tr>
				<th>기사번호</th>
				<th>제목</th>
				<th>카테고리</th>
				<th>좋아요</th>
				<th>조회수</th>
				<th>게시일</th>
			</tr>
		</thead>
		<tbody>
		<%
			if(newsList != null && !newsList.isEmpty()){
				for(News news : newsList){
		%>
			<tr>
				<th><%= news.getNewsNo() %></th>
				<th><%= news.getNewsTitle() %></th>
				<th><%= news.getNewsCategory() %></th>
				<th><%= news.getNewsLikeCnt() %></th>
				<th><%= news.getNewsReadCnt() %></th>
				<th><%= news.getNewsConfirmedDate() %></th>
			</tr>
		<% 
				}
			}
			else {
		%>
			<tr>
				<td colspan="6">게시된 기사가 없습니다.</td>
			</tr>
		<% } %>
		</tbody>
	</table>
	
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>