<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reporter.css" />
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>
<script src="<%= request.getContextPath() %>/js/jquery-ui.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script>
bannerContainerUpper = document.querySelector(".bannerContainerUpper");
bannerContainerLower = document.querySelector(".bannerContainerLower");
navBox = document.querySelector(".navBox");

bannerContainerUpper.style.display = "none";
bannerContainerLower.style.display = "none";
navBox.style.display = "none";
</script>

<style>
section {
	border: 1px solid black;
	height: 800px;
}
.searchWrapper {
	border: 1px solid black;
	width: 90%;
	margin: 0 auto;
	height: 800px;
	display: flex;
}

.searchContainer {
	width: 50%;
	height: 800px;
}

.keywordContainer {
	border: 1px solid black;
	width: 50%;
	height: 800px;
}
.searchBoxContainer {
	border: 1px solid black;
}
.searchImageContainer {
position: absolute;
	border: 1px solid black;
	width: 300px;
	height: 300px;
	margin: 450px 150px;
}
table {
	border: 1px solid black;
	border-collapse: collapse;
}
table th, table tr, table td {
	border: 1px solid black;
}
</style>

<section>
	<div class="searchWrapper">
		<div class="searchContainer">
			<form action="">
				<div class="searchBoxContainer">
					<input type="text" placeholder="무엇이 알고싶개?" id="newsName">
					<button type="submit">검색!</button>
				</div>
			</form>	
			<div class="searchImageContainer">
			
			</div>			
		</div>
		<div class="keywordContainer">
			<h1>구독이 추천 키워드</h1>
			<table>
				<thead>
					<tr>
						<th>랭킹</th>
						<th>제목</th>
						<th>좋아요</th>
					</tr>
				</thead>
				<tbody>
				
				</tbody>
			</table>
		</div>
	</div>



</section>	
<script>
	$("#newsName").autocomplete({
	/*
	 * 사용자입력값을 받아, 서버에 ajax요청하고, 결과를 jquery-ui쪽으로 값을 반환
	 */
	source (request, response){
		console.log(request);
		
		const {term} = request;
		
		$.ajax({
			url : "<%= request.getContextPath()%>/news/csv/autocomplete",
			method : "GET",
			dataType : "text",
			data : {
				term
			},
			success(newsName){
				if(newsName === '') return;
				
				console.log(newsName);
				
				const temp = newsName.split("$");
				const arr = temp.map((newsName) => ({
					label : newsName,
					value : newsName
				}));
				console.log(arr);
				response(arr);
			}
		});
	},
	select(event, selected) {
  	  console.log(event, selected);
  	  const {item : {value}} = selected;
    }
	
});
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>