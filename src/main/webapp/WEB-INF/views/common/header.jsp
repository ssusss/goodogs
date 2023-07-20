<%@page import="com.sk.goodogs.member.model.vo.MemberRole"%>
<%@page import="com.sk.goodogs.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String msg = (String) session.getAttribute("msg");
	if(msg != null) session.removeAttribute("msg"); // 1회용
	System.out.println("msg = " + msg);

	// 세션으로 로그인멤버 가져오기
	Member loginMember = (Member) session.getAttribute("loginMember");
	System.out.println("loginMember = " + loginMember);
	session.setAttribute("loginMember", loginMember);
	Cookie[] cookies = request.getCookies();
	String saveId = null;
	if(cookies != null) {
		for(Cookie cookie : cookies) {
			String name = cookie.getName();
			String value = cookie.getValue();
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
<style>
.alarmMenu{
	display : none;
}
</style>
<!-- 웹소켓 객체생성 (상윤) -->
<% 	if(loginMember != null) { %>
	<script src="<%= request.getContextPath() %>/js/ws.js"></script>		
<% 	} %>
<!-- 아이콘 링크 -->
<script src="https://kit.fontawesome.com/d7ccac7be9.js" crossorigin="anonymous"></script>
<script>
window.addEventListener('load', function() {
	  <% if(msg != null) { %>
	    alert('<%= msg %>');
	  <% } %>

	  <% if(loginMember == null) { %>
	    document.loginFrm.onsubmit = function(e) {
	      // 아이디
	      const memberId = e.target.memberId.value;
	      console.log(memberId);
	      if(!/^\w{4,}$/.test(memberId.value)) {
	        alert("아이디는 4글자 이상 입력하세요.");
	        e.preventDefault();
	        return;
	      }
	      
	      // 비밀번호
	      const password = e.target.password;
	      if(!/^.{4,}$/.test(password.value)) {
	        alert("비밀번호는 8글자 이상 입력하세요.");
	        e.preventDefault();
	        return;
	      }
	    };
	  <% } %>
	});
</script>
</head>


<body>
	<div id="container">
		<nav class="navBar">
			<div class="navInner">
				<h1 id="toMain1">goodogs</h1>
				<div class="navBox">
					<div id="notification-container">
						<span id="notification"></span>
						
					</div>	
					
					
					<div class="searchBox"><i class="fa-solid fa-magnifying-glass fa-2xl searchIcon" style="color: ##051619;"></i></div>
					<div class="infoBox">
						<% if (loginMember == null || loginMember.getMemberProfile() == null) { %>
							<i class="fa-regular fa-user fa-2xl infoIcon" style="color: ##051619;"></i>
						<% } else { %>
							<div class="profile">
								<span><%= loginMember.getMemberProfile() %></span>
								<span id="notification"></span>
							</div>						
						<% } %>
					</div>
				</div>
			</div>
		</nav>
		

	<script>
	
	
    toMain1.onclick = () => {
      location.href = '<%=request.getContextPath()%>/';
    }

    document.querySelector(".searchBox").onclick = () => {
      location.href = '<%=request.getContextPath()%>/search';
    }
    
	document.querySelector(".infoBox").onclick = () => {
		const infoBox = document.querySelector(".infoBox");
		if (infoBox.classList.length == 1) {
			<% if (loginMember != null) { %>
			infoBox.classList.add("menuOpened")
			infoBox.insertAdjacentHTML('beforeend', `
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
		} else {
			infoBox.classList.remove("menuOpened");
			infoBox.lastElementChild.remove();
		}
		
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
				<!-- 로그인 컨테이너 시작 -->
				<div class="loginContainer">
					<!-- 환영메세지 -->
					<div class="welcomeBox">
						<p class="p1">✨지금 555,346명이 구독스를 읽고 있어요.</p>
						<p class="p2">세상 돌아가는 소식, 빠르고 편하게 접해보세요!</p>
						<p class="p3">아침마다 세상 돌아가는 소식을 메일로 받아보세요.</p>
					</div>
					<!-- 로그인폼 -->
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
				
				<!-- 회원가입 컨테이너 시작 -->
				<div class="registerContainer">
				<!-- 회원가입 폼 -->
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
					<img class="speechImage" alt="" src="<%= request.getContextPath() %>/images/character/speech_bubble.png">
					<!-- 말풍선 이미지 수정할 것 -->
				</div>
				<div class="menuContainer"></div>
			</div>
		</div>

		
		<!-- 
			@author : 김동찬, 이혜령
			- navBox에서 검색/정보 바로가기
			- 로그인 안하고 정보누를 시 경고창 + focus
		 -->	
	
	</header>
	
<% 	if(loginMember != null) { %>
	<script>
	
	window.onload=()=>{
		alarmCheck("<%=loginMember.getMemberId() %>");
	}
	

	</script>
<% 	} %>
<script>
function alarmCheck(memberId){
	console.log(memberId);

	$.ajax({
	url : "<%= request.getContextPath() %>/alarm/check",
	data : {memberId},	
	method : "GET",
	dataType : "json",
	success(alarms) {
		console.log(alarms);
		if(alarms.length>0){
			
				const alarmSpace =document.querySelector("#notification");
					if(!alarmSpace.hasChildNodes()) {
						alarmSpace.innerHTML=`<i class="fa-solid fa-bell bell"></i>`;
					}
				const notificationContainer = document.querySelector("#notification-container");
				notificationContainer.insertAdjacentHTML('beforeend', `
					<div class="alarmMenu">
						
		 			</div>	
				`);
				const alarmMenuBox=document.querySelector(".alarmMenu");
				alarmMenuBox.innerHTML=alarms.reduce((html,alarm)=>{
					const{alarmNo,alarmReceiver,alarmScriptNo,alarmComment}=alarm;
						
					return html +`
						<p id="\${alarmNo}">\${alarmComment}</P>
					`;
				},"");
				
			}
		

		}
	
	});
};



document.addEventListener("click",(e)=>{

	if(e.target.matches(".bell")){
		const bell = document.querySelector(".bell");
		const alarmMenu= document.querySelector(".alarmMenu");
		if (bell.classList.length == 3) {
			alarmMenu.style.display="block";
			bell.classList.add("bellClicked");			
		} else {
			bell.classList.remove("bellClicked");
			alarmMenu.style.display="none";
		}
		
		
	}


	if(e.target.matches(".bell")){

		$.ajax({
				url : "<%= request.getContextPath() %>/admin/alarmChecked",
				data : "데이터연결해야함",	
				method : "POST",
				dataType : "json",
				success(updateRole) {
					console.log(updateRole)
					alert(updateRole.message);
				}
			});
	}
});
</script>
