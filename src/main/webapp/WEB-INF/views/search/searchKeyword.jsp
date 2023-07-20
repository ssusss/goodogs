<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<% int totalPage = (int) request.getAttribute("totalPage"); %>
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>
<script>
bannerContainerLower = document.querySelector(".bannerContainerLower");
bannerContainerLower.style.display = "none";
</script>

<style>
section .posts .card {
	border-width: 1px 1px 1px 0;
}
</style>

<section>
	<h1 style="font-size: 36px" class="keywordBox"></h1>
	<div class="posts">
		
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
	const currentURL = decodeURIComponent(window.location.href);
	  console.log(currentURL.split("=")[1]);
	  const keyword = currentURL.split("=")[1];
	  
	getPage(1,keyword);	
	  
});

const getPage = (cpage,keyword) => {
	
	$.ajax({
		url : "<%= request.getContextPath() %>/more/keyword",
		data : {cpage,keyword},
		success(news) {
			console.log(news);
			const keywordBox = document.querySelector(".keywordBox");
			const container = document.querySelector(".posts");
			keywordBox.innerHTML += `'\${keyword}' 의 검색결과입니멍`;
		    if(news == ''){
		    	console.log('test');
				const btnMoreContainer = document.querySelector("#btn-more-container");
		    	btnMoreContainer.remove();
		    	keywordBox.innerHTML += `
		    		<h1>검색결과가 없습니멍!!!!!</h1>
		    	`;
		    }
			
			news.forEach((newsAndImage) => {
				const {newsNo, newsTitle, newsConfirmedDate, newsCategory, renamedFilename} = newsAndImage;
				
				const formattedDate = formatDate(newsConfirmedDate);
				container.innerHTML += `
					<a class="card" href="/goodogs/news/newsDetail?no=\${newsNo}">
						<div class="card-inner">
							<figure class="card-thumbnail">
								<img src="<%= request.getContextPath() %>/upload/newsImage/\${renamedFilename}">
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
			
			
			if(cpage === <%= totalPage %>) {
			document.querySelector("#cpage").innerHTML = cpage;
				const btn = document.querySelector("#btn-more");
				
				btn.disabled = true;
				btn.style.cursor = "not-alloewed";
			}
		}
	})
}

</script>    



<%@ include file="/WEB-INF/views/common/footer.jsp" %>