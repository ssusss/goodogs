<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script>
	const bannerContainerLower = document.querySelector(".bannerContainerLower");
	bannerContainerLower.style.display = "none";
</script>

<section id="memberList-container">
	<h2>회원관리</h2>
	
	<div id="search-container">
        <label for="searchType">검색타입 :</label> 
        <select id="searchType">
            <option value="memberId" >아이디</option>		
            <option value="nickName" >닉네임</option>
            <option value="memberEnrole" >회원권한</option>
        </select>
        <div id="search-memberId" class="search-type">
            <form action="<%=request.getContextPath()%>/admin/memberFinder">
                <input type="hidden" name="searchType" value="member_id"/>
                <input 
                	type="text" name="searchKeyword"  size="25" placeholder="검색할 아이디를 입력하세요." 
                	value="서버에서 가져올 값"/>
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
		<tbody>
				<tr>
					<td colspan="10">조회 결과가 없습니다.</td>
				</tr>
				
				<tr>
					<td colspan="3">아이디(이메일) 여긴 서버에서 갖고와야 함</td>
					<td colspan="3">닉네임</td>
					<td colspan="3">회원권한</td>
					<td colspan="3">전화번호</td>
					<td colspan="3">성별</td>
					<td colspan="3">가입일</td>
					<td colspan="3">벤</td>
				</tr>
		</tbody>
	</table>
</section>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>