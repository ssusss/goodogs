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

</head>
<body>
	<h1>404</h1>
	<p id="message">요청하신 페이지는 존재하지 않습니다.</p>
	<p><a href="<%= request.getContextPath() %>/">홈으로</a></p>

</body>
</html>