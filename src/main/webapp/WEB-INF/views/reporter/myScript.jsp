<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script>
bannerContainerLower = document.querySelector(".bannerContainerLower");
bannerContainerLower.style.display = "none";
</script>
<div class="myScriptList">
	<div class="scriptContainer1">
		<table>
			<thead>
				<tr>
					<th>기사번호</th>
					<th>기사제목</th>
					<th>기사카테고리</th>
					<th>작성일</th>
					<th>이어쓰기</th>
				</tr>
				<tr>
					<td rowspan="5">임시저장한 원고가 없습니다.</td>
				</tr>
			</thead>
			<tbody>
			
			</tbody>
		</table>
	</div>
	<div class="scriptContainer2">
		
	</div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>