<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css" />
<script>
	const bannerContainerLower = document.querySelector(".bannerContainerLower");
	bannerContainerLower.style.display = "none";
	
	window.onload = () => {
		findScriptState(1);
	}
</script>

<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>
<script>
	
</script>

<section id="adminScriptList-container">
	<h1>원고관리</h1>
	
	<div id="check-scriptList" class="check-type">
             <form id="scriptType">
                <input type="hidden" name="scriptType" value="script_state"/>
                <input type="radio" name="checkedScript" value=1 checked> 미확인
                <input type="radio" name="checkedScript" value=2> 승인
                <input type="radio" name="checkedScript" value=3> 반려
            </form>
     </div>
	
	
	<div id="search-container">
        <label for="searchType">검색타입 :</label> 
        <select id="searchType">
            <option value="title" >제목</option>		
            <option value="writer" >작성자</option>		
            <option value="category" >카테고리</option>           
        </select>
        
        
        <div id="search-title" class="search-type">
             <form action="javascript:void(0)" onsubmit="return serchScript(this)">
                <input type="hidden" name="searchType" value="script_title"/>
                <input 
                	type="text" name="searchKeyword"  size="25" placeholder="기사의 제목을 입력하세요." 
                	value=""/>
                <button type="submit">검색</button>			
            </form>	
        </div>
        
        <div id="search-writer" class="search-type">
             <form action="javascript:void(0)" onsubmit="return serchScript(this)">
                <input type="hidden" name="searchType" value="script_writer"/>
                <input 
                	type="text" name="searchKeyword"  size="25" placeholder="검색할 아이디를 입력하세요." 
                	value=""/>
                <button type="submit">검색</button>			
            </form>	
        </div>
        
        <div id="search-category" class="search-type">
            <form action="javascript:void(0)" onsubmit="return serchScript(this)">
                <input type="hidden" name="searchType" value="script_category"/>
                <input 
                	type="text" name="searchKeyword" size="25" placeholder="기사의 카테고리를 입력하세요."
                	value=""/>
                <button type="submit">검색</button>			
            </form>	
        </div>
        
        <div id="search-date" class="search-date">
             <form action="javascript:void(0)" onsubmit="return serchScriptdate(this)">
                <input 
                	type="date" name="searchKeyword" size="25" placeholder="날짜를 입력하세요."
                	value=""/>
                <button type="submit">검색</button>			
            </form>	
        </div> 
       
    </div>
	<div class="tbl-scriptContainer">
		<table id="tbl-script">
			<thead>
				<tr>
					<th colspan="2">기자(이메일)</th>
					<th colspan="3">제목</th>
					<th colspan="1">카테고리</th>
					<th colspan="1">날짜</th>
					<th colspan="1">승인여부</th>
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
//날짜 형식 변환
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



