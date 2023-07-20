<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.sk.goodogs.news.model.vo.NewsScript"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.sk.goodogs.member.model.vo.Member"%>

<script src="https://kit.fontawesome.com/d7ccac7be9.js" crossorigin="anonymous"></script>
<!DOCTYPE html>
<%
	Member loginMember = (Member) session.getAttribute("loginMember");
	NewsScript newsScript = (NewsScript)session.getAttribute("newsScript");
	System.out.println(newsScript);
	String scriptTitle = "";
	String category = "";
	String content = "";
	String tag = "";
	List<String> scriptTagArr = new ArrayList<>();
	
	if(newsScript != null){
		scriptTitle = newsScript.getScriptTitle();
		category = newsScript.getScriptCategory();
		content = newsScript.getScriptContent();
		tag = newsScript.getScriptTag();
		if(tag != null){
			String[] arr = tag.split(",");
			scriptTagArr = Arrays.asList(arr);
		}
		
	}
	
%>
<% 	if(loginMember != null) { %>
	<script src="<%= request.getContextPath() %>/js/ws.js"></script>		
<% 	} %>
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
<body style="background-color: #EDEDE1">
<form name="scriptWriteFrm">
	<div class="tbl-container">
		<table id="tbl123">
			<tbody>
				<tr>
					<td>
						<label for="scriptWriter">작성자 : </label>
						<input class="writerId" name="scriptWriter" value="<%= loginMember.getMemberId() %>" readonly/>
					</td>
				</tr>
				<tr>
					<td>
						<label for="titleArea">뉴스 제목 : </label>
						<input type="text" name="titleArea" id="titleArea" value="<%= scriptTitle %>">
					</td>
				</tr>
				<tr>
					<td>
						<label for="category">카테고리 : </label>
						<select name="category" id="category">
							<option value="-선택-" disabled selected>-선택-</option>
							<option value="정치" <%=category.equals("정치") ? "selected" : "" %>>정치</option>
							<option value="경제" <%=category.equals("경제") ? "selected" : "" %>>경제</option>
							<option value="세계" <%=category.equals("세계") ? "selected" : "" %>>세계</option>
							<option value="테크" <%=category.equals("테크") ? "selected" : "" %>>테크</option>
							<option value="환경" <%=category.equals("환경") ? "selected" : "" %>>환경</option>
							<option value="스포츠" <%=category.equals("스포츠") ? "selected" : "" %>>스포츠</option>
							<option value="사회" <%=category.equals("사회") ? "selected" : "" %>>사회</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="fileUploadContainer">
					  <label for="newsImage" style="display: inline-block;">썸네일 첨부 :</label>
					  <input type="file" name="newsImage" id="newsImage" style="display: inline-block;"/>
					  <span>최대크기 : 10Mb</span>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<div class="myScriptWrite">
		<div class="fontStyleTableContainer">
			<table id="fontStyleTable">
				<tbody>
					<tr>
						<td>
							<button id="h2Btn">소제목</button>
							<button id="pBtn">본문</button>
						</td>
						<td>
							<button id="bBtn"><i class="fa-solid fa-bold fa-sm" style="color: #000000;"></i></button>
							<button id="uBtn"><i class="fa-solid fa-underline fa-sm" style="color: #000000;"></i></button>
							<button id="colorBtn"><i class="fa-solid fa-droplet fa-sm" style="color: #000000;"></i></button>
						</td>
						<td>
							<button id="olBtn"><i class="fa-solid fa-list-ul fa-sm" style="color: #000000;"></i></button>
							<button id="ulBtn"><i class="fa-solid fa-list-ol fa-sm" style="color: #000000;"></i></button>
						</td>
						<td><button id="aBtn"><i class="fa-solid fa-link fa-sm" style="color: #000000;"></i></button></td>
					</tr>
				</tbody>
			</table>
			<fieldset id="linkBox">
				<table>
					<tr>
						<td>
							<label for="aLink">링크 : </label>
							<input type="text" id="aLink"/>
							
						</td>
						<td rowspan="2">
							<button id="insertLink"><i class="fa-solid fa-check fa-lg" style="color: #566151;"></i></button>
						</td>
					</tr>
					<tr>
						<td>
							<label for="aContent">내용 : </label>
							<input type="text" id="aContent">
						</td>
					</tr>
				</table>
			</fieldset>
		</div>
		
		
	
		
		<textarea id="summernote" name="editordata">
		<%=content%>
		</textarea>
		
		<div class="addTagBox">
			<input type="text" id="newsTag" name="newTag"/>
			<button id="addTagBtn">태그 추가</button>
		</div>
		<div class="tagContainer">
			<div class="tag" <%= newsScript == null ? "style='display: none;'" : "" %>> 
				<div class="inputTag"><%= newsScript == null ? "-선택-" : "#" + scriptTagArr.get(0) %></div>
				<div class="cancleTagBox" onclick="cancleCategoryAlert();">
					<i class="fa-solid fa-xmark fa-xl" style="color: #555;"></i>
				</div>
			</div>
		<% if(newsScript != null) {%>
			<% for (int i = 1; i < scriptTagArr.size(); i++) { %>
			<div class="tag">
				<div class="inputTag"><%="#"+scriptTagArr.get(i) %></div>
				<div class="cancleTagBox" onclick="cancleTag(this);">
					<i class="fa-solid fa-xmark fa-xl" style="color: #555;"></i>
				</div>
			</div>
			<% }%>
		<% }%>
		</div>
		
		
		
		
		<input type="text" id="newsTagList" name="newsTagList" style="display: none;" value=<%= tag %> />
  	
		<div class="ScriptWriteBtnContainer">
			<button id="submitBtn" type="submit" class="scriptBtn">제출</button>
			<button id="tempSaveBtn" class="scriptBtn">임시저장</button>
			<button id="previewBtn"class="scriptBtn">미리보기</button>
		</div>
	</div>
