<%@page import="javax.sound.midi.SysexMessage"%>
<%@page import="com.sk.goodogs.news.model.vo.News"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/reporter.css" />
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>

<script>
	bannerContainerLower = document.querySelector(".bannerContainerLower");
	bannerContainerLower.style.display = "none";

	window.onload = () => {
		findAllNewsById();
	}


</script>
<section>
<div class="myPostList">
	<h1>기사 목록</h1>
	<table id ="tbl-news">
		<thead>
			<tr>
				<th>기사번호</th>
				<th>제목</th>
				<th>카테고리</th>
				<th>좋아요</th>
				<th>조회수</th>
				<th>게시일</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
</div>
<br>
<br>
</section>

<script>
// 날짜 형식 변환
function formatDate(date) {
	const options = {
		year: 'numeric',
		month: '2-digit',
		day: '2-digit',
		hour: '2-digit',
		minute: '2-digit',
		second: '2-digit',
		hour12: false
	};
	
	console.log(options);

	const formatter = new Intl.DateTimeFormat('ko-KR', options);
	return formatter.format(new Date(date));
}

const findAllNewsById = () => {
	$.ajax({
		url : "<%= request.getContextPath() %>/reporter/reporterNewsFindAll",
		dataType : "json",
		success(newsList){
			console.log(newsList);
			
			const tbody = document.querySelector(".myPostList table tbody");
			tbody.innerHTML = newsList.reduce((html, news)=> {
				const{newsNo, newsTitle, newsCategory, newsLikeCnt, newsReadCnt, newsConfirmedDate} = news;
				
				const formattedDate = formatDate(newsConfirmedDate);
				
				const newsLink = `<a href="/goodogs/news/newsDetail?no=\${newsNo}">\${newsTitle}</a>`;
				
				return html + `
					<tr>
						<td>\${newsNo}</td>
						<td>\${newsLink}</td>
						<td>\${newsCategory}</td>
						<td>\${newsLikeCnt}</td>
						<td>\${newsReadCnt}</td>
						<td>\${formattedDate}</td>
					</tr>
				`;
			},"");
		}
	});
}

</script>
	
	
	
	
	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>


