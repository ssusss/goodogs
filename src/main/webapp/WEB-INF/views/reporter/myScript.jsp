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
				<th>제출일자</th>
				<th>상태</th>
			</tr>
		</thead>
		<tbody id="scriptBodyList1">
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
		<tbody id="scriptBodyList2">
			
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
		<tbody id="scriptBodyList3">
			
		</tbody>
	</table>
</div>
<script>
			//=========== 아이디로 원고 전부 찾기 ============
			
	const findAllScriptById = () => {
		$.ajax({
			url: "<%= request.getContextPath() %>/reporter/reporterFindAllScript",
			dataType: "json",
			success(Scripts) {
				console.log(Scripts);

				const tbody = document.getElementById("scriptBodyList1");
				tbody.innerHTML = Scripts.reduce((html, newsScript) => {
					const { scriptNo, scriptTitle, scriptCategory, scriptWriteDate, scriptState } = newsScript;
					return (
						html +
						`
						<tr>
							<td>\${scriptNo}</td>
							<td>\${scriptTitle}</td>
							<td>\${scriptCategory}</td>
							<td>\${scriptWriteDate}</td>
							<td>\${scriptState}</td>
						</tr>
					`
					);
				}, "");
			},
		});
	};
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
