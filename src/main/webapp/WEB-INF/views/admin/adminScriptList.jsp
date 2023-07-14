<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script src=""></script>
<script>
	const bannerContainerLower = document.querySelector(".bannerContainerLower");
	bannerContainerLower.style.display = "none";
	
</script>

<style>
div#check-scriptList 	{width: 100%; margin:0 0 10px 0; padding:3px; background-color: rgba(0, 188, 212, 0.3);}
div#search-container 	{width: 100%; margin:0 0 10px 0; padding:3px; background-color: rgba(0, 188, 212, 0.3);}
div#search-memberId 	{display: inline-block;}
div#search-nickName		{display: none}
div#search-memberRole	{display: none}

</style>
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>


<section id="adminScriptList-container">
	<h2>원고관리</h2>
	
	<div id="check-scriptList" class="check-type">
             <form action="javascript:void(0)" onsubmit="return checkList(this)">
                <input type="hidden" name="searchType" value="member_role"/>
                <input type="radio" name="checkedScript" value=1 > 미확인
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
            <option value="category" >카테고리</option>       
        </select>
        
        
        <div id="search-title" class="search-type">
            <form action="">
                <input type="hidden" name="searchType" value="script_title"/>
                <input 
                	type="text" name="searchKeyword"  size="25" placeholder="기사의 제목을 입력하세요." 
                	value=""/>
                <button type="submit">검색</button>			
            </form>	
        </div>
        
        <div id="search-writer" class="search-type">
            <form action="">
                <input type="hidden" name="searchType" value="script_writer"/>
                <input 
                	type="text" name="searchKeyword"  size="25" placeholder="검색할 아이디를 입력하세요." 
                	value=""/>
                <button type="submit">검색</button>			
            </form>	
        </div>
        
        <div id="search-category" class="search-type">
            <form action="">
                <input type="hidden" name="searchType" value="script_category"/>
                <input 
                	type="text" name="searchKeyword" size="25" placeholder="기사의 카테고리를 입력하세요."
                	value=""/>
                <button type="submit">검색</button>			
            </form>	
        </div>
        
        <div id="search-date" class="search-type">
            <form action="">
                <input type="hidden" name="searchType" value="script_write_date"/>
                <input 
                	type="date" name="searchKeyword" size="25" placeholder="날짜를 입력하세요."
                	value=""/>
                <button type="submit">검색</button>			
            </form>	
        </div> 
       
    </div>
	
	<table id="tbl-script">
		<thead>
			<tr>
				<th>기자(이메일)</th>
				<th>제목</th>
				<th>카테고리</th>
				<th>승인여부</th>
			</tr>
		</thead>
		<tbody>
				<tr>
					<td colspan="10">조회 결과가 없습니다.</td>
				</tr>
				
				<tr>
					<td colspan="3">기자(이메일)(에이태그)</td>
					<td colspan="3">제목(에이테그)</td>
					<td colspan="3">카테고리</td>
					<td colspan="3">승인여부</td>
				</tr>
		</tbody>
	</table>
</section>

<script>

document.querySelector("select#searchType").onchange = (e) => {
	console.log(e.target.value);
	document.querySelectorAll(".search-type").forEach((elem) => {
		elem.style.display = "none";
	});
	
	document.querySelector(`#search-\${e.target.value}`).style.display = "inline-block";
	
};

</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>