<%@page import="java.io.Console"%>
<%@page import="com.sk.goodogs.news.model.vo.NewsAndImage"%>
<%@page import="com.sk.goodogs.like.model.vo.LikeList"%>
<%@page import="com.sk.goodogs.news.model.vo.NewsComment"%>
<%@page import="java.util.List"%>
<%@page import="com.sk.goodogs.news.model.vo.News"%>
<%@page import="com.sk.goodogs.news.model.vo.NewsScript"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/news.css"/>
<!--  기사 페이지  -->
<%
	NewsAndImage newsAndImage = (NewsAndImage) request.getAttribute("newsAndImage");
	News news = (News)request.getAttribute("News");
	
	int isLiked = (int) request.getAttribute("isLiked"); // 0: 좋아요안함, 1: 좋아요함
	int newsLikeCnt = newsAndImage.getNewsLikeCnt();
	
	
	List<NewsComment> newsComments  = (List<NewsComment>)request.getAttribute("newsComments");
	NewsComment newsComment = (NewsComment)request.getAttribute("NewsComment");

	String _category = "";
    
	switch (newsAndImage.getNewsCategory()) {
		case "정치" : _category = "politics"; break;
		case "경제" : _category = "economy"; break;
		case "세계" : _category = "global"; break;
		case "테크" : _category = "tech"; break;
		case "환경" : _category = "environment"; break;
		case "스포츠" : _category = "sports"; break;
		case "사회" : _category = "society"; break;
	}
	
	String tagArr[] = newsAndImage.getNewsTag().split(",");
%>

<!-- ----------------------------------------------------- -->	

<!--  기사 가져오기 ( 완료 )   -->
<div id="newHeader">
	<h4 id="news-category" name="news-category" style="color: #008000">
		<a href="<%= request.getContextPath() %>/tag/<%= _category %>">
			<%=newsAndImage.getNewsCategory()%>
		</a>
	</h4> <!--  카테고리  -->

	<h1 id="news-title" name="news-title" ><%=newsAndImage.getNewsTitle() %></h1><!--  제목  -->
 	
 	<h4 id="news-confirmed-date" name="news-confirmed-date" ><%= newsAndImage.getNewsConfirmedDate().toString().split(" ")[0] %></h4>
</div>  

<section id="news-container">
	<div id="img-container">
		<img id="news-img" name="news-img" style="width: 600px;" src="<%= request.getContextPath() %>/upload/newsImage/<%=newsAndImage.getRenamedFilename()%>"><!--  이미지  -->
	</div>
							 
	<div id="news-content" name="news-content"><%=newsAndImage.getNewsContent()%></div><!--  내용  -->
	 
	<br/><br/><br/>
	<div id="news-tag-container">
		<div class="news-tag">
			<a href="<%= request.getContextPath() %>/tag/<%= _category %>">#<%= tagArr[0] %></a>
		</div>
		<% for (int i = 1; i < tagArr.length; i++) { %>
		<div class="news-tag">
			<a href="<%=request.getContextPath()%>/search/news/?keyword=<%= tagArr[i] %>">#<%= tagArr[i] %></a>
		</div>
		<% } %>
	</div>


<!-- 좋아요 --> <!--  진행도 ( 완성 )  -->

<br>
<br>

<div id="likeButton">
  <button id="likeButtonBtn">
    <i class="fa-solid fa-heart fa-lg" name="like-heart" id="like-heart"></i>
    좋아요
    <span id="newsLikeCnt"><%= newsLikeCnt %></span> 
  </button>
</div>

<!-- ----------------------------------------------------- -->

<br>
<% if (loginMember != null && loginMember.getMemberRole() == MemberRole.A) {%>
	<!--  관리자에게만 보이는 기사 삭제 버튼 --> <!--  진행도 (다 하고 확인중 ) -->
  <div id="deletNewsButton">
		<input id="deletNewsButtonMre" type="button" value="기사 삭제" onclick="deleteBoard()">
  </div>
<% } %>
  <!-- 기사 삭제 --> 
	<form 
		action="<%= request.getContextPath() %>/News/NewsDelete" 
		name="newsDelFrm"
		method="POST">
		<input type="hidden" name="newsNo" value="<%= newsAndImage.getNewsNo() %>"/>
	</form><!--  끝  -->
	
