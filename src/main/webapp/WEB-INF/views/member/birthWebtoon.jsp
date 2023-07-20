<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.sk.goodogs.member.model.vo.Gender"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Date"%>
<script src="<%=request.getContextPath()%>/js/jquery-3.7.0.js"></script>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/member.css" />
<script>
bannerContainerLower = document.querySelector(".bannerContainerLower");
bannerContainerLower.style.display = "none";
bannerContainerUpper = document.querySelector(".bannerContainerUpper");
bannerContainerUpper.style.display = "none";
</script>

<section class="birthWebtoon">
		<img class="webtoon" alt="" src="<%= request.getContextPath() %>/images/character/goodogs_webtoon.png">
</section>



<%@ include file="/WEB-INF/views/common/footer.jsp" %>