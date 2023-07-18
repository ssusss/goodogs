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
	<div id="news-category" name="news-category"><%=news.getNewsTag()%></div> <!--  카테고리  -->
	
	<h2 id="news-title" name="news-title"><%=news.getNewsTitle() %><!--  제목  --></h2>
	
	<div id="news-img" name="news-img"> 이미지 </div> <br>
	 
	<div id="news-content" name="news-content">
	<%= news.getNewsContent()%> 
	<br>
	나를 묶고 가둔다면 뱃길따라 이백리 외로운 섬하나 새들의 고향 그누가 아무리 자기 땅이라 우겨도 독도는 우리땅
	</div>
	 
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
		newsLikeCnt = Number(newsLikeCnt);

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
					document.querySelector('#newsLikeCnt').innerHTML = newsLikeCnt-1;
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
					document.querySelector('#newsLikeCnt').innerHTML = newsLikeCnt+1;
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

<div class="highlight-tooltip" style="display: block;">북마크</div>
<script>
// 말풍선을 표시할 위치와 내용 설정
function showTooltip(x, y) {
  tooltip.style.display = 'block';
  tooltip.style.left = x + 'px';
  tooltip.style.top = y - tooltip.offsetHeight - 10 + 'px';
}


// 말풍선을 숨김
function hideTooltip() {
  tooltip.style.display = 'none';
}

const tooltip = document.querySelector('.highlight-tooltip');


// 하이라이트된 내용을 저장
function saveHighlight() {
    let highlightedContent = window.getSelection().toString().trim(); // 선택한 텍스트 문자열로 반환하고 앞뒤 공백 제거
        console.log(highlightedContent); // 선택한 내용을 확인하기 위해 콘솔에 출력


    if (highlightedContent !== '') {
            hideTooltip(); // 말풍선 숨김
          }
}

// mouseup 이벤트 발생 시 말풍선 표시
document.addEventListener('mouseup', function(event) {
  console.log("mouseup 실행됨")
  const selection = window.getSelection();

  console.log("selection 실행됨" + selection)

  if (selection.toString().trim() !== '') { // 문자열 앞뒤 공백 제거 후 비어있지 않은지 확인
      const range = selection.getRangeAt(0);
      const rect = range.getBoundingClientRect();
      const x = rect.left + rect.width / 2;
      const y = rect.top + window.pageYOffset;

    showTooltip(x, y);
  } else {
    hideTooltip();
  }
});

// 말풍선 클릭 시 하이라이트 저장
tooltip.addEventListener('click', function() {
  saveHighlight();
});

</script>





<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>