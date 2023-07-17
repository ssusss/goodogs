<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>
<% int totalPage = (int) request.getAttribute("totalPage"); %>

<%@ include file="/WEB-INF/views/common/category.jsp" %>

<section>
	<div class="posts">
		<a class="card" href=""> <!-- a태그 : 전체박스 -->
			<div class="card-inner">
				<figure class="card-thumbnail"> <!-- 기사 썸네일 -->
					<img src="<%= request.getContextPath() %>/images/character/goodogs_face.png">
				</figure>			
				<div class="card-body"><!-- 기사 제목/날짜/카테고리 박스 -->
					<h3 class="card-title">라면먹고싶다</h3> <!-- 기사 제목 -->
					<time class="card-date">2023/07/11</time> <!-- 기사 날짜 -->
					<span class="card-category">학원</span> <!-- 기사 카테고리 -->
				</div>
			</div>
		</a>	
	</div>
	<div id='btn-more-container'>
		<button id="btn-more" value="">더보기(<span id="cpage"></span>/<span id="totalPage"><%= totalPage %></span>)</button>
	</div>
</section>
        
<script>
//날짜 형식 변환
function rearrangeDate(formattedDate) {
	const parts = formattedDate.split('/');
	return `\${parts[2]}/\${parts[0]}/\${parts[1]}`;
}
function formatDate(date) {
	const options = {
		year: 'numeric',
		month: '2-digit',
		day: '2-digit',
		hour12: false
	};
	
	const formatter = new Intl.DateTimeFormat('en-US', options);
	const formattedDate = formatter.format(new Date(date));
		  
	return rearrangeDate(formattedDate);
}


document.querySelector("#btn-more").onclick = () => {
	const cpage = Number(document.querySelector("#cpage").innerHTML); 
	const nextPage = cpage + 1; 
	getPage(nextPage); // 다음페이지 요청
};

window.addEventListener('load', () => {
	getPage(1);	
});

const getPage = (cpage) => {
	
	$.ajax({
		url : "<%= request.getContextPath() %>/goodogs/more",
		data : {cpage},
		success(news) {
			console.log(news);
			
			const container = document.querySelector(".posts");
		
			news.forEach((news) => {
				const {newNo, newsTitle, newsConfirmedDate, newsCategory} = news;
				
				const formattedDate = formatDate(newsConfirmedDate);
				
				container.innerHTML += `
					<a class="card" href="">
						<div class="card-inner">
							<figure class="card-thumbnail">
								<img src="<%= request.getContextPath() %>/upload/thumbnail/\${newNo}">
							</figure>
							<div class="card-body">
								<h3 class="card-title">\${newsTitle}</h3>
								<time class="card-date">\${formattedDate}</time>
								<span class="card-category">\${newsCategory}</span>
							</div>
						</div>
					</a>
				`;
			})
		},
		complete() {
			document.querySelector("#cpage").innerHTML = cpage;
			
			if(cpage === <%= totalPage %>) {
				const btn = document.querySelector("#btn-more");
				
				btn.disabled = true;
				btn.style.cursor = "not-alloewed";
			}
		}
	})
}

</script>    


<%@ include file="/WEB-INF/views/common/footer.jsp" %>