</form>

<script>
// ==================== 폼 제출 =========================
submitBtn.onclick = () => {
	const title = document.getElementById('titleArea').value;
	const content = document.getElementById('summernote').value;
	
	if(title.trim() === ''){
		alert('제목을 입력하세멍');
		return false;
	}
	if ((/^\s*$/).test(content)) {
	    alert('내용을 입력하세요.');
	    return false;
	}
	if (document.getElementById('category').value === "-선택-") {
		alert('카테고리를 선택하세요.');
		return false;
	}
	if (document.getElementById('newsImage').files.length === 0) {
	    alert('파일을 첨부해주세요.');
	      return false;
    }
	// 내용 안적은 거 있으면 제출 안되도록 함수하나 만들것
	
	
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
			const {newNewsScriptNo} = responseData;
			alarm(newNewsScriptNo);
		},
		complete() {
			parent.window.location.href = '<%= request.getContextPath() %>/reporter/myScript';
			console.log(frmData);
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
			parent.window.location.href = '<%= request.getContextPath() %>/reporter/myScript';
		}
		
	});
	
	e.preventDefault();
	};
};
const cancleCategoryAlert = () => {
	alert('태그는 한개이상 추가해야합니다.');
}

const tagList = ['-선택-'];

window.addEventListener("load", function() {
  const newsTagList1 = newsTagList.value.split(","); // 콤마(,)를 기준으로 분할하여 배열에 저장
  console.log(newsTagList1[0]);
  if (newsTagList1[0] !== '/') {
	  console.log(newsTagList1);
	  tagList.shift(); // 빈 문자열인 경우 첫 번째 요소인 '-선택-' 제외
 	  tagList.push(...newsTagList1); // tagList 배열에 newsTagList 배열 요소를 추가
  }
  console.log(tagList);
});

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
					<i class="fa-solid fa-xmark fa-xl" style="color: #555;"></i>
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
					<i class="fa-solid fa-xmark fa-xl" style="color: #555;"></i>
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
	h2Btn.classList.add("clicked1");
	setTimeout(() => {
		h2Btn.classList.remove("clicked1");
	}, 2000);
};
pBtn.onclick = () => {
	$('#summernote').summernote('formatPara');
	pBtn.classList.add("clicked1");
	setTimeout(() => {
		pBtn.classList.remove("clicked1");
	}, 2000);
};

bBtn.onclick= () => {
	bBtn.classList.toggle("clicked2");
	
	if (bBtn.classList[0] == 'clicked2') {
		$('#summernote').summernote('bold');
		bBtn.style.backgroundColor = "#bbb";
	} else {
		$('#summernote').summernote('bold');
		bBtn.style.backgroundColor = "#eee";
	}
}
uBtn.onclick= () => {
	uBtn.classList.toggle("clicked2");
	
	if (uBtn.classList[0] == 'clicked2') {
		$('#summernote').summernote('underline');
		uBtn.style.backgroundColor = "#bbb";
	} else {
		$('#summernote').summernote('underline');
		uBtn.style.backgroundColor = "#eee";
	}
}
colorBtn.onclick = () => {
	colorBtn.classList.toggle("clicked2");
	
	if (colorBtn.classList[0] == 'clicked2') {
		$('#summernote').summernote('foreColor', 'green');
		colorBtn.style.backgroundColor = "#bbb";
	} else {
		$('#summernote').summernote('foreColor', 'black');
		colorBtn.style.backgroundColor = "#eee";
	}
}

olBtn.onclick = () => {
	$('#summernote').summernote('insertOrderedList');
	olBtn.classList.add("clicked1");
	setTimeout(() => {
		olBtn.classList.remove("clicked1");
	}, 2000);
}
ulBtn.onclick = () => {
	$('#summernote').summernote('insertUnorderedList');
	ulBtn.classList.add("clicked1");
	setTimeout(() => {
		ulBtn.classList.remove("clicked1");
	}, 2000);
}

aBtn.onclick= () => {
	const insertLink = document.querySelector("#linkBox");
	linkBox.style.display = "block";
	aBtn.classList.add("clicked1");
	setTimeout(() => {
		aBtn.classList.remove("clicked1");
	}, 2000);
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
// ---------------------------------------------------------


// -------------------- 자동 이어쓰기 -----------------------


// 혜령
// 버튼 클릭시 색 변경
// JavaScript 코드

// ------------------- 미리보기 ------------------------
previewBtn.onclick = () => {
	
};



function alarm(newNewsScriptNo){
	console.log("알람호출됨");
		
		const payload={
			messageType : "ALARM_MESSAGE",
			no:newNewsScriptNo,
			comemt:"원고가 업데이트되었습니다 확인하세요-기자",
			receiver:"admin@naver.com",
			hasRead:"0",
			createdAt :Date.now()
		}
		
	ws.send(JSON.stringify(payload));
};

</script>

</body>
</html>