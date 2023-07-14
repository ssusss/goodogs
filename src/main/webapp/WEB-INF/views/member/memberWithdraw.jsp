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

<form name="memberWithdrawFrm" action="<%= request.getContextPath() %>/member/memberWithdraw" method="post">
	<!-- 눈물바다 이미지 -->
	<section class="withdraw-img">
	<img src="/upload/character/main.png" alt=""/>
	</section>
	
	<!-- 탈퇴사유 -->
	<section>
	
		<header class="withdraw-head">
			<h2 class="withdraw-head-title">회원탈퇴</h2>
		</header>
		
		<section class="withdraw-why">
			<h2 class="withdraw-why-title">안녕~은 영원한~헤어짐은 아니겠~지요. 어떤점이 불편하셨나요? 참고해서 다음에 만났을 때는 더 좋은 서비스가 되어 있을게요.</h2><br>
			<textarea name="reason"rows="10" cols="30" placeholder="탈퇴 사유를 적어주세요"></textarea> <br>
			<input type="submit" value="모든 정보와 계정을 삭제합니다." onclick="withdrawMember()">
			<input type="button" style="color rgb(0, 0 , 0); text-decoration: underline;" value="조금 더 이용해볼게요" onclick="location.href='<%= request.getContextPath() %>/member/memberInfo';">
		</section>
		
	</section>
</form>

<script>

const withdrawMember = () => {
	if(confirm("정말로 탈퇴하시겠습니까?😥"))
		document.memberWithdrawFrm.submit();
};

</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>