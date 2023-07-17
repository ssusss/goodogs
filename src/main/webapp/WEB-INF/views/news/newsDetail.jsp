<%@page import="com.sk.goodogs.news.model.vo.NewsComment"%>
<%@page import="java.util.List"%>
<%@page import="com.sk.goodogs.news.model.vo.News"%>
<%@page import="com.sk.goodogs.news.model.vo.NewsScript"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!--  기사 페이지  -->
<!-- ----------------------------------------------------- -->	

<%
	News news = (News) request.getAttribute("news");
	List<NewsComment> newsComments  = (List<NewsComment>)request.getAttribute("newsComments");
	NewsComment newsComment = (NewsComment)request.getAttribute("NewsComment");

%>

<!-- ----------------------------------------------------- -->	

<script>
	const bannerContainerLower = document.querySelector(".bannerContainerLower");
	bannerContainerLower.style.display = "none";
	
	window.onload = () => {
		newsComment();
		
	}
	
</script>
<!-- ----------------------------------------------------- -->	


<!-- 임시 스타일 -->

<br/><br/><br/>
<!-- ----------------------------------------------------- -->	

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

<!-- ----------------------------------------------------- -->	

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

<!-- ----------------------------------------------------- -->	
<!--  댓글 작성할수 있는 칸  -->
  <div class="comment-editor">
            <form
				action="<%=request.getContextPath()%>/news/newsCommentCreate" 
				method="post" 
				name="boardCommentFrm">
				
                <input type="hidden" name="newsNo" value="<%= news.getNewsNo()%>" />
                <input type="hidden" name="newsCommentWriter" value="<%= loginMember != null ? loginMember.getMemberId() : "" %>" />

                <input type="hidden" name="newsCommentLevel" value="1" />  
               <input type="hidden" name="newsCommentNickname" value="<%= loginMember.getNickname() %>" />
				<textarea name="newsCommentContent" cols="50" rows="3"></textarea>
                <button type="submit" id="btn-comment-enroll1">등록</button>
            </form>
     </div>

<!-- ----------------------------------------------------- -->	      
  
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

<!-- ----------------------------------------------------- -->	

<script>


<!-- ----------------------------------------------------- -->	
	// 댓글  리스트 ( 시좍 ~~~ )
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
				const trdel1= document.querySelector("#level1 tr");
				const trdel2 = document.querySelector("#level2 tr");
				
				newsComments.forEach(newsComment => { // 반복 
					
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
			        
			        
					
			        
			        console.log("대댓글 " + newsCommentLevel);
			        
			        //--------------------------------------------------------------
			         
			       
				
			        if (newsCommentLevel === 1) {// 댓글인 경우 ---------------------------------------------------------------------------------------
			        	
			        	
			        	 if  ( comment_state == 1 ){// 작성자 삭제 글씨 처리-----------------------------
					        	
				        	 tbody.innerHTML += `
				        	<tr class="level1Del">
				              <td>
				                <sub class="comment-writer"> ${newsCommentNickname} </sub>
				              	  작성자가 삭제한 메세지입니다
				              </td>
				            </tr>
				            `;
				            
				            
				           //---버튼처리 -------------
				      
						   if (isSelf || isAdmin) {// 관리자일경우 보임
						        tbody.innerHTML += `
						        <td>
							         <button class="report">신고</button>
							         <button class="reply">답글</button>
							     </td>
							  `;

						  }else if () {// 본인일때 보이는 버튼
							  
						  }else if() {// 일반 회원일때 보이는 버튼 
							  
						  }
				            //----------------
				        	
				        }else if ( comment_state == 2 ) {// 관리자 삭제 글씨 처리-----------------------------

				        	 tbody.innerHTML += `
				        	<tr class="level1Del">
				              <td>
				                <sub class="comment-writer"> ${newsCommentNickname} </sub>
				           	     관리자가 삭제한 메세지입니다
				              </td>
				            </tr>
				            `;
				            
				            
				              //---버튼처리 -------------
				      
						   if (isSelf || isAdmin) {// 관리자일경우 보임
						        tbody.innerHTML += `
						        <td>
							         <button class="report">신고</button>
							         <button class="reply">답글</button>
							     </td>
							  `;

						  }else if () {// 본인일때 보이는 버튼
							  
						  }else if() {// 일반 회원일때 보이는 버튼 
							  
						  }
				            //----------------
				        	
				        }else {// 삭제가 안된 댓글 처리-----------------------------

					    
					          		
					          tbody.innerHTML += `
					            <td class="level1">
					              <td>
					                <sub class="comment-writer"> ${newsCommentNickname} </sub>
					                ${newsCommentContent}
					              </td>
					            </tr>
					          `;
					          
					           //---버튼처리 -------------
				      
						   if (isSelf || isAdmin) {// 관리자일경우 보임
						        tbody.innerHTML += `
						        <td>
							         <button class="report">신고</button>
							         <button class="reply">답글</button>
							     </td>
							  `;

						  }else if () {// 본인일때 보이는 버튼
							  
						  }else if() {// 일반 회원일때 보이는 버튼 
							  
						  }
				            //----------------
				        	
				        }
			        
			         
			          //--------------------------------------------------------------
			          
			          
			        } else if (newsCommentLevel === 2) {    // 대댓글인 경우 

			        	 if  ( comment_state == 1 ){// 작성자 삭제 글씨 처리-----------------------------
					        	
				        	 tbody.innerHTML += `
				        	<tr class="level1De2">
				              <td>
				                <sub class="comment-writer"> ${newsCommentNickname} </sub>
				              	  작성자가 삭제한 메세지입니다
				              </td>
				            </tr>
				            `;
				            
				            
				            //---버튼처리 -------------
				      
						   if (isSelf || isAdmin) {// 관리자일경우 보임
						        tbody.innerHTML += `
						        <td>
							         <button class="report">신고</button>
							         <button class="reply">답글</button>
							     </td>
							  `;

						  }else if () {// 본인일때 보이는 버튼
							  
						  }else if() {// 일반 회원일때 보이는 버튼 
							  
						  }
				            //----------------
				        	
				        }else if ( comment_state == 2 ) {// 관리자 삭제 글씨 처리-----------------------------

				        	 tbody.innerHTML += `
				        	<tr class="level1De2">
				              <td>
				                <sub class="comment-writer"> ${newsCommentNickname} </sub>
				           	     관리자가 삭제한 메세지입니다
				              </td>
				            </tr>
				            `;
				              //---버튼처리 -------------
				      
						   if (isSelf || isAdmin) {// 관리자일경우 보임
						        tbody.innerHTML += `
						        <td>
							         <button class="report">신고</button>
							         <button class="reply">답글</button>
							     </td>
							  `;

						  }else if () {// 본인일때 보이는 버튼
							  
						  }else if() {// 일반 회원일때 보이는 버튼 
							  
						  }
				            //----------------
				        	
				        }else {// 삭제가 안된 댓글 처리-----------------------------

					    
					          		
					          tbody.innerHTML += `
					            <td class="level2">
					              <td>
					                <sub class="comment-writer"> ${newsCommentNickname} </sub>
					                ${newsCommentContent}
					              </td>
					            </tr>
					          `;
					          
					       //---버튼처리 -------------
				      
						   if (isSelf || isAdmin) {// 관리자일경우 보임
						        tbody.innerHTML += `
						        <td>
							         <button class="report">신고</button>
							         <button class="reply">답글</button>
							     </td>
							  `;

						  }else if () {// 본인일때 보이는 버튼
							  
						  }else if() {// 일반 회원일때 보이는 버튼 
							  
						  }
				            //----------------
				        	
				        }
			        
			         
			          //--------------------------------------------------------------
			          
			          
			        } // 대댓글인 경우 끝  
			        
			        
			        
			        
			      }); // forEach 끝
					

					} // success 끝
					
					
				 }); // ajax 끝
			return false;
		 }; // funtion 끝 
		 
