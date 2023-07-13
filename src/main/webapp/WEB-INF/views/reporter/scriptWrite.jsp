<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reporter.css" />
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>
<script>
bannerContainerLower = document.querySelector(".bannerContainerLower");
bannerContainerLower.style.display = "none";
</script>


	
<iframe name="iframe1" id="iframe1" src="<%= request.getContextPath() %>/scriptBox/scriptBox.jsp" 
       frameborder="0" border="0" cellspacing="0"
       style="border-style: none;width: 100%; height: 600px;"></iframe>




<%@ include file="/WEB-INF/views/common/footer.jsp" %>