<%@page import="com.sk.goodogs.news.model.vo.NewsScriptRejected"%>
<%@page import="java.util.Date"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.sk.goodogs.news.model.vo.NewsScript"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	NewsScriptRejected script=(NewsScriptRejected)request.getAttribute("rejectedScript");
%>
<script>
	const bannerContainerLower = document.querySelector(".bannerContainerLower");
	bannerContainerLower.style.display = "none";
</script>
<style>
	.adminComent {
		display: none;
	}

</style>
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>
	
<section id="adminScriptDetail-container">

	
		
		<h5 ><%=script.getScriptCategory() %></h5>
		<h2 ><%=script.getScriptTitle() %></h2>

		<div id="imgBox">
		</div>
	
		
		<p>
		<%=script.getScriptContent() %>
		</p>
		
		<p>
			<%=script.getScriptTag() %>
		</p>
		<p><%=script.getScriptTag() %> </p>
		<p><%=script.getScriptNo() %> </p>



	<h2>반려사유</h2>
	<h2><%=script.getRejectedReson()%></h2>
		
	

</section>


<script >

</script>




<%@ include file="/WEB-INF/views/common/footer.jsp" %>