<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reporter.css" />
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>
<script>
bannerContainerLower = document.querySelector(".bannerContainerLower");
bannerContainerLower.style.display = "none";
</script>

<form name="scriptWriteFrm">
	
	<iframe name="iframe1" id="iframe1" src="scriptBox.jsp" 
        frameborder="0" border="0" cellspacing="0"
        style="border-style: none;width: 100%; height: 120px;"></iframe>
</form>

<script>
// ==================== 폼 제출 =========================
submitBtn.onclick = () => {
	
	// 내용 안적은 거 있으면 제출 안되도록 함수하나 만들것
	if (category.value == "none") {
		alert("카테고리를 선택하세요");
		return false;
	}
	
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
			const {message} = responseData;
			alert(message);
		},
		complete() {
			window.location.href = '<%= request.getContextPath() %>/reporter/myScript';
		}
		
	});
	
	e.preventDefault();
	};
};


// ==================== 폼 임시저장 =========================
tempSaveBtn.onclick = () => {
	
	document.scriptWriteFrm.onsubmit = (e) => {
	const frmData = new FormData(e.target);
	console.log(frmData);
	
	$.ajax({
		url : "<%= request.getContextPath() %>/reporter/scriptTempSave",
		data : frmData,
		processData : false, // 직렬화 처리방지
		contentType : false, // 기본 Content-Type : application/x-www-form-urlencoded 사용안함. 
		method : "POST",
		dataType : "json",
		success(responseData) {
			console.log(responseData);
			const {message} = responseData;
			alert(message);
		},
		complete() {
			window.location.href = '<%= request.getContextPath() %>/reporter/myScript';
		}
		
	});
	
	e.preventDefault();
	};
};
	
	
	
// ==================== 태그 추가 ==========================
const tagList = []; 
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