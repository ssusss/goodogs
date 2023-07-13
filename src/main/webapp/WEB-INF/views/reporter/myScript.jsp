<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>

<script>
	bannerContainerLower = document.querySelector(".bannerContainerLower");
	bannerContainerLower.style.display = "none";
	
	window.onload = () => {
		findAllScriptById();
	}
</script>

<div class="myScriptList">
	<h1>원고 기사 목록</h1>
	<h3>반려된 원고</h3>
	<table id="tbl-script1">
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
		</tbody>
	</table>
</div>
<div class="myScriptList2">
	<h3>임시저장 원고</h3>
	<table id="tbl-script2">
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
				<td><button id="scriptUpdate">이어쓰기</button></td>
				<td><button id="scriptDelete">삭제</button></td>
			</tr>
		</tbody>
	</table>
</div>

<div class = "myScriptList3">
	<h3>제출한 원고</h3>
	<table id="tbl-script3">
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
<script>
	const findAllScriptById = () => {
		$.ajax({
			url: "<%= request.getContextPath() %>/reporter/reporterFindAllScript",
			dataType: "json",
			success(Scripts) {
				console.log(Scripts);

				const tbody = document.querySelector(".myScriptList table tbody");
				tbody.innerHTML = Scripts.reduce((html, newsScript) => {
					const { scriptNo, scriptTitle, scriptCategory, scriptWriteDate, scriptState } = newsScript;
					return (
						html +
						`
						<tr>
							<td>${scriptNo}</td>
							<td>${scriptTitle}</td>
							<td>${scriptCategory}</td>
							<td>${scriptState}</td>
							<td>${scriptState}</td>
						</tr>
					`
					);
				}, "");
			},
		});
	};
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
