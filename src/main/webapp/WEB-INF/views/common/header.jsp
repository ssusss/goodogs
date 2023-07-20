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
	  <% } else { %>
			alarmCheck("<%=loginMember.getMemberId() %>");
	  <% } %>
	});
</script>
</head>


<body>
	<!-- 
		@author : 김동찬, 이혜령 
		- 
	-->
	<div id="container">
		<nav class="navBar">
			<div class="navInner">
				<h1 id="toMain1">goodogs</h1>
				<div id="notification-container">
					<span id="notification"></span>
					
				</div>	
				<div class="navBox">
					
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
		

	<!-- 
		@author : 김동찬, 이혜령
		- navBox에서 검색/정보 바로가기
		- 로그인 안하고 정보누를 시 경고창 + focus
	 -->	
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
						<p class="p1">✨지금 <%= request.getAttribute("totalMember") %>명이 구독스를 읽고 있어요. </p>
						<p class="p2">세상 돌아가는 소식이 궁금하다면,</p>
						<p class="p3">빠르고 편하게 아침마다 구독스 뉴스레터로 확인하세요!</p>
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
					<% if (loginMember.getMemberRole() == MemberRole.M) { %>
					<div class="welcomeBox">
						<p class="p1">✨지금 <%= request.getAttribute("totalMember") %>명이 <span class="main-goodogs-font">구독스</span>를 읽고 있어요. </p>
						<p class="p2">수많은 구독스 멤버와 함께,</p>
						<p class="p3">구독스에서 현명하고 빠르게 세상을 만나보세요!</p>
					</div>
					<br>
					<div class="welcomMember1">
						반갑개🐾						
						<p class="welcomeMember2"><%= loginMember.getNickname() %> 구독스!</p>
					</div>
					
					<div class="welcomeBtnWrapper">
						<input type="button" value="좋아요" onclick="location.href='<%= request.getContextPath() %>/like/likePage';">
						<input type="button" value="북마크" onclick="location.href='<%= request.getContextPath() %>/bookmark/bookmarkPage';">
					</div>
					
					<% } else if (loginMember.getMemberRole() == MemberRole.R) { %>
					<div class="welcomeBox">
						<p class="p1">✨지금 <%= request.getAttribute("totalMember") %>명이 <span class="main-goodogs-font">구독스</span>를 읽고 있어요. </p>
						<p class="p2">수많은 구독스 멤버들에게,</p>
						<p class="p3">새로운 소식과 정보를 전달해주세요!</p>
					</div>
					<br>
					<div class="welcomMember3">
						오늘은 세상에 무슨일이 일어났을까 ✍️		
						<p class="welcomeMember2">기자 <%= loginMember.getNickname() %>님, 어서오개!</p>
					</div>
					<div class="welcomeBtnWrapper">
						<input type="button" value="좋아요" onclick="location.href='<%= request.getContextPath() %>/like/likePage';">
						<input type="button" value="북마크" onclick="location.href='<%= request.getContextPath() %>/bookmark/bookmarkPage';">
					</div>	
					
					<% } else if (loginMember.getMemberRole() == MemberRole.A) { %>
					<div class="welcomeBox">
						<p class="p1">✨지금 <%= request.getAttribute("totalMember") %>명이 <span class="main-goodogs-font">구독스</span>를 읽고 있어요. </p>
						<p class="p2">수많은 구독스 멤버들과,</p>
						<p class="p3">오늘도 구독스와 함께하세요!</p>
					</div>
					<br>
					<div class="welcomMember1">
						함께 만들어가요 📰		
						<p class="welcomeMember2">관리자 <%= loginMember.getNickname() %>님, 환영하개!</p>
					</div>
					<div class="welcomeBtnWrapper">
						<input type="button" value="좋아요" onclick="location.href='<%= request.getContextPath() %>/like/likePage';">
						<input type="button" value="북마크" onclick="location.href='<%= request.getContextPath() %>/bookmark/bookmarkPage';">
					</div>		
					<% } %>
				</div>
				<% } %>
			</div>
			<div class="goodogsImageWrapper">
				<div class="goodogsImageContainer">
					<img class="goodogsImage" alt="" src="<%= request.getContextPath() %>/images/character/goodogs_news.png" onclick="location.href='<%= request.getContextPath() %>/webtoon';">
					<img class="speechImage" alt="" src="<%= request.getContextPath() %>/images/character/speech_bubble.png">
				</div>
				<div class="menuContainer"></div>
			</div>
		</div>

		
	</header>
	
	
<script>
function alarmCheck(memberId) {
	console.log(memberId);

	$.ajax({
	url : "<%= request.getContextPath() %>/alarm/check",
	data : {memberId},	
	method : "GET",
	dataType : "json",
	success(alarms) {
		console.log(alarms);
		if(alarms.length > 0){
				const alarmSpace =document.querySelector("#notification");
					if(!alarmSpace.hasChildNodes()) {
						alarmSpace.innerHTML=`<img alt="" 
							 src="<%= request.getContextPath() %>/images/character/goodogs_ureka2.png"
							 style="width: 150px" class="bell">`;
						
					}
				const notificationContainer = document.querySelector("#notification-container");
				notificationContainer.insertAdjacentHTML('beforeend', `
					<div class="alarmMenu">
						
		 			</div>	
				`);
				const alarmMenuBox = document.querySelector(".alarmMenu");
				alarmMenuBox.innerHTML=alarms.reduce((html,alarm) => {
					const{alarmNo,alarmReceiver,alarmScriptNo,alarmComment}=alarm;
						
					return html +`
						<p>\${alarmComment}</P>
					`;
				},"");
				
			}
		

		}
	
	});
};


document.addEventListener("click",(e)=>{

	if(e.target.matches(".bell")){
		
		
		const bell = document.querySelector(".bell");
		const alarmMenu = document.querySelector(".alarmMenu");
		if (bell.classList.length == 1) {
			alarmMenu.style.display="block";
			bell.style.animation = "none";
			bell.classList.add("bellClicked");			
		} else {
			bell.classList.remove("bellClicked");
			alarmMenu.style.display="none";
		}
	
		const memberId= "<%=loginMember != null ? loginMember.getMemberId():"비로그인" %>" ;

	    $.ajax({
	        url : "<%= request.getContextPath() %>/alarm/alarmChecked",
	        data :{memberId} ,
	        method : "POST",
	        dataType : "json",
	        success(response) {
	            console.log(response.result);
	        }
	    });
		
	}

});
</script>