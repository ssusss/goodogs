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
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
</head>
<body>
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
			<option value="environ">환경</option>
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

</body>
</html>