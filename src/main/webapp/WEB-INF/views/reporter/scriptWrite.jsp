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
			<input class="writerId" name="scriptWriter" value="<%= loginMember.getMemberId() %>" readonly/>
		</div>
		<select name="category" id="category">
			<option value="none">-선택-</option>
			<option value="politic">정치</option>
			<option value="economy">경제</option>
			<option value="global">세계</option>
			<option value="tech">테크</option>
			<option value="environment">환경</option>
			<option value="sports">스포츠</option>
			<option value="society">사회</option>
		</select>
		<div class="fileUploadContainer">
			<label for="newsImage">뉴스 이미지 첨부 : </label>
			<input type="file" name="newsImage" id="newsImage"/>
		</div>
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
		
		<div class="addTagBox">
			<input type="text" id="newsTag" name="newTag"/>
			<button id="addTagBtn">태그 추가</button>
		</div>
		<div class="tagContainer">
			
		</div>
		<input type="text" id="newsTagList" name="newsTagList" style="display: none;"/>
		
		<div class="ScriptWriteBtnContainer">
			<button id="submitBtn" type="submit" class="scriptSubmit scriptBtn">제출</button>
			<button id="tempSaveBtn" class="scriptTempSave scriptBtn">임시저장</button>
		</div>
	</div>
</form>

<script>
// ==================== 폼 제출 =========================
submitBtn.onclick = () => {
	document.scriptWriteFrm.onsubmit = (e) => {
	const frmData = new FormData(e.target);
	console.log(frmData);
	
	$.ajax({
		url : "<%= request.getContextPath() %>/reporter/scriptSubmit",
		data : frmData,
		processData : false, // 직렬화 처리방지
		contentType : false, // 기본 Content-Type : application/x-www-form-urlencoded 사용안함. 
		method : "POST",
		dataType : "json",
		success(responseData) {
			console.log(responseData);
			const {result, message} = responseData;
			alert(message);
		},
		complete() {
			e.target.reset(); // 폼 초기화
		}
		
	});
	
	e.preventDefault();
	};
};


// ==================== 폼 임시저장 =========================

	
const tagList = []; 
// ==================== 태그 추가 ==========================
addTagBtn.onclick = () => {
	if (!newsTag.value) {
		return false;
	}
	
	tagList.push(newsTag.value);
	
	console.log(tagList);
	
	const tagContainer = document.querySelector(".tagContainer");
	tagContainer.insertAdjacentHTML('beforeend', `
			<div class="tag">
				<div class="inputTag">#\${newsTag.value}</div>
				<div class="cancleTagBox" onclick="cancleTag(this);">
				</div>
			</div>`);
	
	
	
	newsTag.value = "";
	newsTagList.value = tagList;
}

// ==================== 태그 삭제 ==========================
const cancleTag = (elem) => {
	console.log(elem.previousElementSibling.innerHTML.replace("#", ""));
	elem.parentElement.remove();
	
	const value = elem.previousElementSibling.innerHTML.replace("#", ""); // 삭제할 값을 지정
	const index = tagList.findIndex(element => element === value); // 삭제할 값과 일치하는 요소의 인덱스
	if (index !== -1) {
		tagList.splice(index, 1); // 해당 인덱스의 요소를 1개 삭제
	}
	console.log(tagList);
	newsTagList.value = tagList;
}


// ---------------- summernote설정 -----------------------
document.scriptWriteFrm.onsubmit = (e) => {
	e.preventDefault();
};

$('#summernote').summernote({
	toolbar: [
	
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
	
	console.log(colorBtn.classList[0]);
	if (colorBtn.classList[0] == 'colored') {
		$('#summernote').summernote('foreColor', 'green');
	} else {
		$('#summernote').summernote('foreColor', 'black');
	}
	
}
// ---------------------------------------------------------

</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>