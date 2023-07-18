<%@page import="com.sk.goodogs.like.model.vo.LikeList"%>
<%@page import="com.sk.goodogs.news.model.vo.NewsComment"%>
<%@page import="java.util.List"%>
<%@page import="com.sk.goodogs.news.model.vo.News"%>
<%@page import="com.sk.goodogs.news.model.vo.NewsScript"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>
<!--  기사 페이지  -->
<!-- ----------------------------------------------------- -->	

<%
	// 전수경 : 좋아요수는 별개로 조회해서 설정해야 함
	News news = (News) request.getAttribute("news");
	List<NewsComment> newsComments  = (List<NewsComment>)request.getAttribute("newsComments");
	NewsComment newsComment = (NewsComment)request.getAttribute("NewsComment");

%>

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
<!-- 좋아요 -->
<div id="likeButton">
  <button id="likeButtonBtn" style="font-size: 30px; border: none; background: none; padding: 0; margin: 0; cursor: pointer;">
    <i class="fa-solid fa-heart" name="like-heart" id="like-heart"></i>
    좋아요
    <span id="newsLikeCnt"><%= news.getNewsLikeCnt() %></span> 
  </button>
</div>

<style>
#like-heart {
	color: grey;
}
#like-heart.like {
	color: #e90c4e;
}
</style>

<script>
	const likeIcon = document.getElementById('like-heart');
	const likeClassList = likeIcon.classList;


  /**
  	@author 전수경
  	 - 로그인회원의 좋아요 유무확인
  	 - 좋아요했으면 빈 하트, 좋아요했으면 빨간하트
  */
  const loadLike = () => {
	  // 회원의 뉴스 좋아요 여부 확인
	  $.ajax({
		  url: "<%= request.getContextPath() %>/like/checkLikeState",
		  dataType : "json",
		  type: "GET",
		  data: {
			  newsNo : <%= news.getNewsNo() %>,
			  memberId : "<%= loginMember.getMemberId() %>"
		  },
		  success(likeState){
			  console.log("likeState="+likeState);
			  
			  if(likeState === 1){
				// 회원이 좋아요한 상태 (빨간색)
				  likeClassList.add("like");
				
			  } else {
				// 회원이 좋아요 안한 상태
				  likeClassList.remove("like");
			  }
		  }
	  })
  };
  
  /**
  	- 좋아요 바꾸기
  */
	document.querySelector("#likeButtonBtn").onclick = (e) => {
		console.log(e.target);
		console.log("likeClassList="+likeClassList);
		const flag = likeClassList.contains("like");
		console.log(flag);
		let newsLikeCnt = document.querySelector('#newsLikeCnt').innerHTML;
		console.log("newsLikeCnt="+newsLikeCnt);

		if(flag){
			// like가 있다면 좋아요 취소
			$.ajax({
				url: "<%= request.getContextPath() %>/like/updateLike",
				dataType : "json",
				type: "POST",
				data: {
					method : "delete",
					newsNo : <%= news.getNewsNo() %>,
					memberId : "<%= loginMember.getMemberId() %>"
				},
				success(result){
					likeClassList.remove("like");
					console.log("result="+result);
				},
				complete(){
					newsLikeCnt = number(newsLikeCnt) - 1;
					console.log("newsLikeCnt="+newsLikeCnt);
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
					newsNo : <%= news.getNewsNo() %>,
					memberId : "<%= loginMember.getMemberId() %>"
				},
				success(result){
					likeClassList.add("like");
					console.log("result="+result);
				},
				complete(){
					newsLikeCnt = number(newsLikeCnt) + 1;
					console.log("newsLikeCnt="+newsLikeCnt);
				}
			});
		}
		
	};
	
	  
  (()=>{
	  loadLike();
  })();
	    
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