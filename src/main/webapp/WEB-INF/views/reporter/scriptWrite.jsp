<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reporter.css" />
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>
<script>
bannerContainerLower = document.querySelector(".bannerContainerLower");
bannerContainerLower.style.display = "none";
</script>
<style>
#contentArea {
	color: red;
}
</style>
<form name="scriptWriteFrm">
	<div class="myScriptWrite">
		<div class="titleAreaContanier">
			<label for="titleArea">뉴스 제목 : </label>
			<input type="text" name="titleArea" id="titleArea"/>
		</div>
	
		<label for="newsImage">뉴스 이미지 첨부 : </label>
		<input type="file" name="newsImage" id="newsImage"/>
		<br>
		
		<button onclick="addh2Tag()">h2태그</button>
		<button>p태그</button>
		<button>a태그</button>
		
		<textarea id="contentArea" name="contentArea" rows="20"></textarea>
		<div class="ScriptWriteBtnContainer">
			<button type="submit" class="scriptSubmit scriptBtn">제출</button>
			<button class="scriptTempSave scriptBtn">임시저장</button>
		</div>
	</div>
</form>

<script>
document.scriptWriteFrm.onsubmit = (e) => {
	e.preventDefault();
}


console.log(contentArea);

function addh2Tag() {
	const contentArea = document.querySelector("#contentArea");
	const headingText = contentArea.value;
	const newText = `<h2>\${headingText}</h2>`;
	contentArea.value = newText;
}


</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>