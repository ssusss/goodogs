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

<!-- 테이블 스타일 / 검색 스타일  -->
<style>
section#adminMemberBan-container {text-align:center;}
section#adminMemberBan-container table#tbl-adminMemberBan {width:100%; border:1px solid black; border-collapse:collapse; }
table#tbl-adminMemberBan th {border:1px solid black; padding:10px; background-color : rgb(192, 192, 192); }
table#tbl-adminMemberBan td {border:1px solid black; padding:10px; background-color : white;  }


div#search-container 	{width: 100%; margin:0 0 10px 0; padding:3px; background-color: rgba(0, 188, 212, 0.3);}
div#search-memberId 	{display: <%= searchType == null || "news_comment_writer".equals(searchType) ? "inline-block" : "none" %>;}
div#search-state	{display: <%= "comment_state".equals(searchType) ? "inline-block" : "none" %>;}
div#report_cnt	{display: <%= "news_comment_report_cnt".equals(searchType) ? "inline-block" : "none" %>;}
</style>

<!-- 김나영  -->
<section id="adminMemberBan-container">

	<h2>댓글 관리</h2>	    
	
	
	  <!--  신고 내용 검색 팡 목록  -->
	<div id="search-container">
        <label for="searchType">검색타입 :</label> 
        <select id="searchType">
            <option value="memberId" selected>아이디</option>		
            <option value= "state">게시 상태</option>
            <option value="news_comment_report_cnt">신고 목록</option>
        </select>

        
        <div id="search-memberId" class="search-type">
            <form action="<%=request.getContextPath()%>/admin/Commentfind">
                <input type="hidden" name="searchType" value="news_comment_writer"/>
                <input 
                	type="text" name="searchKeyword"  size="25" placeholder="검색할 아이디를 입력하세요." 
                	value=""/>
                <button type="submit">검색</button>			
            </form>	
        </div>
        
        
         <div id="search-state" class="search-type">
            <form action="<%=request.getContextPath()%>/admin/Commentfind">
                <input type="hidden" name="searchType" value="comment_state"/>
	                <input type="radio" name="searchKeyword" value="0" > 게시됨
	                <input type="radio" name="searchKeyword" value="1"> 회원 삭제
	                <input type="radio" name="searchKeyword" value="2"> 관리자 삭제
                <button type="submit">검색</button>
            </form>
        </div>
        
         <div id="report_cnt" class="search-type">
            <form action="<%=request.getContextPath()%>/admin/CommentfindReport">
                <input type="hidden" name="searchType" value="news_comment_report_cnt"/>
	                <input type="radio" name="searchKeyword"  > 일반 댓글
	                 <input type="radio" name="searchKeyword" value="3" >  신고 댓글
                <button type="submit">검색</button>
            </form>
        </div>
    </div>
   
   <script>
   document.querySelector("select#searchType").onchange = (e) => {
		console.log(e.target.value);
		document.querySelectorAll(".search-type").forEach((elem) => {
			elem.style.display = "none";
		});
		document.querySelector(`#search-\${e.target.value}`).style.display = "inline-block";
	};
   </script>
 <!--  신고 내용 검색 팡 끝  -->
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
					<%= newsComment.getCommentState() == 0 ? "게시됨" : (newsComment.getCommentState() == 1 ? "회원 삭제" : "관리자 삭제") %>		
				</td>
				<td>
						<a href="<%= request.getContextPath() %>/news/newsDetail?no=<%= newsComment.getNewsNo() %>">기사 가져올것임</a>
				</td>				
				<td>
					<button class="IsBanned" data-news-comment-writer="<%= newsComment.getNewsCommentWriter() %>">벤</button><!-- 벤여부 -->
				</td>
			</tr>			
		<% }
			
		} %>	
		</tbody>	
		<!--  신고 내용 목록  끝-->
		
		
	</table>


<!-- 페이징바 가져오기  --> 
	<nav id='pagebar'>
			<%= request.getAttribute("pagebar") %>
 	</nav>
<!--  페이징바 끝 -->	
</section>

<!--  멤버 벤 처리 폼 이동 -->
<form 
	name="memberBanForm" 
	action="<%= request.getContextPath() %>/admin/memberbanUpdate"
	method="post">
	<input type="hidden" name="memberId"/>
</form>


<script>
// 벤 처리 

 document.querySelectorAll(".IsBanned").forEach((elem)=>{
	 // 폼 클릭하면 한번 더 묻고 폼으로 이동 
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
 
 
// 벤 처리 끝 

</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>