<!-- ----------------------------------------------------- -->	
<div id="newsNo" style = "display : none" ><%= newsAndImage.getNewsNo() %></div> <!--  넘버값 가져오기위함 -->
<!--  댓글 작성할수 있는 칸  -->
<div id="comment-container">
<% 	if(loginMember != null) { %>

 <div class="comment-editor">
            <form
				action="<%=request.getContextPath()%>/news/newsCommentCreate" 
				method="post" 
				name="NewsCommentFrm">
                <input type="hidden" name="newsNo" value="<%= newsAndImage.getNewsNo()%>" />
                <input type="hidden" name="newsCommentWriter" value="<%= loginMember != null ? loginMember.getMemberId() : "" %>" />
                <input type="hidden" name="newsCommentLevel" value="1" />  
               <input type="hidden" name="newsCommentNickname" value="<%= loginMember.getNickname() %>" />
               <input type="hidden" name="commentNoRef" value="0" />
				<textarea class="newsCommentContent" name="newsCommentContent" cols="50" rows="3"></textarea>
                <button type="submit" id="btn-comment-enroll1">등록</button>
            </form>
 </div><!-- end -->
<% 	}else {%>
	<div> 로그인 후 댓글작성이 가능합니다. </div>
<% } %>

<!--------------------------------------------------------->	      
<table id="comment">
		
		<thead>
			
		</thead>
		
			<tbody>
				<!-- 댓글 들어가는 창 -->
			</tbody>
</table> <!-- end -->

<br/><br/><br/>

<!--------------------------------------------------------->

<!--   form  진행도 ( 삭제 완성 / 오류테스트만 진행하면 끝 )  / 신고는 좋아요 완성후 수정예정   -->
	<!-- 삭제 본인 -->
<form 
  action="<%= request.getContextPath() %>/News/NewsCommentDelete" 
  id="newsCommentDelFrmMember"
  method="POST">
  <input type="hidden" name="commentState" value="1" />
  <input type="hidden" name="commentNo" />
  <input type="hidden" name="newsNo"  value="<%= newsAndImage.getNewsNo() %>" />
</form><!--  끝  -->

	<!-- 삭제 관리자 -->
<form 
  action="<%= request.getContextPath() %>/News/NewsCommentDelete" 
  id="newsCommentDelFrmAdmin"
  method="POST">
  <input type="hidden" name="commentState" value="2" />
  <input type="hidden" name="commentNo"  />
   <input type="hidden" name="newsNo"  value="<%= newsAndImage.getNewsNo() %>" />

</form><!--  끝  -->
	



</section>

<!-- 북마크 말풍선 -->
<div class="highlight-tooltip" style="display: none;">북마크</div>

<script>
<!--start-----------start----------------start--------------------start---------start------------------------------------------------------ ----------------------------------------------------- ------------------------------------------------------>

const bannerContainerLower = document.querySelector(".bannerContainerLower");
bannerContainerLower.style.display = "none";

window.onload = () => {
	newsComment();
}

// 기사 삭제 
const deleteBoard = () => {
		if(confirm("뉴스를 삭제하시겠습니까?"))
			document.newsDelFrm.submit();
	};	
	
<!--------------------------------------------------------->	

<!-- 더보기 -->




