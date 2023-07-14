<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.sk.goodogs.member.model.vo.Member"%>
<!DOCTYPE html>
<%
	Member loginMember = (Member) session.getAttribute("loginMember");
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reporter.css" />
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>

<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
</head>
<body>
<form name="scriptWriteFrm">
	<div class="myScriptWrite">
		<div class="titleAreaContanier">
			<label for="titleArea">뉴스 제목 : </label>
			<input type="text" name="titleArea" id="titleArea"/>
			<input class="writerId" name="scriptWriter" value="<%= loginMember.getMemberId() %>" readonly/>
		</div>
		<select name="category" id="category">
			<option value="-선택-" disabled selected>-선택-</option>
			<option value="정치">정치</option>
			<option value="경제">경제</option>
			<option value="세계">세계</option>
			<option value="테크">테크</option>
			<option value="환경">환경</option>
			<option value="스포츠">스포츠</option>
			<option value="사회">사회</option>
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
			<div class="tag" style="display: none;">
				<div class="inputTag">-선택-</div>
				<div class="cancleTagBox" onclick="cancleCategoryAlert();">
				</div>
			</div>
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
				parent.window.location.href = '<%= request.getContextPath() %>/reporter/myScript';
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
	
	
	const tagList = ['-선택-']; 
	// =================== 카테고리 설정시 태그 추가, 삭제 =========================
	category.onchange = () => {
		tagList.shift();
		
		console.log(document.querySelector(".tagContainer").firstElementChild);
		
		document.querySelector(".tagContainer").firstElementChild.remove();
		
		
		tagList.unshift(category.value);
		
		console.log(tagList);
		
		const tagContainer = document.querySelector(".tagContainer");
		tagContainer.insertAdjacentHTML('afterbegin', `
				<div class="tag">
					<div class="inputTag">#\${category.value}</div>
					<div class="cancleTagBox" onclick="cancleCategoryAlert();">
					</div>
				</div>`);
		
		
		
		newsTag.value = "";
		newsTagList.value = tagList;
	}
		
		
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

</body>
</html>