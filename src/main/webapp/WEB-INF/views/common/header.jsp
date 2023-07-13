<%@page import="com.sk.goodogs.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// 전수경 작성 로그인 성공 메세지
	String message = (String) session.getAttribute("message");
	if(message != null) session.removeAttribute("message"); // 1회용

	// 전수경 작성 로그인멤버
	Member loginMember = (Member) session.getAttribute("loginMember");
	System.out.println("loginMember = " + loginMember);

	Cookie[] cookies = request.getCookies();
	String saveId = null;
	if(cookies != null) {
		for(Cookie cookie : cookies) {
			String name = cookie.getName();
			String value = cookie.getValue();
			// System.out.println("[Cookie] " + name + " = " + value);
			if ("saveId".equals(name))
				saveId = value;
		}
	}
	String easyLoginMember = "";

	// 로그인멤버가 null일 때 easyLoginMember 사용
	if(loginMember == null){
		easyLoginMember = (String) session.getAttribute("EasyLoginMember");		
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>goodogs</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" />
</head>
<body>

	<!-- 임시 로그인 기능 start -->
	<form id="EasyloginFrm" name="EasyloginFrm"
		action="<%=request.getContextPath()%>/easyLogin" method="post">
		<input type="radio" id="NonMember" name="radio-group"
			value="NonMember"> <label for="option1">NonMember</label><br>

		<input type="radio" id="Member" name="radio-group" value="Member">
		<label for="option2">Member</label><br> 

		<input type="radio" id="Reporter" name="radio-group" value="kjh0425@naver.com"> 
		<label for="option3">Reporter</label><br> 

		<input type="radio" id="Admin" name="radio-group" value="Admin"> 
		<label for="option3">Admin</label><br>

		<button type="submit">Go!</button>
	</form>
	<!-- 임시 로그인 기능 end -->


	<div id="container">
		<nav class="navBar">
			<div class="navInner">
				<h1>goodogs</h1>
				<div class="navBox">
					<div class="searchBox">검색</div>
					<div class="infoBox">정보</div>
				</div>
			</div>
		</nav>


		<!-- 로그인 객체마다 헤더가 다르게 보이게 -->

		<header>
			<%
			if (easyLoginMember == null || easyLoginMember.equals("NonMember")) {
			%>
			<div class="bannerContainerUpper" role="banner"> 우리가 시간이 없지, 세상이 안궁금하냐 </div>
			
			<div class="bannerContainerLower">
				
				<!-- 
					@author 전수경
					로그인 컨테이너 시작
				-->
				<div class="loginContainer">
					<form id="loginFrm" name="loginFrm" action="<%= request.getContextPath() %>/member/memberLogin" method="GET">
						<table>
							<tr>
								<td><input type="email" name="memberId" id="memberId"
									placeholder="아이디" tabindex="1" value=""></td>
								<td rowspan="2"><input type="submit" value="로그인"></td>
							</tr>
							<tr>
								<td><input type="password" name="password" id="password"
									tabindex="2" placeholder="비밀번호"></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td colspan="2"><input type="checkbox" name="saveId"
									id="saveId" /> <label for="saveId">아이디저장</label></td>
							</tr>
						</table>
					</form>
				</div> <!-- 로그인 컨테이너 종료 -->
				
				<!-- 
					@author 전수경
					회원가입 컨테이너 시작
				 -->
				<div class="registerContainer">
					<form id="RegisterFrm" name="RegisterFrm" action="<%= request.getContextPath() %>/member/memberRegister" method="GET">
						<table>
							<td rowspan="2"><input type="button" value="회원가입"
										onclick="location.href='<%= request.getContextPath() %>/member/memberRegister';"></td>
						</table>					
					</form>
				</div> <!-- 회원가입 컨테이너 종료 -->
				
			</div>
			<%
			} else if (easyLoginMember.equals("Member") || loginMember != null) {
			%>
			<!-- 로그인 회원 컨테이너 -->
			<div class="bannerContainerUpper" role="banner">우리가 시간이 없지, 세상이 안궁금하냐</div>
			<div class="bannerContainerLower">
				<br>
				<div class="infoContainer">
					<h3>반가워 죽겠개,</h2>
					<h2><%= loginMember.getNickname() %> 구독스!</h2>
					<input type="button" value="정보수정" onclick="location.href='<%= request.getContextPath() %>/member/memberInfo';">
					<input type="button" value="좋아요" onclick="location.href='<%= request.getContextPath() %>/like/likePage';">
					<input type="button" value="북마크" onclick="location.href='<%= request.getContextPath() %>/bookmark/bookmarkPage';">
				</div>

			</div>
			<%
			} else if (loginMember != null) {
			%>
			<div class="bannerContainerUpper" role="banner">
				<nav>
					<ul class="reporterNav">
						<li class="myNewsList"><a href="<%= request.getContextPath() %>/reporter/myNewsList">기사 목록</a></li>
						<li class="script"><a href="<%= request.getContextPath() %>/reporter/myScript">원고 관리</a></li>
						<li class="scriptWrite"><a href="<%= request.getContextPath() %>/reporter/scriptWrite">원고 작성</a></li>
					</ul>
				</nav>
			</div>
			<div class="bannerContainerLower">
				<br>
				<div class="infoContainer">
					<h2>기자 @@@님, 환영합니다!</h2>
					<input type="button" value="정보수정" onclick="location.href='<%= request.getContextPath() %>/member/memberInfo';">
					<input type="button" value="좋아요" onclick="location.href='<%= request.getContextPath() %>/like/likePage';">
					<input type="button" value="북마크" onclick="location.href='<%= request.getContextPath() %>/bookmark/bookmarkPage';">
				</div>
			</div>
			<%
			} else if (easyLoginMember.equals("Admin")) {
			%>
			<div class="bannerContainerUpper" role="banner">
				<nav>
					<ul class="adminNav">
						<li class="memberManagement"><a href="<%= request.getContextPath() %>/admin/memberList">회원관리</a></li>
						<li class="articleManagement"><a href="<%= request.getContextPath() %>/admin/adminScriptList">기사관리</a></li>
						<li class="reportManagement"><a href="<%= request.getContextPath() %>/admin/adminMemberBanList">신고관리</a></li>
					</ul>
				</nav>
			</div>
			<div class="bannerContainerLower">
				<br>
				<div class="infoContainer">
					<h2>관리자님, 환영합니다!</h2>
					<input type="button" value="정보수정" onclick="location.href='<%= request.getContextPath() %>/member/memberInfo';">
					<input type="button" value="좋아요" onclick="location.href='<%= request.getContextPath() %>/like/likePage';">
					<input type="button" value="북마크" onclick="location.href='<%= request.getContextPath() %>/bookmark/bookmarkPage';">
				</div>
			</div>
			<div>

			</div>

			<%
			}
			%>
			
		</header>
		<section class="sc-bcXHqe exBdsH home-recent">