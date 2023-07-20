<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="<%=request.getContextPath()%>/js/jquery-3.7.0.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/member.css" />
<%@ include file="/WEB-INF/views/common/header.jsp" %>


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
