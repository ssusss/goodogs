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

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" />

<!-- 아이콘 링크 -->
<script src="https://kit.fontawesome.com/d7ccac7be9.js" crossorigin="anonymous"></script>
<!-- 아이콘 링크 -->
</head>

<!-- 
	@author : 김동찬, 이혜령
	- navBox에서 검색/정보 바로가기
	- 로그인 안하고 정보누를 시 경고창 + focus
 -->	
 
<body>
	<div id="container">
		<nav class="navBar">
			<div class="navInner">
				<h1 id="toMain">goodogs</h1>
				<div class="navBox">
					<div class="searchBox"><i class="fa-solid fa-magnifying-glass fa-2xl searchIcon" style="color: ##051619;"></i></div>
					<div class="infoBox">
						<% if (loginMember == null) { %>
							<i class="fa-regular fa-user fa-2xl infoIcon" style="color: ##051619;"></i>
						<% } else { %>
							<div class="profile">
								<span><%= loginMember.getMemberProfile() %></span>
							</div>						
						<% } %>
					</div>
				</div>
			</div>
		</nav>
	</div>	
<script>
	toMain.onclick = () => {
	  location.href = '<%=request.getContextPath()%>/';
	}
	
	document.querySelector(".searchBox").onclick = () => {
	  location.href = '<%=request.getContextPath()%>/search';
	}
</script>

		<!-- 로그인 객체마다 헤더가 다르게 보이게 -->

		<header>
			<%
			if (loginMember == null || (loginMember != null && loginMember.getMemberRole() == MemberRole.M)) {
			%>			
			<div class="bannerContainerUpper sloganWrapper" role="banner"> 
				<nav>
					<div class="slogan">
						<span class="we">우리가 시간이 없지,</span><span class="world">세상이 안궁금하냐 </span>
					</div>
				</nav>
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
			<%
			}
			%>
			
			
			
			<div class="bannerContainerLower">
				<div class="infoWrapper">
					<%
					if (loginMember == null) {
					%>	
					<!-- 
						@author 전수경
						로그인 컨테이너 시작
					-->
					<div class="loginContainer">
						<div class="welcomeBox">
							<p class="p1">✨지금 555,346명이 구독스를 읽고 있어요.</p>
							<p class="p2">세상 돌아가는 소식, 빠르고 편하게 접해보세요!</p>
							<p class="p3">아침마다 세상 돌아가는 소식을 메일로 받아보세요.</p>
						</div>
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
									<td><input class="loginBtn" type="submit" value="로그인"></td>
								</tr>
								<tr>
									<td colspan="2" class="idSaveWrapper"><input class="idSaveBox" type="checkbox" name="saveId"
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
								<td rowspan="2"><input class="signUpBtn" type="button" value="회원가입"
											onclick="location.href='<%= request.getContextPath() %>/member/memberRegister';"></td>
							</table>					
						</form>
					</div> <!-- 회원가입 컨테이너 종료 -->
					<% } else if (loginMember != null) { %>
					<div class="loginContainer infoContainer">
						<div class="welcomeBox">
							<p class="p1">✨지금 555,346명이 구독스를 읽고 있어요.</p>
							<p class="p2">세상 돌아가는 소식, 빠르고 편하게 접해보세요!</p>
							<p class="p3">아침마다 세상 돌아가는 소식을 메일로 받아보세요.</p>
						</div>
						<% if (loginMember.getMemberRole() == MemberRole.M) { %>
						<p class="welcomeMember1">반가워 죽겠개,</p>
						<p class="welcomeMember2"><%= loginMember.getNickname() %> 구독스!</p>
						<div class="welcomeBtnWrapper">
							<input type="button" value="프로필 편집" onclick="location.href='<%= request.getContextPath() %>/member/memberInfo';">
							<input type="button" value="좋아요" onclick="location.href='<%= request.getContextPath() %>/like/likePage';">
							<input type="button" value="북마크" onclick="location.href='<%= request.getContextPath() %>/bookmark/bookmarkPage';">
						</div>
						<% } else if (loginMember.getMemberRole() == MemberRole.R) { %>
						<p class="welcomeMember2">기자 <%= loginMember.getNickname() %>님, 어서오개!</p>
						<div class="welcomeBtnWrapper">
							<input type="button" value="프로필 편집" onclick="location.href='<%= request.getContextPath() %>/member/memberInfo';">
							<input type="button" value="좋아요" onclick="location.href='<%= request.getContextPath() %>/like/likePage';">
							<input type="button" value="북마크" onclick="location.href='<%= request.getContextPath() %>/bookmark/bookmarkPage';">
						</div>	
						<% } else if (loginMember.getMemberRole() == MemberRole.A) { %>
						<p class="welcomeMember2">관리자 <%= loginMember.getNickname() %>님, 환영하개!</p>
						<div class="welcomeBtnWrapper">
							<input type="button" value="프로필 편집" onclick="location.href='<%= request.getContextPath() %>/member/memberInfo';">
							<input type="button" value="좋아요" onclick="location.href='<%= request.getContextPath() %>/like/likePage';">
							<input type="button" value="북마크" onclick="location.href='<%= request.getContextPath() %>/bookmark/bookmarkPage';">
						</div>		
						<% } %>
					</div>
					<% } %>
				</div>
				<div class="goodogsImageWrapper">
					<div class="goodogsImageContainer">
						<img class="goodogsImage" alt="" src="<%= request.getContextPath() %>/images/character/goodogs_news.png">
						<!-- 말풍선 이미지 수정할 것 -->
					</div>
					<div class="menuContainer"></div>
				</div>
			</div>
			
			<script>
			document.querySelector(".infoBox").onclick = () => {
			  <% if (loginMember != null) { %>
			    const menuContainer = document.querySelector(".menuContainer");
			    menuContainer.insertAdjacentHTML('beforeend', `
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
			
		</header>