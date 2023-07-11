<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script>
bannerContainerLower = document.querySelector(".bannerContainerLower");
bannerContainerLower.style.display = "none";
</script>
<div class="myPostList">
	<h1>원고 기사 목록</h1>
	<ul>
		<li><a>링크1</a></li>
		<li><a>링크2</a></li>
	</ul>
	
	<table>
		<thead>
			<tr>
				<th>제목</th>
				<th>카테고리</th>
				<th>승인여부</th>
				<th>   </th>
			</tr>
		</thead>
		<tbody>
			
			<tr>
				<td>1</td>
				<td>2</td>
				<td>3</td>
				<td><button id = "delete">삭제</button></td>
			</tr>
		
		</tbody>
	</table>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>