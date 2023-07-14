<%@page import="com.sk.goodogs.member.model.vo.Gender"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	// 전수경 - 좋아요 테이블에서 로그인 회원의 좋아요 기사 조회해오기 GET 요청
	

%>
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>
<!-- 
	@author 이혜령 
	- 좋아요 목록 페이지
-->
<script>
bannerContainerLower = document.querySelector(".bannerContainerLower");
bannerContainerLower.style.display = "none";
bannerContainerUpper = document.querySelector(".bannerContainerUpper");
bannerContainerUpper.style.display = "none";
</script>

<!-- 
	@author 전수경
	페이지 로드와 함께 로그인회원의 좋아요 리스트 가져오기
 -->
<script>
const getLikeList = () => {
	const loginMember = <%= loginMember %>;
	
	
	//  좋아요 리스트 GET 요청
	$.ajax({
		url : "<%= request.getContextPath() %>/member/like/getLikeList",
		data : {memberRoleVal,memberIdVal},	
		method : "GET",
		dataType : "json",
		success(likeList) {
			console.log(likeList);
			
			
			
		}
	});
}

document.onload = () => {
	getLikeList();
}

</script>

<section id=like-container>
	<br>
	<div>
		<p>이 기사 좋았개</p>
	</div>
	<br>
	<h1>#개의 기사에 좋아요 눌렀개!</h1>

</section>

<script>




</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>