<!----------------->
	
	// 댓글  리스트 ( 시좍 ~~~ )
	function newsComment(frm){
		const no = <%= newsAndImage.getNewsNo()%>;
		console.log(no);
			$.ajax({
				url: "<%= request.getContextPath() %>/news/newsCommentList", 
				data : {no},
				method :"GET",
				dataType :"json",
				success(newsComments) {
					
					console.log(" 1 ");
					
				const tbody= document.querySelector("#comment tbody");
				//const trdel1= document.querySelector("#level1 tr");
				//const trdel2 = document.querySelector("#level2 tr");
				
					
	
				if (newsComments.length === 0 ){ // 작성된 댓글이 없는경우 
				
					console.log(" 3 ");
					
					tbody.innerHTML += `
			        	<tr class="level1Del">
			              <td>
			              	  작성된 댓글이 없습니다.
			              </td>
			            </tr>
			            `;
			            
				}else{
	
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
			        
			   
					
			        if (newsCommentLevel === 1) {// 댓글인 경우 ---------------------------------------------------------------------------------------
			        	
						 
			        	 if  ( commentState === 1 ){// 작성자 삭제 글씨 처리-----------------------------
			        			
			        		 console.log(" 삭제  "); 
								
				        	 tbody.innerHTML += `
				        	<tr class="level1Del">
				              <td>
				                <sub class="comment-writer"> \${newsCommentNickname} </sub>
				              	  작성자가 삭제한 메세지입니다
				              </td>
				            </tr>
				            `;
						  
			        
				            //----------------
				            
				        	
				        }else if ( commentState === 2 ) {// 관리자 삭제 글씨 처리-----------------------------

				       	 console.log(" 삭제2  "); 
				        
				        	 tbody.innerHTML += `
				        	<tr class="level1Del">
				              <td>
				                <sub class="comment-writer"> \${newsCommentNickname} </sub>
				           	     관리자가 삭제한 메세지입니다
				              </td>
				            </tr>
				            `;
				        	
				            
				        }else {// 삭제가 안된 댓글 ( 정상 댓글 )  처리-----------------------------
			
					          tbody.innerHTML += `
					          
					            <tr class="level1">
					              <td>
					                <sub class="comment-writer"> \${newsCommentNickname} </sub>
					                \${newsCommentContent}
					                </td>
					           `;
					          
					          //---버튼처리 -------------
						      
							   <% if (loginMember != null && loginMember.getMemberRole() == MemberRole.A) {%> // 관리자일경우 보임  (어드민 아이디 == 로그인 회원 아이디)
							       
							   console.log(" 관리자일경우2  "); 
							   tbody.innerHTML += `
											  <td>
									        	  <button class="btn-reply" value="\${commentNo}" >답글</butto>
									        	  <button class="btn-member-delete" value="\${commentNo}">삭제</button>
									        	  <button class="report" value="\${commentNo}" >신고</button>
											        
										          <button>관리자</button>
									          </td>
								            </tr>
								     `;

							  	  <%  }else if (loginMember == null){%> 
							  	  
							  	 console.log(" 비회원2  "); 
							     tbody.innerHTML += `
							            </tr>
							     `;
							  	  // 로그인 안한 회원은 아무것도 안보인다. ( 버튼이 ) 
								  
								  <% }else if(loginMember != null && loginMember.getMemberRole() == MemberRole.M ){ %>// 일반 회원일때 보이는 버튼   (로그인 회원)
								  
								  console.log(" 회원일때2  "); 
								  
								  tbody.innerHTML += `
												<td>
										         <button class="report" value="\${commentNo}" >신고</button>
										         <button class="btn-reply" value="\${commentNo}" >답글</button>
										         <button class="btn-member-delete" value="\${commentNo}">삭제</button>
										         <button>회원</button>
										         </td>    	
									         </tr>
									  `;

								  
								  <%  }else if (loginMember != null){ %> // 작성자 본인일때 보이는 버튼 (작성자 아이디 == 로그인 회원 아이디 )
								  
								  console.log(" 작성자2  "); 
								  
								  tbody.innerHTML += `
									 		 <td>
									         <button class="btn-reply" value="\${commentNo}" >답글</button>
									         <button class="btn-member-delete" value="\${commentNo}">삭제</button>
									         <button class="report" value="\${commentNo}" >신고</button>
										        
									         <button>작성자</button>
									         </td>    	  	
									      </tr>
									     `;
								  
								 
								  
								  <%  } %> // 버튼 끝 -------------
								
								  
				        	
				        }
			        
			         
			          //--------------------------------------------------------------
			          
			          
			        } else if (newsCommentLevel === 2) {    // 대댓글인 경우 
			        	

			        	 if  ( commentState === 1 ){// 작성자 삭제 글씨 처리-----------------------------
			        			
			        		 console.log(" 삭제  "); 
								
				        	 tbody.innerHTML += `
				        	<tr class="level1Del">
				              <td>
				                <sub class="comment-writer"> \${newsCommentNickname} </sub>
				              	  작성자가 삭제한 메세지입니다
				              </td>
				            </tr>
				            `;
						  
			        
				            //----------------
				            
				        	
				        }else if ( commentState === 2 ) {// 관리자 삭제 글씨 처리-----------------------------

				       	 console.log(" 삭제2  "); 
				        
				        	 tbody.innerHTML += `
				        	<tr class="level1Del">
				              <td>
				                <sub class="comment-writer"> \${newsCommentNickname} </sub>
				           	     관리자가 삭제한 메세지입니다
				              </td>
				            </tr>
				            `;
				        	
				            
				        }else {// 삭제가 안된 댓글 ( 정상 댓글 )  처리-----------------------------
			
					          tbody.innerHTML += `
					          
					            <tr class="level2">
					              <td>
					                <sub class="comment-writer"> \${newsCommentNickname} </sub>
					                \${newsCommentContent}
					                </td>
					           `;
					          
					          //---버튼처리 -------------
						      
							   <% if (loginMember != null && loginMember.getMemberRole() == MemberRole.A) {%> // 관리자일경우 보임  (어드민 아이디 == 로그인 회원 아이디)
							       
							   console.log(" 관리자일경우2  "); 
							   tbody.innerHTML += `
											  <td>
									        	  <button class="btn-member-delete" value="\${commentNo}">삭제</button>
										          <button>관리자</button>
									          </td>
								            </tr>
								     `;

							  	  <%  }else if (loginMember == null){%> 
							  	  
							  	 console.log(" 비회원2  "); 
							     tbody.innerHTML += `
							            </tr>
							     `;
							  	  // 로그인 안한 회원은 아무것도 안보인다. ( 버튼이 ) 
								  
								  <% }else if(loginMember != null && loginMember.getMemberRole() == MemberRole.M ){ %>// 일반 회원일때 보이는 버튼   (로그인 회원)
								  
								  console.log(" 회원일때2  "); 
								  
								  tbody.innerHTML += `
												<td>
										         <button class="report" value="\${commentNo}" >신고</button>
										         <button class="btn-member-delete" value="\${commentNo}">삭제</button>
										         <button>회원</button>
										         </td>    	
									         </tr>
									  `;

								  
								  <%  }else if (loginMember != null){ %> // 작성자 본인일때 보이는 버튼 (작성자 아이디 == 로그인 회원 아이디 )
								  
								  console.log(" 작성자2  "); 
								  
								  tbody.innerHTML += `
									 		 <td>
									         <button class="btn-member-delete" value="\${commentNo}">삭제</button>
									         <button>작성자</button>
									         </td>    	  	
									      </tr>
									     `;
								  
								 
								  
								  <%  } %> // 버튼 끝 -------------
								  
				     	   } // 정상댓글인경우 끝 
				        	
				        } // 대댓글인경우
			        
			         
			          //--------------------------------------------------------------
			          
			          
			          
			 					    
			  		      
			 				     }); // forEach 끝
					
							} // if (newsComment == 0  ){끝 

						} // success 끝
					
					
				 }); // ajax 끝
				 
			return false;
				 
		 }; // funtion 끝 
		 