function serchScript(frm){
	
	const searchTypeVal=frm.searchType.value;
	const searchKeywordVal=frm.searchKeyword.value;
	const scriptState =document.querySelector('input[name="checkedScript"]:checked').value;
	
	console.log(searchTypeVal);
	console.log(searchKeywordVal);
	console.log(scriptState);
	
	$.ajax({
		url : "<%= request.getContextPath() %>/admin/member/serchScript",
		data : {searchTypeVal,searchKeywordVal,scriptState},	
		method : "GET",
		dataType : "json",
		success(scripts) {
		console.log(scripts);
		
		const tbody= document.querySelector("#tbl-script tbody");
		if(scripts.length>0){
			tbody.innerHTML=scripts.reduce((html,script)=>{
				const{scriptCategory,scriptContent,scriptNo,scriptState,
					scriptTag,scriptTitle,scriptWriteDate,scriptWriter}=script;
				
					let scriptStateText = "";
					let link="";
					
					
			          switch (scriptState) {
			            case 1:
				              scriptStateText = "미확인";
				              link=`<a href="<%= request.getContextPath() %>/admin/scriptDetail?no=\${scriptNo}">\${scriptTitle}</a>`;
			             	 break;
			            case 2:
				              scriptStateText = "승인";
				              link=`<a href="<%= request.getContextPath() %>/admin/scriptDetail?no=\${scriptNo}">\${scriptTitle}</a>`;
				              break;
			            case 3:
				              scriptStateText = "반려";
				              link=`<a href="<%= request.getContextPath() %>/admin/scriptDetail?no=\${scriptNo}">\${scriptTitle}</a>`;
				              break;
			            default:
			              scriptStateText = "상태이상";
			              break;
					};
				
					
				const formattedDate = formatDate(scriptWriteDate);
					
				return html +`
				<tr>
					<td colspan="2">\${scriptWriter}</td>
					<td colspan="3">\${link}</td>
					<td colspan="1">\${scriptCategory}</td>
					<td colspan="1">\${formattedDate}</td>
					<td colspan="1">\${scriptStateText}</td>
				</tr>
				`;
			},"");
		}
		else{
			tbody.innerHTML=`
				<tr>
					<td colspan="10">조회 결과가 없습니다.</td>
				</tr>
			`;
		}
		
	}
	});
	
	
	return false;
};

document.querySelector("form#scriptType").onchange = (e) => {
	
	const checkedScript= e.target.value;
	console.log(checkedScript);
	
	findScriptState(checkedScript);
	searchKeywordReset();
	
};

function searchKeywordReset(){
	document.querySelectorAll(`input[name="searchKeyword"]`).forEach((elem)=>{
		elem.value="";
	});
}


document.querySelector("select#searchType").onchange = (e) => {
	console.log(e.target.value);
	searchKeywordReset();
	document.querySelectorAll(".search-type").forEach((elem) => {
		elem.style.display = "none";
	});
	
	document.querySelector(`#search-\${e.target.value}`).style.display = "inline-block";
};




const findScriptState=(scriptState)=>{
	$.ajax({
		url : "<%= request.getContextPath() %>/admin/member/findScriptState",
		data:{scriptState},
		method :"GET",
		dataType :"json",
		success(scripts){
			console.log(scripts);
	
			const tbody= document.querySelector("#tbl-script tbody");
			if(scripts.length>0){
				tbody.innerHTML=scripts.reduce((html,script)=>{
					const{scriptCategory,scriptContent,scriptNo,scriptState,
						scriptTag,scriptTitle,scriptWriteDate,scriptWriter}=script;
						
					
						let scriptStateText = "";
						let link="";
						
						
						
				          switch (scriptState) {
				            case 1:
					              scriptStateText = "미확인";
					              link=`<a href="<%= request.getContextPath() %>/admin/scriptDetail?no=\${scriptNo}">\${scriptTitle}</a>`;
				             	 break;
				            case 2:
					              scriptStateText = "승인";
					              link=`<a href="<%= request.getContextPath() %>/admin/scriptDetail?no=\${scriptNo}">\${scriptTitle}</a>`;
					              break;
				            case 3:
					              scriptStateText = "반려";
					              link=`<a href="<%= request.getContextPath() %>/admin/script/rejectedDetail?no=\${scriptNo}">\${scriptTitle}</a>`;
					              break;
				            default:
				              scriptStateText = "상태이상";
				              break;
						};
					const formattedDate = formatDate(scriptWriteDate);
		
						
					
					return html +`
					<tr>
						<td colspan="2">\${scriptWriter}</td>
						<td colspan="3">\${link}</td>
						<td colspan="1">\${scriptCategory}</td>
						<td colspan="1">\${formattedDate}</td>
						<td colspan="1">\${scriptStateText}</td>
					</tr>
					`;
				},"");
			}
			else{
				tbody.innerHTML=`
					<tr>
						<td colspan="10">조회 결과가 없습니다.</td>
					</tr>
				`;
			}
			
		}
	});

};

</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>