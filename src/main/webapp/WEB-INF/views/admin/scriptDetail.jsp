<%@page import="com.sk.goodogs.news.model.vo.NewsScript"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	NewsScript script=(NewsScript)request.getAttribute("script");
%>
<script>
	const bannerContainerLower = document.querySelector(".bannerContainerLower");
	bannerContainerLower.style.display = "none";
</script>
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>
	
<section id="adminScriptDetail-container">
		
		<h5><%=script.getScriptCategory() %></h5>
		<h2><%=script.getScriptTitle() %></h2>

		<h2>사진 준비중</h2>
		
		
		<p>
		<%=script.getScriptContent() %>
		</p>
		
		
		
		<textarea name="reson" id="" cols="40" rows="10" >
		</textarea>
		<br/>
		<button>승인</button>
		<button>반려사유적기</button>
		<button>반려</button>
		
		
</section>
	
	
<script>
	
</script>	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>