<!--댓글 끝  ----------------------------------------------------- -->		

			
document.addEventListener("click", (e) => {
	
						  if (e.target.matches("button[class='btn-member-delete']")) { 
							  
						    if (confirm("해당 댓글을 삭제하시겠습니까?")) {
						      const frm = document.getElementById("newsCommentDelFrmMember");
						      const {value} = e.target;
						      frm.commentNo.value = value;
						      frm.submit();
						      
						    }
						    
						  }else if (e.target.matches("button[class='btn-admin-delete']")) {
							  
						    if (confirm("해당 댓글을 삭제 처리 하시겠습니까?")) {
						      const frm = document.getElementById("newsCommentDelFrmAdmin");
						      const {value} = e.target;
						      frm.commentNo.value = value;
						      frm.submit();
							    }
						    
						    }else if (e.target.matches("  button[class='btn-reply'] ")) {
						    			const {value} = e.target;
						    			
						    			const parentTr = e.target.parentElement.parentElement; //  클릭된 버튼의 부모 요소의 부모 요소를 parentTr 변수에 할당
						    			console.log(parentTr);
						    			const tr = `
						    				<div id="comment-container">
							    				 <div class="comment-editor">
						    				<tr>
						    					<td colspan="2">
						    				            <form
						    								action="<%=request.getContextPath()%>/news/newsCommentCreate" 
						    								method="post" 
						    								name="NewsCommentFrm">
						    				                <input type="hidden" name="newsNo" value="<%= newsAndImage.getNewsNo()%>" />
						    				                <input type="hidden" name="newsCommentWriter" value="<%= loginMember != null ? loginMember.getMemberId() : "" %>" />
						    				                <input type="hidden" name="newsCommentLevel" value="2" />  
						    				                <input type="hidden" name="newsCommentNickname" value="<%= loginMember != null ? loginMember.getNickname() : ""%>" />
						    				                <input type="hidden" name="commentNoRef" value="\${value}" />
						    								<textarea name="newsCommentContent" cols="50" rows="3"></textarea>
						    				                <button type="submit" id="btn-comment-enroll1">등록</button>
						    				            </form>
						    				       </td>
						    					</tr>
						    				
						    				 </div>
						    			</div>
						    			`;
						    			// beforebegin 시작태그전 - 이전형제요소로 추가
						    			// afterbegin 시작태그후 - 첫자식요소로 추가
						    			// beforeend 종료태그전 - 마지막요소로 추가
						    			// afterend 종료태그후 - 다음형제요소로 추가
						    			parentTr.insertAdjacentHTML('afterend', tr);
						    			button.onclick = null; // 이벤트핸들러 제거 (1회용)
						    			
						    }else if(e.target.matches("  button[class='report'] ")) {
						    	// 신고하기...!!!!!!!!
						    	
							  			  		  const {value} = e.target;
							  				    console.log(value);
			    		    		
			    		   					 // 삭제 여부 확인 
			    		    				$.ajax({
			    		    					url: "<%= request.getContextPath() %>/news/newsCommentReport",
			    		    					dataType : "json",
			    		    					type: "GET",
			    		    					data: {
			    		    						commentNo : value,
			    		    						memberId : "<%= loginMember != null ? loginMember.getMemberId() : "" %>"
			    		    					},
			    		    					
			    		    					success(reportCnt){
			    		    						  console.log(reportCnt);
			    				    		    		
			    		    					
			    		    						if(reportCnt  === 1 ){
						    		    				// 	신고처리가 이미 있다면 이미 신고된 댓글입니다 라고 경고창 띄어짐 
						    
						    		    				alert("이미 신고된 댓글이개..");
						    		    				
						    		    		
						    		    			}else if (reportCnt === 0) {
						    		    				// 신고한 이력이 없어야만 신고가 가능 / 신고를 이미 했다면 작동안됨 
						    		    				$.ajax({
						    		    					url: "<%= request.getContextPath() %>/news/newsCommentReportUpdate",
						    		    					dataType : "json",
						    		    					type: "POST",
						    		    					data: {
						    		    						commentNo : value,
						    		    						memberId : "<%= loginMember != null ? loginMember.getMemberId() : "" %>"
						    		    					},
						    		    					success(result){
						    		    						alert("신고 완료되었개!🦴");
						    		    					}
						    		    				});
						    		    			}
			    		    					}
			    		    					
			    		    				});
			    		    			
								    		    			
					
						  
							 } //  if 문 끝 esle
		    
	      
	});// event 끝
			
			
