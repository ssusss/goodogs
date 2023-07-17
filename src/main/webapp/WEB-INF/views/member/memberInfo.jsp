<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.sk.goodogs.member.model.vo.Gender"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Date"%>
<script src="<%=request.getContextPath()%>/js/jquery-3.7.0.js"></script>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/member.css" />
<%
	String memberId = loginMember.getMemberId();
	String password = loginMember.getPassword();
	String nickname = loginMember.getNickname();
	String phone = loginMember.getPhone();
	String memberProfile = loginMember.getMemberProfile();
	Gender gender = loginMember.getGender();
%>
<script>
bannerContainerLower = document.querySelector(".bannerContainerLower");
bannerContainerLower.style.display = "none";
bannerContainerUpper = document.querySelector(".bannerContainerUpper");
bannerContainerUpper.style.display = "none";
</script>


<section>

	<div class="info">
		<br><h1><%= nickname %> 구독스, <br>어떤 사람인지 더 알고싶개!</h1> 
	</div>
	
	<div class="memberInfo">
	<h2>회원 정보</h2>
	<form name="memberUpdateFrm" action="<%= request.getContextPath() %>/member/memberUpdate"method="post">
		<table id="tbl-memberInfo" class="memberInfo-tbl">
			<tr>
				<th>아이디</th>
				<td>
					<input type="text" name="memberId" id="memberId" value="<%= memberId %>" readonly class="memberInfo-transparent">
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
				<input type="text" name="password" id="password" value="<%= password %>" class="memberInfo-transparent">
				</td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td>
					<input type="text" name="nickName" id="nickName" value="<%= nickname %>" class="memberInfo-transparent">
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>
				<input type="tel" placeholder="(-없이) 01012341234" name="phone" id="phone" maxlength="11" value="<%= phone %>" class="memberInfo-transparent"> 
				</td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
					<input type="radio" name="gender" id="gender0" value="N" <%= gender == Gender.N ? "checked" : "" %> class="memberInfo-transparent">
					<label for="gender0">비공개</label>
					<input type="radio" name="gender" id="gender1" value="F" <%= gender == Gender.F ? "checked" : "" %> class="memberInfo-transparent">
					<label for="gender1">여</label>
					<input type="radio" name="gender" id="gender2" value="M" <%= gender == Gender.M ? "checked" : "" %> class="memberInfo-transparent">
					<label for="gender2">남</label>
				</td>
			</tr>
		</table>
	</div>
	
	<div class="profileInfo">
		<h2>프로필 변경</h2>
		<table>
			<small>"데스크탑에서 이모지는"<a href="https://emojipedia.org/unicode-8.0/" target="_blank" rel="noopener noreferrer">여기에서</a>"복사 붙여넣기!"</small>
			<tr>
				<th>프로필</th>
				<td>
					<% if (memberProfile != null) { %>
					<input type="text" name="memberProfile" placeholder="이모지를 입력해주세요" value="<%= memberProfile %>" class="profile-transparent"><br>
					<% } else { %>
					<input type="text" name="memberProfile" placeholder="이모지를 입력해주세요" value="" class="profile-transparent" ><br>
					<% } %>	
					<br>
				</td>
			</tr>
		</table>
	</div>
		<br><input type="submit" value="정보수정"/>
		<input type="reset" value="취소">
	</form>
	<br>
	<br>
</section>

<section id=member-withdraw-confirm>
	<h2>회원탈퇴</h2>
	<input type="button" value="탈퇴" onclick="location.href='<%= request.getContextPath() %>/member/memberWithdrawConfirm';">
</section>
	<br>

<script>
// 폼 유효성 검사
document.memberUpdateFrm.onsubmit = (e) => {
	const frm = e.target;
	const password = e.target.password;
	const phone = e.target.phone;
	
	// 비밀번호 검사
	
}
</script>







<%@ include file="/WEB-INF/views/common/footer.jsp" %>