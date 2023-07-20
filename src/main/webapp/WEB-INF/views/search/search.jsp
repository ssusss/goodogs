<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
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
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/search.css" />
<section>
	<div class="searchWrapper">
		<div class="searchContainer">
			<div class="searchBoxContainer">
				<input type="text" name="searchKeyword" placeholder="무엇이 알고싶개?" id="newsName">
				<button type="button" onclick="searchNews()">검색!</button>
			</div>
			<div class="searchImageContainer">
				<img src="<%= request.getContextPath() %>/images/character/goodogs_think.png" alt="sadImage" class="imageFile"/>
			</div>			
		</div>
		<div class="keywordContainer">
			<h1>구독이 추천 키워드 Top5</h1>
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
	
	$.ajax({
		  url: "<%= request.getContextPath() %>/goodogs/ranking",
		  success: function (news) {
		    console.log(news);

		    const tbody = document.querySelector(".keywordContainer tbody");
		    let i = 1;

		    if (news.length > 0) {
		      news.forEach((news) => {
		        const { newsTitle, newsLikeCnt, newsNo } = news;
		        const row = document.createElement("tr");
		        row.innerHTML = `
		          <td>\${i}</td>
		          <td><a href="/goodogs/news/newsDetail?no=\${newsNo}" 
		        		  style="text-decoration: none; color: inherit;">\${newsTitle}</a></td>
		          <td>\${newsLikeCnt}개</td>
		        `;
		        tbody.appendChild(row);

		        i++;
		      });
		    } else {
		      const row = document.createElement("tr");
		      row.innerHTML = `<td colspan='3'>조회된 뉴스가 없습니멍.</td>`;
		      tbody.appendChild(row);
		    }
		  },
		});

	
	function searchNews() {
		  const searchKeywordVal = document.getElementById("newsName").value;
		  
		  console.log(searchKeywordVal);
		  
		  location.href = '<%=request.getContextPath()%>/search/news/?keyword=' + searchKeywordVal;
		  
		}
	
	
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>


