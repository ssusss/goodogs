<%@page import="javax.sound.midi.SysexMessage"%>
<%@page import="com.sk.goodogs.news.model.vo.News"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>

<style>
h1 {text-align : center;}
table#tbl-news th, td { border: 1px solid black; padding: 3px; }
</style>


<script>
	bannerContainerLower = document.querySelector(".bannerContainerLower");
	bannerContainerLower.style.display = "none";
	bannerContainerUpper = document.querySelector(".bannerContainerUpper");
	bannerContainerUpper.style.display = "none";

	window.onload = () => {
		findAll();
	}


</script>

<div class="myPostList">
	<h1>기사 목록</h1>
	<table id ="tbl-news">
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
		</tbody>
	</table>
	
	</div>
	
	<script>
	const findAll = () => {
		$.ajax({
			url : "<%= request.getContextPath() %>/reporter/reporterNewsFindAll",
			dataType : "json",
			success(newsList){
				console.log(newsList);
				
				const tbody = document.querySelector(".myPostList table tbody");
				tbody.innerHTML = newsList.reduce((html, news)=> {
					const{newsNo, newsTitle, newsCategory, newsLikeCnt, newsReadCnt, newsConfirmedDate} = news;
					return html + `
						<tr>
							<td>\${newsNo}</td>
							<td>\${newsTitle}</td>
							<td>\${newsCategory}</td>
							<td>\${newsLikeCnt}</td>
							<td>\${newsReadCnt}</td>
							<td>\${newsConfirmedDate}</td>
						</tr>
					`;
				},"");
			}
		});
	}
	
	</script>
	
	
	
	
	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>