<!------------------------------------------- -->		
			
	

				
			
			
			

	
	
<!--------------------------------------------->	
/**
 *  @author 전수경
 *  - 좋아요 기능
 **/
const likeIcon = document.getElementById('like-heart'); // 하트 아이콘
const likeClassList = likeIcon.classList; // 하트 아이콘의 클래스 리스트

/**
 * - 로그인회원의 좋아요 유무확인
 * - 좋아요했으면 빈 하트, 좋아요했으면 빨간하트
 */
if (<%= loginMember != null %>) {

	// 좋아요 수정   
	document.querySelector("#likeButtonBtn").onclick = (e) => {
		console.log(e.target);
		console.log("likeClassList="+likeClassList);
		const flag = likeClassList.contains("like");
		console.log(flag);
		const newsLikeCnt = <%= newsLikeCnt %>;

		if(flag){
			// like가 있다면 좋아요 취소
			$.ajax({
				url: "<%= request.getContextPath() %>/like/updateLike",
				dataType : "json",
				type: "POST",
				data: {
					method : "delete",
					newsNo : <%= newsAndImage.getNewsNo() %>,
					memberId : "<%= loginMember != null ? loginMember.getMemberId() : "" %>"
				},
				success(updatedLikeCnt){
					likeClassList.remove("like");
					document.querySelector('#newsLikeCnt').innerHTML = updatedLikeCnt;
					console.log("좋아요 취소 성공!");
				}
			});
		} else {
			// like가 없다면 좋아요 등록	
			$.ajax({
				url: "<%= request.getContextPath() %>/like/updateLike",
				dataType : "json",
				type: "POST",
				data: {
					method : "insert",
					newsNo : <%= newsAndImage.getNewsNo() %>,
					memberId : "<%= loginMember != null ? loginMember.getMemberId() : "" %>"
				},
				success(updatedLikeCnt){
					likeClassList.add("like");
					document.querySelector('#newsLikeCnt').innerHTML = updatedLikeCnt;
					console.log("좋아요 등록 성공!");
				}
			});
		}

		
	};
}
	
