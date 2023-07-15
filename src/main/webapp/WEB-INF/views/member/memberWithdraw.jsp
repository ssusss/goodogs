<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!-- 
	@author 이혜령
	- 폰트 링크  
-->
<link href="https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff" rel="stylesheet">
<link rel="stylesheet" href="<%= request.getContextPath()%>/css/member.css"/>


<script>
bannerContainerLower = document.querySelector(".bannerContainerLower");
bannerContainerLower.style.display = "none";
bannerContainerUpper = document.querySelector(".bannerContainerUpper");
bannerContainerUpper.style.display = "none";
</script>

	<br><br>

<form name="memberWithdrawFrm" action="<%= request.getContextPath() %>/member/memberWithdraw" method="post">
	<section>
		<h2 class="withdraw-head-title">회원탈퇴</h2>
	
		<!-- 눈물바다 이미지 -->
		<section class="withdraw-img">
			<img src="<%= request.getContextPath() %>/upload/profile/withDraw.jpg" alt="sadImage"/>
		</section>
		
		<!-- 탈퇴사유 -->
			<h2 class="withdraw-why-title">안녕~은 영원한~헤어짐은 아니겠~지요. 어떤점이 불편하셨나요? 
			<br>참고해서 다음에 만났을 때는 더 좋은 서비스가 되어 있을게요.</h2>
			<br>
			<textarea name="reason"rows="10" cols="30" placeholder="탈퇴 사유를 적어주세요."></textarea>
			<br>
			<input type="submit" value="모든 정보와 계정을 삭제합니다." onclick="withdrawMember()">
			<input type="button" style="color rgb(0, 0 , 0); text-decoration: underline;" value="조금 더 이용해볼게요" onclick="location.href='<%= request.getContextPath() %>/member/memberInfo';">
	</section>
</form>

<script>
const withdrawMember = () => {
	if(confirm("정말로 탈퇴하시겠습니까?😥"))
		document.memberWithdrawFrm.submit();
};
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>