<%@page import="com.sk.goodogs.member.model.vo.Gender"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	String memberId = loginMember.getMemberId();
	String password = loginMember.getPassword();
	String nickname = loginMember.getNickname();
	String phone = loginMember.getPhone();
	Gender gender = loginMember.getGender();
	
%>
<script>
bannerContainerLower = document.querySelector(".bannerContainerLower");
bannerContainerLower.style.display = "none";
bannerContainerUpper = document.querySelector(".bannerContainerUpper");
bannerContainerUpper.style.display = "none";
</script>


<section id=enroll-container>
	<br>
	<div>
		<p> <%= nickname %> 구독스,</p>
		<p>어떤 사람인지 더 알고싶개!</p>
	</div>
	<br>
	<h1>회원 정보</h1>
	<form name="memberUpdateFrm" action="<%= request.getContextPath() %>/member/memberUpdate"method="post">
		<table>
			<tr>
				<th>아이디</th>
				<td>
					<input type="text" name="memberId" id="memberId" value="<%= memberId %>" readonly>
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
				<input type="text" name="password" id="password" value="<%= password %>">
				</td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td>
					<input type="text" name="nickName" id="nickName" value="<%= nickname %>">
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>
				<input type="tel" placeholder="(-없이) 01012341234" name="phone" id="phone" maxlength="11" value="<%= phone %>"> 
				</td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
					<input type="radio" name="gender" id="gender0" value="N" <%= gender == Gender.N ? "checked" : "" %>>
					<label for="gender0">비공개</label>
					<input type="radio" name="gender" id="gender1" value="F" <%= gender == Gender.F ? "checked" : "" %>>
					<label for="gender1">여</label>
					<input type="radio" name="gender" id="gender2" value="M" <%= gender == Gender.M ? "checked" : "" %>>
					<label for="gender2">남</label>
				</td>
			</tr>
		</table>
		<input type="submit" value="정보수정"/>
		<input type="reset" value="취소">
	</form>
	<br>
</section>

<section id=profile-update>
	<h1>프로필 이미지</h1>
		<table>
			<thead>
				<tr>원하는 이미지를 선택하개!</tr>
			</thead>
			<tbody>
				<tr>
					<td>
					<input type="radio" name="member_profile" id="dog0" vaule="">
					<label for="dog0">푸들</label>
					<input type="radio" name="member_profile" id="dog1" vaule="">
					<label for="dog1">비숑</label>
					<input type="radio" name="member_profile" id="rabbit" value="">
					<label for="rabbit">토끼</label>
					<input type="radio" name="member_profile" id="cat" vaule="">
					<label for="cat">고양이</label>
					</td>
				</tr>
			</tbody>
		</table>
</section>

<section id=member-delete>
	
	<h1>회원탈퇴</h1>
	<input type="button" value="탈퇴" onclick="location.href='<%= request.getContextPath() %>/member/memberWithdraw';">
	
</section>

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