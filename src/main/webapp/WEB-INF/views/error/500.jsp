<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 
	에러페이지 설정
	- page지시어 isErrorPage="true"
	- 발생한 예외객체에 exception변수명으로 선언없이 접근 가능
	- 에러코드로 넘어온 jsp에는 exception객체 null이다.
 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에러페이지</title>
<style>
body {
	background-color: #BB7B55;
	margin: 0;
	padding: 0;
	overflow: hidden;
}
img {
	height: 100%;
	position: absolute;
  	top: 50%;
  	left: 50%;
  	transform: translate(-50%, -50%);
}
@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
a {
	position: absolute;
	font-family: 'GmarketSansMedium';
	text-decoration: none;
	color: inherit;
	font-size: 20px;
	bottom: 10px;
  	left: 50%;
  	transform: translate(-50%, -50%);
}
</style>
</head>
<body>
	<div class="faceWrapper">
		<img alt="" src="<%= request.getContextPath() %>/images/character/goodogs_face2.jpg">
		<a href="<%= request.getContextPath() %>/">
			<h1>집으로</h1>
		</a>
	</div>
</body>
</html>