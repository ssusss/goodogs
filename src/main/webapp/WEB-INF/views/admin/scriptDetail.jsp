<%@page import="com.sk.goodogs.news.model.vo.NewsImage"%>
<%@page import="com.sk.goodogs.news.model.vo.NewsAndImage"%>
<%@page import="java.util.Date"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.sk.goodogs.news.model.vo.NewsScript"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	NewsScript script = (NewsScript)request.getAttribute("script");

	NewsImage newsImage = (NewsImage)request.getAttribute("newsImage");


	String _category = "";
    
	switch (script.getScriptCategory()) {
		case "정치" : _category = "politics"; break;
		case "경제" : _category = "economy"; break;
		case "세계" : _category = "global"; break;
		case "테크" : _category = "tech"; break;
		case "환경" : _category = "environment"; break;
		case "스포츠" : _category = "sports"; break;
		case "사회" : _category = "society"; break;
	}
	
	String tagArr[] = script.getScriptTitle().split(",");
%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/news.css" />
<script>
	const bannerContainerLower = document.querySelector(".bannerContainerLower");
	bannerContainerLower.style.display = "none";
</script>
<style>
	.adminComent {
		display: none;
	}

</style>
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>
	
<div id="newHeader">
	<h4 id="news-category" name="news-category" style="color: #008000">
		<a href="">
			<%=script.getScriptCategory()%>
		</a>
	</h4> <!--  카테고리  -->

	<h1 id="news-title" name="news-title" ><%=script.getScriptTitle() %></h1><!--  제목  -->
 	
 	<h4 id="news-confirmed-date" name="news-confirmed-date" ><%= script.getScriptWriteDate().toString().split(" ")[0] %></h4>
</div>  

<section id="news-container">
<<<<<<< HEAD


<div id="img-container">
    <% if (newsImage != null) { %>
        <img id="news-img" name="news-img" style="width: 600px;" src="<%= request.getContextPath() %>/upload/newsImage/<%= newsImage.getOriginalFilename() %>"><!--  이미지  -->
    <% } %>
</div>
				 
=======
	<div id="img-container">
		<img id="news-img" name="news-img" style="width: 600px;" src="<%= request.getContextPath() %>/upload/newsImage/<%=image.getRenamedFilename()%>"><!--  이미지  -->
	</div>
							 
>>>>>>> branch 'master' of https://github.com/ssusss/goodogs
	<div id="news-content" name="news-content"><%=script.getScriptContent()%></div><!--  내용  -->
	 
	<br/><br/><br/>
	<div id="news-tag-container">
		<div class="news-tag">
			<a href="<%= request.getContextPath() %>/tag/<%= _category %>">#<%= tagArr[0] %></a>
		</div>
		<% for (int i = 1; i < tagArr.length; i++) { %>
		<div class="news-tag">
			<a href="<%=request.getContextPath()%>/search/news/?keyword=<%= tagArr[i] %>">#<%= tagArr[i] %></a>
		</div>
		<% } %>
	</div>


	<%if(script.getScriptState()==1){ %>
		
		<textarea name="reason" class="adminComent"  cols="40" rows="10" >
		</textarea>
		<br/>
		<button name="approval">승인</button>
		<button name="rejectInput">반려사유적기</button>
		<button name="reject" class="adminComent">반려</button>
		
	<%} %>
		
	

</section>
	

	
<script>
	document.querySelector('button[name="reject"]').addEventListener("click",()=>{

		if(confirm("원고를 반려하시겠습니까?")){

			const no=<%=script.getScriptNo() %>;
			const rejectReason=document.querySelector('textarea[name="reason"]').value;

			console.log(rejectReason);

			$.ajax({
				url :"<%= request.getContextPath() %>/admin/script/reject",
				method:"POST",
				dataType:"json",
				data: {no,rejectReason},
				success(responseData) {
					console.log(responseData);
					alert(responseData.message);
					alarm(3);
					
				},

				
			});
		}

	});

	

	document.querySelector('button[name="approval"]').addEventListener("click",()=>{

		if(confirm("원고를 승인하시겠습니까?")){
			
			const script= <%= new Gson().toJson(script)%>;
		
			console.log(script);	
			
			
			$.ajax({
				url :"<%= request.getContextPath() %>/admin/script/approval",
				method:"POST",
				dataType:"json",
				data: JSON.stringify(script),
				contentType: "application/json",
				success(responseData) {
					console.log(responseData);
					
					alert(responseData.message);
					alarm(2);
				},

				
				
			});

		}

	});

	

	document.querySelector('button[name="rejectInput"]').addEventListener("click",(e)=>{
		const comentClass =document.querySelectorAll(".adminComent");
		comentClass.forEach((e)=>{
				e.style.display="inline";
		});
		e.target.style.display="none";
	});
	
	
	
		function alarm(state){
			console.log("알람호출됨");
				let scriptStateText = "";
		         switch (state) {
		            case 1:
		              scriptStateText = "미확인";
		              break;
		            case 2:
			              scriptStateText = "승인";
			              break;
		            case 3:
			              scriptStateText = "반려";
			              break;
		            default:
		              scriptStateText = "상태이상";
		              break;
				};
				
				const payload={
					messageType : "ALARM_MESSAGE",
					no:"<%=script.getScriptNo() %>",
					comemt:`원고가 \${scriptStateText}처리되었습니다 확인하세요-관리자`,
					receiver:"<%=script.getScriptWriter().replace("@", "\\@") %>",
					hasRead:"0",
					createdAt :Date.now()
				}
			ws.send(JSON.stringify(payload));
			window.location.href = "<%=request.getContextPath() %>/admin/adminScriptList";
		};


</script>	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>