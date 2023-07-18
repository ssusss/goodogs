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

<!--  기사 페이지  -->
<!-- ----------------------------------------------------- -->	

<%
	News news = (News) request.getAttribute("news");
	List<NewsComment> newsComments  = (List<NewsComment>)request.getAttribute("newsComments");
	NewsComment newsComment = (NewsComment)request.getAttribute("NewsComment");
%>

<style>
/* 혜령 */
  /* 말풍선 스타일 */
  .highlight-tooltip {
    position: absolute;
    background-color: #fff;
    border: 1px solid #ccc;
    padding: 5px;
    font-size: 12px;
    border-radius: 4px;
    z-index: 9999;
  }
</style>

<!-- ----------------------------------------------------- -->	

<script>
	const bannerContainerLower = document.querySelector(".bannerContainerLower");
	bannerContainerLower.style.display = "none";
	
	window.onload = () => {
		//newsComment();
		
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
	 
	<div class="newsContent"><%=news.getNewsContent()%> 
	
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
</section>

<div class="highlight-tooltip" style="display: block;">북마크</div>


<script>
let selection2 = null;

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

// 북마크 말풍선 찾아냄
const tooltip = document.querySelector('.highlight-tooltip');


// 하이라이트된 내용을 저장
function saveHighlight() {
	
	 let highlightedContent = window.getSelection().toString().trim(); // 선택한 텍스트 문자열로 반환하고 앞뒤 공백 제거
	    console.log("highlightedContent : " + selection2); // 선택한 내용을 확인하기 위해 콘솔에 출력
	
	 if (highlightedContent !== '') {
	    hideTooltip(); // 말풍선 숨김
	    }
}

// mouseup 이벤트 발생 시 말풍선 표시
document.addEventListener('mouseup', function(event) {
  // console.log("mouseup 실행됨")
  const selection = window.getSelection(); // 드래그한거 selection에 담기
  
  //console.log("selection 실행됨 : " + selection)
  
  if (selection.toString().trim() !== '') { // 문자열 앞뒤 공백 제거 후 비어있지 않은지 확인
	  const range = selection.getRangeAt(0);
	  const rect = range.getBoundingClientRect();
	  const x = rect.left + rect.width / 2;
	  const y = rect.top + window.pageYOffset;
	  selection2 = selection.toString(); // 전역에 선언해둔 selection2 에 selection 담기
    //console.log("selection2 : " + selection2);
    showTooltip(x, y);
    
  } else {
    hideTooltip(); // 말풍선 숨김
  }
});

// 말풍선 클릭 시 하이라이트 저장
 tooltip.addEventListener('click', function() {
    	  saveHighlight();
    	});

</script>








<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>