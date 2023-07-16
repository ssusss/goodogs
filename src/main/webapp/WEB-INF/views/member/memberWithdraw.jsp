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
<link rel="stylesheet" href="<%= request.getContextPath()%>/css/member.css"/>


<script>
bannerContainerLower = document.querySelector(".bannerContainerLower");
bannerContainerLower.style.display = "none";
bannerContainerUpper = document.querySelector(".bannerContainerUpper");
bannerContainerUpper.style.display = "none";
</script>

	<br><br>
<section>
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
			<table>
				<tbody>
					<td>
					<input type="radio" name="reason" id="service" value="콘텐츠 품질 및 서비스 정보 불만족"> 콘텐츠 품질 및 서비스 정보 불만족
					<br>
					<input type="radio" name="reason" id="email" value="다른 이메일로 재가입"> 다른 이메일로 재가입
					<br>	
					<input type="radio" name="reason" id="information" value="개인정보 노출 우려"> 개인정보 노출 우려
					<br>	
					<input type="radio" name="reason" id="random" value="기타"> 기타
					<br><textarea name="reason"rows="5" cols="30" placeholder="탈퇴 사유를 적어주세요" id="otherReason" style="display: none;"></textarea> <br>
					<br>
					</td>
				</tbody>			
			</table>
			<input type="submit" value="모든 정보와 계정을 삭제합니다." onclick="withdrawMember()">
			<input type="button" style="color rgb(0, 0 , 0); text-decoration: underline;" value="조금 더 이용해볼게요" onclick="location.href='<%= request.getContextPath() %>/member/memberInfo';">
	</section>
</form>
</section>
			<br>
<script>
// 탈퇴 유효성 검사
const withdrawMember = () => {
	if(confirm("정말로 탈퇴하시겠습니까?😥"))
		document.memberWithdrawFrm.submit();
};

// textarea 기타창 누르면 나오게 하기
const radioButtons = document.querySelectorAll('input[name="reason"]');
const textareaReason = document.getElementById('otherReason');

for (let i = 0; i < radioButtons.length; i++) {
  radioButtons[i].addEventListener('change', function() {
    if (this.value === '기타') {
      textareaReason.style.display = 'block';
    } else {
      textareaReason.style.display = 'none';
    }
  });
}



</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>