<!--댓글 끝  ----------------------------------------------------- -->		 
		 
		 // 삭제  ( 본인 )
			document.querySelectorAll(".btn-Member-delete").forEach((button) => {
				button.onclick = (e) => {
					if(confirm("해당 댓글을 삭제하시겠습니까?")){
						const frm = document.newsCommentDelFrmMember;
						
						 const commentState = e.target.getAttribute("value"); // value 값을 가져옴
					     frm.commentState.value = commentState; // commentState 값을 설정
					      
						frm.submit();
					}
				}
			}); // 끝
		 
			// 삭제  ( 관리자 )
			document.querySelectorAll(".btn-Admin-delete").forEach((button) => {
				button.onclick = (e) => {
					if(confirm("해당 댓글을 삭제 처리 하시겠습니까?")){
						const frm = document.newsCommentDelFrmAdmin;
						  
						 const commentState = e.target.getAttribute("value"); // value 값을 가져옴
					     frm.commentState.value = commentState; // commentState 값을 설정
					      
					 
						frm.submit();
					}
				}
			});// 끝

			
			// 신고 메소드
			document.querySelectorAll(".btn-report").forEach((button) => {
				button.onclick = (e) => {
					if(confirm("신고 하시겠습니까?")){
						const frm = document.newsCommentReport
					 
						frm.submit();
					}
				}
			});// 끝
			

		</script>

<!-- ----------------------------------------------------- -->

	<!-- 삭제 본인 -->
	<form 
		action="<%= request.getContextPath() %>/News/NewsCommentDelete" 
		name="newsCommentDelFrmMember"
		method="POST">
		<input type="hidden" name="commentState" value = "1" />
		<input type="hidden" name="commentNo" value="<%= newsComment.getCommentNo() %>"/>
	</form><!--  끝  -->
	
	<!-- 삭제 관리자 -->
	<form 
		action="<%= request.getContextPath() %>/News/NewsCommentDelete" 
		name="newsCommentDelFrmAdmin"
		method="POST">
		<input type="hidden" name="commentState" value = "2" />
		<input type="hidden" name="commentNo" value="<%= newsComment.getNewsNo() %>"/>
	</form><!--  끝  -->
	
	<!-- 신고 본인 ( 수정해야함 ) -->
	<form 
		action="<%= request.getContextPath() %>/News/NewsCommentReport" 
		name="newsCommentReport"
		method="POST">
		<input type="hidden" name="commentState" value = "2" />
		<input type="hidden" name="commentNo" value="<%= newsComment.getNewsNo() %>"/>
	</form><!--  끝  -->

<!-- ----------------------------------------------------- -->

 
<div id="newsNo" style = "display : none" ><%= news.getNewsNo() %></div> <!--  넘버값 가져오기위함 -->

<!-- ----------------------------------------------------- -->
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


<!-- ----------------------------------------------------- -->
<!--  관리자에게만 보이는 기사 삭제 버튼 -->
  
  <div id="deletButton">
  <button id="deletButtonbtn" style="font-size: 30px; border: none; background: none; padding: 0; margin: 0; cursor: pointer;">
    삭제 
  </button>
  </div>


<!-- ----------------------------------------------------- -->

<br/><br/><br/>
  

</section>

<!-- ----------------------------------------------------- -->




<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>