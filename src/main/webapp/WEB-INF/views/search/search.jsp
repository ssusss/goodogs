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

    .searchBoxContainer {
      border: 1px solid black;
    }

    .tble-newsContainer {
      margin-top: 20px;
      border: 1px solid black;
    }

    #tbl-news {
      border-collapse: collapse;
      width: 100%;
    }

    #tbl-news th,
    #tbl-news td {
      border: 1px solid black;
      padding: 8px;
      text-align: center;
    }

    #tbl-news thead tr {
      background-color: #f2f2f2;
    }

    #tbl-news tbody tr:nth-child(even) {
      background-color: #f9f9f9;
    }

    #tbl-news tbody tr:hover {
      background-color: #ddd;
    }

    .searchImageContainer {
      position: absolute;
      border: 1px solid black;
      width: 300px;
      height: 300px;
      margin: 384px 150px;
    }

    .keywordContainer {
      border: 1px solid black;
      width: 50%;
      height: 800px;
    }

    table {
      border: 1px solid black;
      width: 100%;
    }

    table th,
    table tr,
    table td {
      border: 1px solid black;
      padding: 8px;
      text-align: center;
    }

    table thead tr {
      background-color: #f2f2f2;
    }

    table tbody tr:nth-child(even) {
      background-color: #f9f9f9;
    }

    table tbody tr:hover {
      background-color: #ddd;
    }
    
   .imageFile {
	  display: block; /* Remove any inline spacing */
	  width: 100%;
	  max-width: 100%; /* Set the maximum width to 100% of its container */
	  height: -webkit-fill-available; /* Maintain aspect ratio */
	}
  </style>

<section>
	<div class="searchWrapper">
		<div class="searchContainer">
			<form action="">
				<div class="searchBoxContainer">
					<input type="text" name="searchKeyword" placeholder="무엇이 알고싶개?" id="newsName">
					<button type="button" onclick="searchNews()">검색!</button>
				</div>
			</form>
			
			<div class= "tble-newsContainer">
				<table id="tbl-news">
					<thead>
						<tr>
							<th>뉴스 제목</th>
							<th>뉴스 작성자</th>
							<th>뉴스 좋아요 수</th>
							<th>뉴스 조회 수</th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			
			</div>
			
			<div class="searchImageContainer">
				<img src="<%= request.getContextPath() %>/upload/profile/withDraw.jpg" alt="sadImage" class="imageFile"/>
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
		        const { newsTitle, newsLikeCnt } = news;
		        const row = document.createElement("tr");
		        row.innerHTML = `
		          <td>\${i}</td>
		          <td>\${newsTitle}</td>
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
		  $.ajax({
		    url: "<%= request.getContextPath() %>/news/selectNews", 
		    data: { searchKeyword: searchKeywordVal },
		    method: "GET",
		    dataType: "json",
		    success:function(newsList) {
		    	if(newsList.length>0){
		    		
		    		const tbody= document.querySelector("#tbl-news tbody");
		    		tbody.innerHTML= newsList.reduce((html,news)=>{
						const{newsTitle, newsWriter,newsLikeCnt,newsReadCnt} = news;
						
						return html +`
						<tr>
							<td>\${newsTitle}</td>
							<td>\${newsWriter}</td> 
							<td>\${newsLikeCnt}</td>
							<td>\${newsReadCnt}</td>
						</tr>
						`;
					},"");
		    	}else{
		    		const tbody= document.querySelector("#tbl-news tbody");
					tbody.innerHTML=`
						<tr><td colspan='4'>조회된 뉴스가 없습니멍.</td></tr>
					`;
		    	}
		    }
		  });
		}
	
	
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>


