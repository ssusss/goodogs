<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>
<script>
	const bannerContainerLower = document.querySelector(".bannerContainerLower");
	bannerContainerLower.style.display = "none";
	window.onload = () => {
		findAllMember();
	};
</script>

<section id="memberList-container">
	<h2>회원관리</h2>
	
	<div id="search-container">
        <label for="searchType">검색타입 :</label> 
        <select id="searchType">
            <option value="member_id" >아이디</option>		
            <option value="nickname" >닉네임</option>
            <option value="member_role" >회원권한</option>
        </select>
        <select id="banckeck">
            <option value="is_banned" >정상회원</option>		
            <option value="nickName" >닉네임</option>
            <option value="memberEnrole" >회원권한</option>
        </select>
        <div id="search-memberId" class="search-type">
            <form action="<%=request.getContextPath()%>/admin/memberFinder">
                <input type="hidden" name="searchType" value="member_id"/>
                <input 
                	type="text" name="searchKeyword"  size="25" placeholder="검색할 아이디를 입력하세요." 
                	value="사용자 입력값"/>
                <button type="submit">검색</button>			
            </form>	
        </div>
        <div id="search-name" class="search-type">
            <form action="">
                <input type="hidden" name="searchType" value="name"/>
                <input 
                	type="text" name="searchKeyword" size="25" placeholder="검색할 이름을 입력하세요."
                	value="notalready"/>
                <button type="submit">검색</button>			
            </form>	
        </div>
        <div id="search-enrole" class="search-type">
            <form action="<%=request.getContextPath()%>/admin/memberFinder">
                <input type="hidden" name="searchType" value="enrole"/>
                <input type="radio" name="searchKeyword" value="A" > 관리자
                <input type="radio" name="searchKeyword" value="R"> 기자
                <input type="radio" name="searchKeyword" value="U"> 회원
                <button type="submit">검색</button>
            </form>
        </div>
    </div>
	
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
</section>

<script>

	const findAllMember= ()=>{
		$.ajax({
			url : "<%= request.getContextPath() %>/admin/member/findAll",
			method :"GET",
			dataType :"json",
			success(members){
				console.log(members);

				const tbody= document.querySelector("#tbl-member");
				tbody.innerHTML= members.reduce((html,member)=>{
					const{MemberId,nickName,enrole}=member;
					return html +`
						<tr>
							<td>\${MemberId}</td>
							<td>\${nickName}</td>
							<td>\${enrole}</td>
						</tr>
					`;
				},"");
			}
		});
		
		
		const findSelectedMember= ()=>{
			$.ajax({
				url:"",
				method :"GET",
				daata :JSON.stringify({ searchType:\${searchType} , age: 25 }), 
				dataType :"json",
			});
			
		}
	}

</script>



<%@ include file="/WEB-INF/views/common/footer.jsp" %>