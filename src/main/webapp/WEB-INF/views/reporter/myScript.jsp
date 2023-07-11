<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script>
bannerContainerLower = document.querySelector(".bannerContainerLower");
bannerContainerLower.style.display = "none";
</script>
<div class="myScriptList">
	<h1>원고 기사 목록</h1>
	<h3>반려된 원고</h3>
	<table>
		<thead>
			<tr>
				<th>기사번호</th>
				<th>제목</th>
				<th>카테고리</th>
				<th>제출일</th>
				<th>상태</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>1</td>
				<td>2</td>
				<td>3</td>
				<td>일자</td>
				<td>반려됨</td>
			</tr>
		</tbody>
	</table>
	<h3>임시저장 원고</h3>
	<table>
		<thead>
			<tr>
				<th>기사번호</th>
				<th>제목</th>
				<th>카테고리</th>
				<th>최종수정일</th>
				<th colspan="3">상태</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>1</td>
				<td>2</td>
				<td>3</td>
				<td>일자</td>
				<td>작성중</td>
				<td><button id = "scriptUpdate">이어쓰기</button></td>
				<td><button id = "scriptDelete">삭제</button></td>
			</tr>
		</tbody>
	</table>
	<h3>제출한 원고</h3>
	<table>
		<thead>
			<tr>
				<th>기사번호</th>
				<th>제목</th>
				<th>카테고리</th>
				<th>제출일자</th>
				<th>상태</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>1</td>
				<td>2</td>
				<td>3</td>
				<td>4</td>
				<td>제출됨</td>
			</tr>
		</tbody>
	</table>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>