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
List<NewsComment> newsComments = (List<NewsComment>)request.getAttribute("newsComments");
String memberId = (String) request.getAttribute("memberId");

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
            <option value="memberId" selected>아이디</option>		
            <option value="news">기사</option>
            <option value=state>게시 상태</option>
            <option value="report_cnt">신고 목록</option>
        </select>

        
        <div id="search-memberId" class="search-type">
            <form action="<%=request.getContextPath()%>/admin/memberFinder">
                <input type="hidden" name="searchType" value="member_id"/>
                <input 
                	type="text" name="searchKeyword"  size="25" placeholder="검색할 아이디를 입력하세요." 
                	value=""/>
                <button type="submit">검색</button>			
            </form>	
        </div>
        
          
        <div id="search-news" class="search-type">
            <form action="<%=request.getContextPath()%>/admin/memberFinder">
                <input type="hidden" name="searchType" value="news"/>
                <input 
                	type="text" name="searchKeyword"  size="25" placeholder="검색할 기사를 입력하세요." 
                	value=""/>
                <button type="submit">검색</button>			
            </form>	
        </div>
        
         <div id="search-state" class="search-type">
            <form action="<%=request.getContextPath()%>/admin/memberFinder">
                <input type="hidden" name="searchType" value="enrole"/>
                <input type="radio" name="searchKeyword" value="0" > 게시됨
                <input type="radio" name="searchKeyword" value="1"> 회원 삭제
                <input type="radio" name="searchKeyword" value="2"> 관리자 삭제
                <button type="submit">검색</button>
            </form>
        </div>
        
    </div>
    

  <!--  신고 내용 목록  -->
	<table id="tbl-adminMemberBan">
		<thead>		
			<tr>
				<th>댓글 No</th>
				<th>아이디(이메일)</th>
				<th>닉네임</th>
				<th>신고 내용</th>
				<th>신고 횟수</th>
				<th>게시 상태</th>
				<th>신고 기사</th>
				<th>벤</th>
			</tr>			
		</thead>
		<tbody>
		
		<% if( newsComments == null ||newsComments.isEmpty()) {%>
			<tr>
				<td colspan="8">신고 내용이 없습니다.</td>
			</tr>
			
		<%
		}else{
			for(NewsComment newsComment : newsComments) {
			%>
			
			<tr>	
					
				<td><%= newsComment.getCommentNo()%></td> <!-- 넘버 -->				
				<td><%= newsComment.getNewsCommentWriter()%></td><!-- 아이디 -->			
				<td><%= newsComment.getNewsCommentNickname() %></td><!-- 닉네임 -->
				<td><%= newsComment.getNewsCommentContent() %></td><!-- 신고 내용 -->	
				<td><%= newsComment.getNewsCommentReportCnt()%>번</td><!-- 신고 횟수-->
				<td>
  						<%= newsComment.getCommentState() == 0 ? "게시됨" : "삭제됨" %>
				</td>
				<td>
						<a href="<%= request.getContextPath() %>/board/boardDetail?no=<%=newsComment.getNewsNo()%>">기사 가져올것임</a>
				</td>				
				<td>
					<button class="IsBanned" data-news-comment-writer="<%= newsComment.getNewsCommentWriter() %>">벤</button><!-- 벤여부 -->
				</td>
				
			</tr>			
		<% }
			
		} %>	
		</tbody>	
	</table>


<!-- 페이징바 가져오기  --> 
	<div id='pagebar'>
		<%= request.getAttribute("pagebar") %>
	</div>
	
	
</section>

<!--  멤버 벤 처리 -->

<form 
	name="memberBanForm" 
	action="<%= request.getContextPath() %>/admin/memberbanUpdate"
	method="post">
	<input type="hidden" name="memberId"/>
</form>

<script>

 document.querySelectorAll(".IsBanned").forEach((elem)=>{
	elem.addEventListener("click",(e)=>{
		  if (confirm("회원 벤 처리 하시겠습니까?")) {
			  
		      const memberIdVal = e.target.dataset.newsCommentWriter;
		      const memberIdInput = document.getElementsByName("memberId")[0];
				
		      const frm = document.memberBanForm;
		      
		      frm.memberId.value = memberIdVal;
		      frm.submit();

		      alert("아이디 [" +memberIdVal + "]님이 벤 처리 되었습니다.");
		      
		    } else {
		      // 사용자가 취소를 누른 경우
		    }
		
	});
	 
 });

</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>