<%@page import="java.util.Date"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.sk.goodogs.news.model.vo.NewsScript"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	NewsScript script=(NewsScript)request.getAttribute("script");
%>
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
	
<section id="adminScriptDetail-container">

	
		
		<h5 ><%=script.getScriptCategory() %></h5>
		<h2 ><%=script.getScriptTitle() %></h2>

		<h2>사진 준비중</h2>
	
		
		<p>
		<%=script.getScriptContent() %>
		</p>
		
		<p>
			<%=script.getScriptTag() %>
		</p>
		<p><%=script.getScriptTag() %> </p>
		<p><%=script.getScriptNo() %> </p>

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
					window.location.href = "<%=request.getContextPath() %>/admin/adminScriptList";
					alarm();
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
					window.location.href = "<%=request.getContextPath() %>/admin/adminScriptList";
					alarm();
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
	
	
	function alarm(){
		function alarm(){
			
			let scriptStateText = "";
	         switch (<%=script.getScriptState() %>) {
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
				no:<%=script.getScriptNo() %>,
				comemt:"원고가 `\${scriptStateText}`처리되었습니다 확인하세요-관리자",
				receiver:"<%=script.getScriptWriter().replace("@", "\\@") %>",
				hasRead:0,
				createdAt :Date.now()
			}
		};
		ws.send(JSON.stringify(payload));
	};

</script>	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>