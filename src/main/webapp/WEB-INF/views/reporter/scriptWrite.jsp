<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reporter.css" />
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>
<script>
bannerContainerLower = document.querySelector(".bannerContainerLower");
bannerContainerLower.style.display = "none";
</script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

<form name="scriptWriteFrm">
	<div class="myScriptWrite">
		<div class="titleAreaContanier">
			<label for="titleArea">뉴스 제목 : </label>
			<input type="text" name="titleArea" id="titleArea"/>
		</div>
	
		<label for="newsImage">뉴스 이미지 첨부 : </label>
		<input type="file" name="newsImage" id="newsImage"/>
		<br>
		
		
		<button id="h2Btn">h2</button>
		<button id="pBtn">p</button>
		<button id="aBtn">a</button>
		<button id="olBtn">ol</button>
		<button id="ulBtn">ul</button>
		<button id="colorBtn">color</button>
		
		<fieldset id="linkBox">
			<legend> 링크 </legend>
			<table>
				<tr>
					<td>
						<label for="aContent">내용 : </label>
						<input type="text" id="aContent"/>
					</td>
				</tr>
				<tr>
					<td>
						<label for="aLink">링크 : </label>
						<input type="text" id="aLink"/>
					</td>
				</tr>
			</table>
			<button id="insertLink">insert link</button>
		</fieldset>
		
		<textarea id="summernote" name="editordata">
		</textarea>
		
		<div class="ScriptWriteBtnContainer">
			<button type="submit" class="scriptSubmit scriptBtn">제출</button>
			<button class="scriptTempSave scriptBtn">임시저장</button>
		</div>
	</div>
</form>

<script>
document.scriptWriteFrm.onsubmit = (e) => {
	e.preventDefault();
};

$('#summernote').summernote({
	toolbar: [
		  ['style', ['style']],
		  ['font', ['bold', 'underline', 'clear']],
		  ['color', ['color']],
		  ['para', ['ul', 'ol', 'paragraph']],
		  ['table', ['table']],
		  ['insert', ['link', 'picture', 'video']],
		  ['view', ['fullscreen', 'codeview', 'help']],
		],
});
	
h2Btn.onclick = () => {
	$('#summernote').summernote('formatH2');
};
pBtn.onclick = () => {
	$('#summernote').summernote('formatPara');
};
aBtn.onclick= () => {
	const insertLink = document.querySelector("#linkBox");
	linkBox.style.display = "block";
}
insertLink.onclick = () => {
	$('#summernote').summernote('createLink', {
		  text: aContent.value,
		  url: aLink.value,
		  isNewWindow: true
	});
	const insertLink = document.querySelector("#linkBox");
	linkBox.style.display = "none";
}
olBtn.onclick = () => {
	$('#summernote').summernote('insertOrderedList');
}
ulBtn.onclick = () => {
	$('#summernote').summernote('insertUnorderedList');
}
colorBtn.onclick = () => {
	colorBtn.classList.toggle("colored");
	$('#summernote').summernote('foreColor', 'green');
}

</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>