<%@page import="com.sk.goodogs.member.model.vo.Gender"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!-- 
	@author 이혜령 
	- 북마크 목록 페이지
-->
<script>
bannerContainerLower = document.querySelector(".bannerContainerLower");
bannerContainerLower.style.display = "none";
bannerContainerUpper = document.querySelector(".bannerContainerUpper");
bannerContainerUpper.style.display = "none";
</script>

<section id=bookMark-container>
	<br>
	<div>
		<p>어떤 부분이 인상깊었개</p>
	</div>
	<br>
	<h1>#개의 기사에 북마크 눌렀개!</h1>

</section>







<%@ include file="/WEB-INF/views/common/footer.jsp" %>