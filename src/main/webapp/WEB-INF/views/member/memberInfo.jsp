<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<script>
bannerContainerLower = document.querySelector(".bannerContainerLower");
bannerContainerLower.style.display = "none";
bannerContainerUpper = document.querySelector(".bannerContainerUpper");
bannerContainerUpper.style.display = "none";
</script>


<section id=enroll-container>
	<br>
	<div>
		<p> ### 구독스,</p>
		<p>어떤 사람인지 더 알고싶개!</p>
	</div>
	<br>
	<h1>회원 정보</h1>
	<form name="memberUpdateFrm" method="post">
		<table>
			<tr>
				<th>아이디</th>
				<td>
					<input type="text" name="memberId" id="memberId" value="" readonly>
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
				<input type="text" name="password" id="password" value="">
				</td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td>
					<input type="text" name="nickName" id="nickName" value="">
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>
				<input type="tel" placeholder="(-없이) 01012341234" name="phone" id="phone" maxlength="11" value=""> 
				</td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
					<input type="radio" name="gender" id="gender0" value="N" >
					<label for="gender0">비공개</label>
					<input type="radio" name="gender" id="gender1" value="F" >
					<label for="gender1">여</label>
					<input type="radio" name="gender" id="gender2" value="M" >
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
	<input type="button" value="탈퇴" onclick="location.href='<%= request.getContextPath() %>/member/memberWidthdraw';">
	
</section>








<%@ include file="/WEB-INF/views/common/footer.jsp" %>