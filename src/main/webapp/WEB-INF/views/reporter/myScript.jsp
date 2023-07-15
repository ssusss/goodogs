<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>
<script>
	bannerContainerLower = document.querySelector(".bannerContainerLower");
	bannerContainerLower.style.display = "none";
	
	window.onload = () => {
		findAllScriptById();
	}
</script>
<style>
h1, h3{text-align:center;}
.script-tbl {
  border-collapse: collapse;
  margin:auto;
}

.script-tbl th,
.script-tbl td {
  border: 1px solid black;
  padding: 3px;
  text-align: center;
}

.script-tbl th {
  background-color: #f2f2f2;
}
</style>
<section>
<div class="myScriptList">
	<h1>원고 기사 목록</h1>
	<h3>반려된 원고</h3>
	<table id="tbl-script1" class="script-tbl">
		<thead>
			<tr>
				<th>기사번호</th>
				<th>제목</th>
				<th>카테고리</th>
				<th>제출일자</th>
				<th>상태</th>
			</tr>
		</thead>
		<tbody id="scriptBodyList1">
		</tbody>
	</table>
	<h3>임시저장 원고</h3>
	<table id="tbl-script2" class="script-tbl">
		<thead>
			<tr>
				<th>기사번호</th>
				<th>제목</th>
				<th>카테고리</th>
				<th>최종수정일</th>
				<th colspan="3">상태</th>
			</tr>
		</thead>
		<tbody id="scriptBodyList2">
		</tbody>
	</table>

	<h3>제출한 원고</h3>
	<table id="tbl-script3" class="script-tbl">
		<thead>
			<tr>
				<th>기사번호</th>
				<th>제목</th>
				<th>카테고리</th>
				<th>제출일자</th>
				<th>상태</th>
			</tr>
		</thead>
		<tbody id="scriptBodyList3">
		</tbody>
	</table>
</div>
</section>
<script>

//삭제 버튼에 대한 이벤트 리스너 추가
document.addEventListener('click', (e) => {
  if (e.target.matches('.delete')) {
    const scriptNo = e.target.closest('tr').querySelector('td:first-child').textContent;
    
    $.ajax({
    	url : "<%= request.getContextPath() %>/reporter/scriptDelete",
    	data : {scriptNo},
    	method : "POST",
    	dataType : "json",
    	success(scriptDelete){
    		console.log(scriptDelete);
    		alert(scriptDelete.message);
    	},
    	complete() {
    		location.reload();
    	}
    });
  }
});

// 이어쓰기 버튼에 대한 이벤트 리스너 추가
document.addEventListener('click',(e)=>{
	if(e.target.matches('.scriptUpdate')){
		const scriptNo = e.target.closest('tr').querySelector('td:first-child').textContent;
		
		// 동기적으로 서블릿으로 이동하는 코드
	    window.location.href = `<%= request.getContextPath()%>/reporter/scriptUpdate?scriptNo=\${scriptNo}`;
	}
});

			//=========== 아이디로 원고 전부 찾기 ============
			
const findAllScriptById = () => {
  $.ajax({
    url: "<%= request.getContextPath() %>/reporter/reporterFindAllScript",
    dataType: "json",
    success(Scripts) {
      const tbody1 = document.getElementById("scriptBodyList1");
      const tbody2 = document.getElementById("scriptBodyList2");
      const tbody3 = document.getElementById("scriptBodyList3");

      Scripts.forEach(newsScript => {
        const { scriptNo, scriptTitle, scriptCategory, scriptWriteDate, scriptState } = newsScript;
        let scriptStateText = "";

        if (scriptState === 3) {
          tbody1.innerHTML += `
            <tr>
              <td>\${scriptNo}</td>
              <td>\${scriptTitle}</td>
              <td>\${scriptCategory}</td>
              <td>\${scriptWriteDate}</td>
              <td>반려됨</td>
            </tr>
          `;
        } else if (scriptState === 0) {
          tbody2.innerHTML += `
            <tr>
              <td>\${scriptNo}</td>
              <td>\${scriptTitle}</td>
              <td>\${scriptCategory}</td>
              <td>\${scriptWriteDate}</td>
              <td>작성중 <button class="scriptUpdate">이어쓰기</button> <button class="delete">삭제</button></td>
            </tr>
          `;
        } else if (scriptState === 1) {
          scriptStateText = "제출완료(미승인)";
          tbody3.innerHTML += `
            <tr>
              <td>\${scriptNo}</td>
              <td>\${scriptTitle}</td>
              <td>\${scriptCategory}</td>
              <td>\${scriptWriteDate}</td>
              <td>\${scriptStateText}</td>
            </tr>
          `;
        } else if (scriptState === 2) {
          scriptStateText = "제출완료(게시중)";
          tbody3.innerHTML += `
            <tr>
              <td>\${scriptNo}</td>
              <td>\${scriptTitle}</td>
              <td>\${scriptCategory}</td>
              <td>\${scriptWriteDate}</td>
              <td>\${scriptStateText}</td>
            </tr>
          `;
        }
      });
    },
  });
};

</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>