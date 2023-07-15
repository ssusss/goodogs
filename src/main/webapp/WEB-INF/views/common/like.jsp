<%@page import="com.sk.goodogs.like.model.vo.LikeList"%>
<%@page import="com.sk.goodogs.member.model.vo.Gender"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	// 전수경 - 좋아요 테이블에서 로그인 회원의 좋아요 기사 조회해오기 GET 요청
	List<LikeList> likes = (List<LikeList>) request.getAttribute("likes");
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

<!-- 좋아요한 기사의 개수 -->
<section id=like-container>
	<br>
	<div>
		<p>이 기사 좋았개</p>
	</div>
<% if(likes.isEmpty()|| likes == null) { %>
	<h1>아직 좋아요한 기사가 없개!</h1>
<% } else { %>
	<h1><%= likes.size() %>개의 기사에 좋아요 눌렀개!</h1>
<% } %>
</section>
<!-- 좋아요목록 테이블 -->
<table>
  <thead>
	  <tr>
	  	<th>기사 번호</th>
	  	<th>기사 제목</th>
	  	<th>좋아요한 날짜</th>
	  </tr>
  </thead>
  <tbody>
  </tbody>
</table>


<!-- 
	@author 전수경
	- 좋아요 목록리스트 보여주기
	- 테이블에서 memberId가 일치하는 정보를 담아서 오기
	- LikeList 객
 -->


<!-- 
	@author 전수경
	페이지 로드와 함께 로그인회원의 좋아요 리스트 가져오기
 -->
<script>
const getLikeList = () => {
	
	
	
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




<%@ include file="/WEB-INF/views/common/footer.jsp" %>