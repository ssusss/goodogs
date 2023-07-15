<%@page import="com.sk.goodogs.member.model.vo.MemberRole"%>
<%@page import="com.sk.goodogs.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// 전수경 로그인 성공 메세지
	String message = (String) session.getAttribute("message");
	if(message != null) session.removeAttribute("message"); // 1회용

	// 전수경 로그인멤버
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

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>goodogs</title>

<!-- 
	@author 이혜령
	- 폰트 링크  
-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff" rel="stylesheet">

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" />

</head>
<body>

	<div id="container">
		<nav class="navBar">
			<div class="navInner">
				<h1 id="toMain">goodogs</h1>
				<div class="navBox">
					<div class="searchBox">검색</div>
					<div class="infoBox">정보</div>
				</div>
			</div>
		</nav>


<!-- 
	@author : 김동찬, 이혜령
	- navBox에서 검색/정보 바로가기
	- 로그인 안하고 정보누를 시 경고창 + focus
 -->		
<script>
	toMain.onclick = () => {
	  location.href = '<%=request.getContextPath()%>/';
	}
	
	document.querySelector(".searchBox").onclick = () => {
	  location.href = '<%=request.getContextPath()%>/search';
	}
	
	document.querySelector(".infoBox").onclick = () => {
	  <% if (loginMember != null) { %>
	    const navBox = document.querySelector(".navBox");
	    navBox.insertAdjacentHTML('beforeend', `
	      <div class="accountMenu">
	        <a class="accountMenuDetail" href="<%=request.getContextPath()%>/member/memberInfo">내정보</a>
	        <a class="accountMenuDetail" href="<%=request.getContextPath()%>/like/likePage">좋아요</a>
	        <a class="accountMenuDetail" href="<%=request.getContextPath()%>/bookmark/bookmarkPage">북마크</a>
	        <a class="accountMenuDetail" href="<%=request.getContextPath()%>/member/logout">로그아웃</a>
	      </div>
	    `);
	  <% } else { %>
            alert('로그인이 필요합니다!');
          	const memberIdInput = document.querySelector("#memberId"); 
          		if(memberIdInput) {
            		memberIdInput.focus();
            	}
	  <% } %>
	}
</script>

		<!-- 로그인 객체마다 헤더가 다르게 보이게 -->

		<header>
			<%
			if (loginMember == null) {
			%>
			<div class="bannerContainerUpper" role="banner"> 
				<nav>
					<span class="slogan">우리가 시간이 없지, 세상이 안궁금하냐 </span>
				</nav>
			</div>
			
			<div class="bannerContainerLower">
				<div class="infoWrapper">
				<!-- @author : 이혜령 (신문파는강아지) -->
				<img src="<%= request.getContextPath() %>/upload/character/main.png" alt=""/> 
					<!-- 
						@author 전수경
						로그인 컨테이너 시작
					-->
					<div class="loginContainer">
						<form id="loginFrm" name="loginFrm" action="<%= request.getContextPath() %>/member/memberLogin" method="GET">
							<table>
								<tr>
									<td class="loginInput"><input type="email" name="memberId" id="memberId"
										placeholder="아이디(이메일 주소)" tabindex="1" value=""></td>
								</tr>
								<tr>
									<td class="loginInput"><input type="password" name="password" id="password"
										tabindex="2" placeholder="비밀번호"></td>
								</tr>
								<tr>
									<td><input type="submit" value="로그인"></td>
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
				
			</div>
			<%
			} else if (loginMember != null && loginMember.getMemberRole() == MemberRole.M) {
			%>
			<!-- 로그인 회원 컨테이너 -->
			<div class="bannerContainerUpper" role="banner">
				<nav>
					<span class="slogan">우리가 시간이 없지,</span><span class="slogan"> 세상이 안궁금하냐 </span>
				</nav>
			</div>
			<div class="bannerContainerLower">
				<div class="infoWrapper">
					<div class="infoContainer">
						<h3>반가워 죽겠개,</h2>
						<h2><%= loginMember.getNickname() %> 구독스!</h2>
						<input type="button" value="정보수정" onclick="location.href='<%= request.getContextPath() %>/member/memberInfo';">
						<input type="button" value="좋아요" onclick="location.href='<%= request.getContextPath() %>/like/likePage';">
						<input type="button" value="북마크" onclick="location.href='<%= request.getContextPath() %>/bookmark/bookmarkPage';">
					</div>
				</div>
			</div>
			<%

			} else if (loginMember != null && loginMember.getMemberRole() == MemberRole.R) {
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

				<div class="infoWrapper">
					<div class="infoContainer">
						<h2>기자 <%= loginMember.getNickname() %>님, 어서오개!</h2>
						<input type="button" value="정보수정" onclick="location.href='<%= request.getContextPath() %>/member/memberInfo';">
						<input type="button" value="좋아요" onclick="location.href='<%= request.getContextPath() %>/like/likePage';">
						<input type="button" value="북마크" onclick="location.href='<%= request.getContextPath() %>/bookmark/bookmarkPage';">
					</div>
				</div>
			</div>
			<%
			} else if (loginMember != null && loginMember.getMemberRole() == MemberRole.A) {
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

				<div class="infoWrapper">
					<div class="infoContainer">
						<h2>관리자 <%= loginMember.getNickname() %>님, 환영하개!</h2>
						<input type="button" value="정보수정" onclick="location.href='<%= request.getContextPath() %>/member/memberInfo';">
						<input type="button" value="좋아요" onclick="location.href='<%= request.getContextPath() %>/like/likePage';">
						<input type="button" value="북마크" onclick="location.href='<%= request.getContextPath() %>/bookmark/bookmarkPage';">
	
					</div>
				</div>
			</div>
			<div>

			</div>
			<%
			}
			%>
			
		</header>
		<section class="sc-bcXHqe exBdsH home-recent">