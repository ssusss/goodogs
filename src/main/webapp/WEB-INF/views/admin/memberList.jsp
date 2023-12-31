<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css" />
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>

<script>
	const bannerContainerLower = document.querySelector(".bannerContainerLower");
	bannerContainerLower.style.display = "none";
	window.onload = () => {
		
		let cnt=0;
		document.querySelectorAll(".search-type").forEach((elem) => {
			if(elem.style.display==="none")
				cnt++;
		});
		if(cnt===3){
		document.querySelector("div #search-memberId").style.display="inline-block";
		
		}
		
		findAllMember();
		
	}
	
</script>

<section>
	<h1>회원관리</h1>
	
	<div id="search-container">
        <label for="searchType">검색타입 :</label> 
        <select id="searchType">
            <option value="memberId"  selected>아이디</option>		
            <option value="nickName" >닉네임</option>
            <option value="memberRole" >회원권한</option>
        </select>
        
        
        
        <div id="search-memberId" class="search-type">
            <form action="javascript:void(0)" onsubmit="return serchMember(this)">
               <input type="hidden" name="searchType" value="member_id"/>
                <input 
                	type="text" name="searchKeyword"  size="25" placeholder="검색할 아이디를 입력하세요." 
                	value=""/>
                <button type="submit">검색</button>			
            </form>	
        </div>
        <div id="search-nickName" class="search-type">
              <form action="javascript:void(0)" onsubmit="return serchMember(this)">
                <input type="hidden" name="searchType" value="nickname"/>
                <input 
                	type="text" name="searchKeyword" size="25" placeholder="검색할 이름을 입력하세요."
                	value=""/>
                <button type="submit">검색</button>			
            </form>	
        </div>
        <div id="search-memberRole" class="search-type">
             <form action="javascript:void(0)" onsubmit="return serchMember(this)">
                <input type="hidden" name="searchType" value="member_role"/>
                <input type="radio" name="searchKeyword" value="A" > 관리자
                <input type="radio" name="searchKeyword" value="R"> 기자
                <input type="radio" name="searchKeyword" value="M"> 회원
                <button type="submit">검색</button>
            </form>
        </div>
    </div>
	<div class="tbl-memberContainer">
		<table id="tbl-member">
			<thead>
				<tr>
					<th>아이디(이메일)</th>
					<th>닉네임</th>
					<th>회원권한</th>
					<th>전화번호</th>
					<th>성별</th>	
					<th>가입일</th>
					<th>벤</th>
				</tr>
			</thead>
			<tbody></tbody>
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


document.addEventListener('change',(e)=>{
	if(e.target.matches("select.member-role")){
		if(confirm("회원권한을 정말 수정하시겠습니까?")) {	
			
			const memberRoleVal = e.target.value;
			const memberIdVal = e.target.dataset.memberId;
			
			$.ajax({
				url : "<%= request.getContextPath() %>/admin/member/memberRoleUpdate",
				data : {memberRoleVal,memberIdVal},	
				method : "POST",
				dataType : "json",
				success(updateRole) {
					console.log(updateRole)
					alert(updateRole.message);
				}
			});
			
		}else{
			e.target.querySelector("option[selected]").selected = true;
		}

	}
});


function serchMember(frm){
	
	const searchTypeVal=frm.searchType.value;
	const searchKeywordVal=frm.searchKeyword.value;
	
	console.log(searchTypeVal);
	console.log(searchKeywordVal);
	
	
	$.ajax({
		url : "<%= request.getContextPath() %>/admin/member/findMember",
		data : {searchTypeVal,searchKeywordVal},	
		method : "GET",
		dataType : "json",
		success(selectedMembers) {
		console.log(selectedMembers);

			
		if(selectedMembers.length>0){
			
				const tbody= document.querySelector("#tbl-member tbody");
				tbody.innerHTML= selectedMembers.reduce((html,member)=>{
					const{memberId,nickname,memberRole,phone,gender,enrollDate,isBanned}=member;
					
					const formattedDate = formatDate(enrollDate);
					
					return html +`
					<tr>
						<td>\${memberId}</td>
						<td>\${nickname}</td> 
						<td>
							<select class="member-role" data-member-id=\${memberId}>
								<option value="M" \${memberRole === "M" ? "selected" : ""}>회원</option>
								<option value="R" \${memberRole === "R" ? "selected" : ""}>기자</option>
								<option value="A" \${memberRole === "A" ? "selected" : ""}>관리자</option>
							</select>
						</td>
						<td>\${phone}</td>
						<td>\${gender}</td>
						<td>\${formattedDate}</td>
						<td>\${isBanned}</td>
					</tr>
					`;
				},"");
			}else{
				const tbody= document.querySelector("#tbl-member tbody");
				tbody.innerHTML=`
					<tr><td colspan='7'>회원이 존재하지 않습니다.</td></tr>
				`;
			}
		
		}
		
	});
	return false;
};

document.querySelector("select#searchType").onchange = (e) => {
	console.log(e.target.value);
	document.querySelectorAll(".search-type").forEach((elem) => {
		elem.style.display = "none";
	});
	
	document.querySelector(`#search-\${e.target.value}`).style.display = "inline-block";
	
};
	

	const findAllMember= ()=>{
		$.ajax({
			url : "<%= request.getContextPath() %>/admin/member/findAll",
			method :"GET",
			dataType :"json",
			success(members){
				console.log(members);

				const tbody= document.querySelector("#tbl-member tbody");
				tbody.innerHTML= members.reduce((html,member)=>{
					const{memberId,nickname,memberRole,phone,gender,enrollDate,isBanned}=member;
					const formattedDate = formatDate(enrollDate);
					return html +`
						<tr>
							<td>\${memberId}</td>
							<td>\${nickname}</td>
							<td>
							<select class="member-role" data-member-id=\${memberId}>
								<option value="M" \${memberRole === "M" ? "selected" : ""}>회원</option>
								<option value="R" \${memberRole === "R" ? "selected" : ""}>기자</option>
								<option value="A" \${memberRole === "A" ? "selected" : ""}>관리자</option>
							</select>
							</td>
							<td>\${phone}</td>
							<td>\${gender}</td>
							<td>\${formattedDate}</td>
							<td>\${isBanned}</td>
						</tr>
					`;
				},"");
			}
		});
	};
		


	
	

</script>




<%@ include file="/WEB-INF/views/common/footer.jsp" %>