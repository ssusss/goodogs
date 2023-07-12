<%@page import="com.sk.goodogs.news.model.vo.NewsComment"%>
<%@page import="com.sk.goodogs.member.model.vo.Member"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>

<script>
	// 클릭후 관리자 메인화면 창 가림
	const bannerContainerLower = document.querySelector(".bannerContainerLower");
	bannerContainerLower.style.display = "none";
	
</script>
<%

//검색 
String searchType = request.getParameter("searchType");
String searchKeyword = request.getParameter("searchKeyword");

//멤버

List<NewsComment> newsComments  = (List<NewsComment>) request.getAttribute("newsComments");


%>

<style>

section#adminMemberBan-container {text-align:center;}
section#adminMemberBan-container table#tbl-adminMemberBan {width:100%; border:1px solid black; border-collapse:collapse; }
table#tbl-adminMemberBan th {border:1px solid black; padding:10px; background-color : rgb(192, 192, 192); }
table#tbl-adminMemberBan td {border:1px solid black; padding:10px; background-color : white;  }


</style>



<section id="adminMemberBan-container">

	<h2>신고 관리</h2>
	
       
	<div id="search-container">
        <label for="searchType">검색타입 :</label> 
        <select id="searchType">
            <option value="memberId" >아이디</option>		
            <option value="nickName">기사</option>
        </select>

        
        <div id="search-memberId" class="search-type">
            <form action="<%=request.getContextPath()%>/admin/memberFinder">
                <input type="hidden" name="searchType" value="member_id"/>
                <input 
                	type="text" name="searchKeyword"  size="25" placeholder="검색할 아이디를 입력하세요." 
                	value="notalready"/>
                <button type="submit">검색</button>			
            </form>	
        </div>
        
<!--  
        <div id="search-enrole" class="search-type">
            <form action="<%=request.getContextPath()%>/admin/memberFinder">
                <input type="hidden" name="searchType" value="enrole"/>
                <input type="radio" name="searchKeyword" value="A" > 1회
                <input type="radio" name="searchKeyword" value="R"> 3회
                <input type="radio" name="searchKeyword" value="U"> 10회
                <button type="submit">검색</button>
            </form>
        </div>
-->        
        
    </div>
    
    
    
    
	<table id="tbl-adminMemberBan">
		<thead>
		
			<tr>
				<th>댓글 No</th>
				<th>닉네임(이메일)</th>
				<th>신고 내용</th>
				<th>신고 횟수</th>
				<th>기사</th>
				<th>벤</th>
			</tr>
			
		</thead>
		<tbody>
		<% if(newsComments == null) {%>
			<tr>
				<td colspan="6">신고 내용이 없습니다.</td>
			</tr>
			
		<%
		}else{
			for(NewsComment newsComment : newsComments) {
			%>
			
			<tr>
			
				<td><%= newsComment.getCommentNo()%></td>
				<td><%= newsComment.getNewsCommentWriter()%></td>
				<td><%= newsComment.getNewsCommentContent()%></td>
				<td><%= newsComment.getNewsCommentReportCnt()%></td>
				<td><%= newsComment.getNewsNo()%></td>
				<td>
					<button id = "IsBanned">벤</button>
				</td>
			</tr>
			
		<% }
			
		} %>

			
			
			
		</tbody>
		
	</table>
</section>

<!--  멤버 벤 처리 -->

<form 
	name="memberBanUpdateFrm" 
	action="<%= request.getContextPath() %>/admin/memberbanUpdate"
	method="post">
	<input type="hidden" name="newsCommentWriter"/>
</form>



<script>

button = document.getElementById("IsBanned");


button.addEventListener("click", function() {
	
	if(confirm("회원 벤 처리 하시겠습니까?")) {	
		
		
		
		alert( "회원아이디" +"님이 벤 처리 되었습니다.");
		// 사용자가 확인을 누른 경우
		const IsBannedVal = e.target.dataset.IsBanned.value;
		const newsCommentWriterVal = e.target.dataset.memberId;
		
		const frm = document.memberBanUpdateFrm;
		frm.IsBanned.value = IsBannedVal;
		frm.memberId.value = memberIdVal;
		frm.submit();
		
	}
	else {
		 // 사용자가 취소를 누른 경우
	}
	
});



</script>





<%@ include file="/WEB-INF/views/common/footer.jsp" %>