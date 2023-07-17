<%@page import="com.sk.goodogs.news.model.vo.NewsComment"%>
<%@page import="java.util.List"%>
<%@page import="com.sk.goodogs.news.model.vo.News"%>
<%@page import="com.sk.goodogs.news.model.vo.NewsScript"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
	News news = (News) request.getAttribute("news");
	List<NewsComment> newsComments  = (List<NewsComment>)request.getAttribute("newsComments");

%>

<script>
	const bannerContainerLower = document.querySelector(".bannerContainerLower");
	bannerContainerLower.style.display = "none";
	
	window.onload = () => {
		newsComment();
		
	}
	
</script>

<!-- 임시 스타일 -->

<br/><br/><br/>

<section id="news-container">
	  <!--  기사   -->
	<div><%=news.getNewsTag()%></div> <!--  카테고리  -->
	
	<h2><%=news.getNewsTitle() %><!--  제목  --></h2>
	
	<div> 이미지 </div> <br>
	 
	<div><%=news.getNewsContent()%> 
	
	기사가 너부 비어보여서 적는 글입니다. 지워주세요 ^^ㅣ	<br/>
	기사가 너부 비어보여서 적는 글입니다. 지워주세요 ^^ㅣ	<br/>
	기사가 너부 비어보여서 적는 글입니다. 지워주세요 ^^ㅣ	<br/>
	기사가 너부 비어보여서 적는 글입니다. 지워주세요 ^^ㅣ	<br/>
	기사가 너부 비어보여서 적는 글입니다. 지워주세요 ^^ㅣ	<br/>
	기사가 너부 비어보여서 적는 글입니다. 지워주세요 ^^ㅣ	<br/>
	기사가 너부 비어보여서 적는 글입니다. 지워주세요 ^^ㅣ	<br/>
	기사가 너부 비어보여서 적는 글입니다. 지워주세요 ^^ㅣ	<br/>
	 <!-- 내용  --></div>
	 
	 
<br/><br/><br/>
<!----------------------------------> 
	 <!--  댓글창  -->
<style>
#comment-container {
    border: 2px solid black; /* 검정 테두리 설정 */
    border-radius: 10px; /* 둥근 네모 처리 */
    padding: 10px; /* 내용과의 간격 설정 */
}

table#comment-container tr#level1 td{
	background-color: pink;
}
table#comment-container tr td{
	background-color: yellow;
}

table#comment-container { 
  
  border-radius: 60px; /* 둥근 처리를 위한 경계 반지름 설정 */
  border: 2px solid #000; /* 테두리 설정 */
  padding: 10px; /* 내부 여백 설정 */
  box-sizing: border-box; }

</style>

<table id="comment">
		<thead>
			<tr>
				<th colspan='3'>댓글창</th>
				
			</tr>
		</thead>
		
		<tbody>
		
		
		</tbody>
		<tfoot>
			<button id="load-more-btn">더보기</button>
		</tfoot>
		
	</table> 
	
<br/><br/><br/>

<script>
	function newsComment(frm){
		const no = <%= news.getNewsNo()%>;
		console.log(no);
			$.ajax({
				url: "<%= request.getContextPath() %>/news/newsCommentList", 
				data : {no},
				method :"GET",
				dataType :"json",
				success(newsComments) {
				const tbody= document.querySelector("#comment tbody");

				newsComments.forEach(newsComment => {
					  const {
					    commentNo,
					    newsCommentLevel,
					    newsNo,
					    newsCommentWriter,
					    commentNoRef,
					    newsCommentNickname,
					    newsCommentContent,
					    commentRegDate,
					    newsCommentReportCnt,
					    commentState
					  } = newsComment;
					  
					  console.log( "대댓글 " + newsCommentLevel );
						
					  if (newsCommentLevel === 1) { // if 문 시작
						// 댓글인 경우 
						  tbody.innerHTML += `
						  <tr class="level1">
							  <td>
								  <sub class=comment-writer >  \${newsCommentWriter} </sub>
								  \${newsCommentContent}
							  </td>
							  <td>
							  	<button class="report">신고</button> 
							  	<button class="reply">답글</button>
							  	<button class="delete">삭제</button>
							  </td>
		
						  </tr>
							  `;
					  } else if(newsCommentLevel === 2 ) {
						  // 대댓글인 경우 
						 tbody.innerHTML +=   `
						  
						  <tr class="level2">
							  <td>
								  <sub class=comment-writer >  \${newsCommentWriter} </sub>
								  \${newsCommentContent}
							  </td>
							  <td>
							  	<button class="report">신고</button> 
							  	<button class="reply">답글</button>
							  	<button class="delete">삭제</button>
							  </td>
		
						  </tr>
							  `;
					  } // else if(newsCommentLevel === 2 )  끝
					  
					  
					},); // forEach끝
					

					} // success 끝
					
					
				 }); // ajax 끝
			return false;
		 }; // funtion 끝 
		

		//삭제 버튼
		

		 
		
		</script>

	
 <!----------------------------------> 
	
<div id="newsNo" style = "display : none" ><%= news.getNewsNo() %></div>
<!-- 좋아요 -->
<div id="likeButton">
  <button id="likeButtonBtn" style="font-size: 30px; border: none; background: none; padding: 0; margin: 0; cursor: pointer;">
    ❤️좋아요 <%= news.getNewsLikeCnt() %>
  </button>
</div>
<br/><br/><br/>
<script>
  // 좋아요 이벤트 리스너 추가 (+ 수정해야함...))
  document.getElementById("likeButtonBtn").addEventListener('click', (e) => {
   
      const newsNo = document.getElementById("newsNo").textContent;

      $.ajax({
        url: "<%= request.getContextPath() %>/news/newsLikeUpdate",
        data: { newsNo: newsNo },
        method: "POST",
        success: function(response) {
          location.reload();
        }
      });
   
  });
</script>
  <!---------------------------------->  
  
  <!--  관리자에게만 보임  -->
  
  <div id="deletButton">
  <button id="deletButtonbtn" style="font-size: 30px; border: none; background: none; padding: 0; margin: 0; cursor: pointer;">
    삭제 
  </button>
</div>

<br/><br/><br/>
  

</section>

<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>