//----------------------끝    
/**
 *  @author 이혜령
 *  - 북마크 기능
 **/

  	let selection2 = null;

	//북마크 말풍선 찾아냄
	const tooltip = document.querySelector('.highlight-tooltip');

	//말풍선을 표시할 위치와 내용 설정
	// tooltip.offsetHeight : tooltip 요소의 높이
	function showTooltip(x, y) {
	 tooltip.style.display = 'block';
	 tooltip.style.left = x + 'px';
	 tooltip.style.top = y - tooltip.offsetHeight - 10 + 'px';
	}
	
	//말풍선 숨김
	function hideTooltip() {
	 tooltip.style.display = 'none';
	}
	
	//말풍선 클릭 시 하이라이트 저장
	function handleTooltipClick(e) {
		
		// 북마크 회원 유효성 검사
		const loginMemberId = "<%= loginMember != null ? loginMember.getMemberId() : "" %>";
		if (loginMemberId === '') {
			alert("북마크 기능은 회원만 사용 가능합니다🙅");
			return;
		}
 
		$.ajax({
			url: "<%= request.getContextPath() %>/bookmark/bookmarkInsert",
			data: {
					memberId: "<%= loginMember != null ? loginMember.getMemberId() : "" %>",
					newsNo: <%= newsAndImage.getNewsNo() %>,
					newsTitle: "<%= newsAndImage.getNewsTitle() %>",
			        bookmarkedContent: selection2
				  },
			method: "POST",
			dataType: "json",
			success(responseData) {
				console.log(responseData);
				//console.log(newsTitle);
				}
			});
				e.preventDefault();
		}

	// mouseup 이벤트 발생 시 말풍선 표시
	document.addEventListener('mouseup', function(event) {

	const selection = window.getSelection(); // 드래그 한 텍스트를 나타내는 selection 객체 반환
		
		if (selection.toString().trim() !== '') {
			const range = selection.getRangeAt(0); // selection 객체에서 첫번째 선택 영역 
			const rect = range.getBoundingClientRect(); // range 객체가 텍스트 선택 영역의 크기와 위치 정보를 담음
			const x = rect.left + rect.width / 2; // 선택 영역 왼쪽좌표 + 선택 영역의 너비/2 = 선택 영역의 가운데 x좌표 
			const y = rect.top + window.pageYOffset; // 선택 영역 상단좌표 + 현재 문서의 수직 스크롤 위치
   
			selection2 = selection.toString(); 

			// 말풍선 클릭 이벤트 핸들러 등록
			tooltip.addEventListener('click', handleTooltipClick);

			// 말풍선 위치 나타내기
			showTooltip(x, y);
   
		} else {
			hideTooltip(); // 말풍선 숨김
		}
	});




</script>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>