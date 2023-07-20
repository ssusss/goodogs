<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>

<% int totalPage = (int) request.getAttribute("totalPage"); %>

<%@ include file="/WEB-INF/views/common/category.jsp" %>

<section id="class">
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
   getPage(1);   
});


 // 김준한 테스트용

const getPage = (cpage) => {
   
   $.ajax({
      url : "<%= request.getContextPath() %>/goodogs/more",
      data : {cpage},
      success(news) {
         console.log(news);
         
         const container = document.querySelector(".posts");
      
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
         document.querySelector("#cpage").innerHTML = cpage;
         
         if(cpage === <%= totalPage %>) {
            const btn = document.querySelector("#btn-more");
            
            btn.disabled = true;
            btn.style.cursor = "not-allowed";
         }
      }
   })
}







</script>    


<%@ include file="/WEB-INF/views/common/footer.jsp" %>