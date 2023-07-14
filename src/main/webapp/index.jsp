<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<% int totalPage = (int) request.getAttribute("totalPage"); %>

<!-- 
	@author 이혜령 
	- 카테고리
	- 기사 더보기 페이징
-->

<!-- 카테고리 -->
<section>
	<nav class="category" role="navigation" aria-label="카테고리">
	
		<div class="category-all">
		  <a class="draggable" draggable="false" href="https://example.com/page1">전체 &nbsp;&nbsp;&nbsp;</a>
		</div>
		
		<div class="container">
		  <a class="draggable" draggable="true" href="https://example.com/page2">⚖️정치 &nbsp;</a>
		  <a class="draggable" draggable="true" href="https://example.com/page2">💰경제 &nbsp;</a>
		  <a class="draggable" draggable="true" href="https://example.com/page2">🌐세계 &nbsp;</a>
		  <a class="draggable" draggable="true" href="https://example.com/page3">🤖테크 &nbsp;</a>
		  <a class="draggable" draggable="true" href="https://example.com/page4">🌱환경 &nbsp;</a>
		  <a class="draggable" draggable="true" href="https://example.com/page4">🤸🏻‍♀️스포츠 &nbsp;</a>
		  <a class="draggable" draggable="true" href="https://example.com/page4">👥사회 &nbsp;</a>
		</div>
</section>


<script>

// isDragging : 드래그 진행중인지 여부를 추적하기 위한 플래그 변수
let isDragging = false; // 드래그 중 링크이동 방지

const draggables = document.querySelectorAll(".draggable");
const containers = document.querySelectorAll(".container");

draggables.forEach(draggable => {
  draggable.addEventListener("dragstart", () => {
    isDragging = true;
    // classList : 해당 요소에 적용된 CSS 클래스를 관리
    draggable.classList.add("dragging"); // 드래그 시작하면 dragging 추가
  });

  draggable.addEventListener("dragend", () => {
    isDragging = false;
    draggable.classList.remove("dragging"); // 드래그 끝나면 dragging 제거
  });

  draggable.addEventListener("click", event => {
    if (isDragging) {
      event.preventDefault(); // 드래그 중 링크 이동 방지
      isDragging = false; // 드래그 종료 (안쓰면 한번에 드래그되는 것 처럼 보임)
    }
  });
});


/***
 * dragover : 드래그를 하는 도중 발생하는 이벤트  
 * - 드래그 중인 요소가 컨테이너 위로 이동할 때 발생
 * - 이 이벤트가 발생하면 해당 컨테이너의 드래그 영역에 요소를 이동시킨다.
 */
containers.forEach(container => {
  container.addEventListener("dragover", e => { // container에 dragover 이벤트 추가
    e.preventDefault(); // 기본 드래그앤드롭 동작 방지 (요소를 컨테이너로 이동)
    const afterElement = getDragAfterElement(container, e.clientX); // clientX : 마우스 이벤트 객체에서 제공되는 속성(마우스 이벤트가 발생한 x좌표)
    const draggable = document.querySelector(".dragging"); // 현재 드래그중인 요소
    if (afterElement === undefined) { // 컨테이너 마지막 부분에 드롭되었다면
      container.appendChild(draggable); // 드래그중인 요소를 컨테이너의 마지막에 추가
    } else { // 다른 요소 위에 드롭된 경우
      container.insertBefore(draggable, afterElement); // afterElement 이전에 위치 
    }
  });
});

/***
  * getDragAfterElement(container, x) : 주어진 컨테이너 내에서 드래그중인 요소의 드롭 위치에 가장 가까운 요소를 찾는 함수
  * - 드래그 중인 요소를 컨테이너 내에서 정확한 위치로 이동시키기 위해 사용
  * - 드래그하는 요소가 다른 요소 사이에 들어가게 한다.
  * - container : 드래그 중인 요소가 이동될 컨테이너 요소를 나타냄
  * - x : 드래그 중인 요소의 드롭 위치의 X 좌표
  *
  * reduce() : reduce 메소드는 배열을 순회하며 각 요소에 대해 콜백함수를 실행, 최종적으로 하나의 결과값 반환
  * - closest : 현재까지 가장 가까운 요소를 나타냄. 콜백함수가 처음 실행될 때 closest 매개변수에는 초기값 할당
  * - child : 순회중인 배열의 요소. 콜백함수가 각 요소를 처리할 때 child 매개변수에 해당 요소 할당
  *
  * x : 드롭 위치의 X좌표
  * box.left : child 요소의 왼쪽 가장자리 x좌표
  * box.width : child 요소의 너비
  */
function getDragAfterElement(container, x) {
  const draggableElements = [
    ...container.querySelectorAll(".draggable:not(.dragging)"), // 컨테이너 내 .draggalbe 클래스를 가진 모든 요소 선택 (.dragging 가진 요소 제외)
  ];

  return draggableElements.reduce( 
    (closest, child) => { 
      const box = child.getBoundingClientRect(); // box 객체 생성(요소의 위치, 크기 정보 포함)
   
      // 1. x-box.left : 드롭 위치와 child 요소 가장자리 사이의 거리 계산
      // 2. box.width / 2 : box.width 절반 빼기(child 요소의 중앙 위치와 드롭 위치 사이의 거리 계산)
      const offset = x - box.left - box.width / 2; // offset : 드롭 위치와 child 요소의 중앙 위치 사이의 거리
      // console.log("offset : " + offset);

      if (offset < 0 && offset > closest.offset) { // 가장 가까운 요소를 업데이트 (가장 가까운 요소를 찾을 수 있음)
        // offset : 드롭 위치와 해당 요소의 중앙 위치 사이의 거리
        // element : 해당 요소 자체
        return { offset: offset, element: child }; 
      } else {
        return closest;
      }
    },
    // Number.NEGATiVE_INFINITY : 자바스크립트에서 음의 무한대를 나타내는 특별한 숫자
    // 즉, 어떤 숫자와도 비교했을 때 가장 작은 값을 가지게 된다.
    { offset: Number.NEGATIVE_INFINITY }, // 가장 첫번째 요소와의 비교를 위해 사용되며, 그 이후에는 실제로 계산된 offset 갑소가 비교하여 가장 가까운 요소를 업데이트
  ).element;
}

</script>
</nav>

<section>
	<div id="news-container">
	<a id="card" href="">기사 <!-- a태그 : 전체박스 -->
		<div class="card-inner"> <!-- 박스 안 내용물 -->
			<figure class="card-thumbnail"> <!-- 기사 썸네일 -->
				<img src="" alt>
			</figure>			
			<div class="card-body"><!-- 기사 제목/날짜/카테고리 박스 -->
				<h3 class="card-title">라면먹고싶다</h3> <!-- 기사 제목 -->
				<time class="card-date">2023/07/11</time> <!-- 기사 날짜 -->
				<i class="card-category">학원생활</i> <!-- 기사 카테고리 -->
			</div>
		</div>
	</a>
	</div>
	<div id='btn-more-container'>
		<button id="btn-more" value="">더보기(<span id="cpage"></span>/<span id="totalPage"><%= totalPage %></span>)</button>
	</div>
</section>
        
<script>
document.querySelector("#btn-more").onclick = () => {
	const cpage = Number(document.querySelector("#cpage").innerHTML); 
	const nextPage = cpage + 1; 
	getPage(nextPage); // 다음페이지 요청
};

window.addEventListener('load', () => {
	getPage(1);	
});

const getPage = (cpage) => {
	
	$.ajax({
		url : "<%= request.getContextPath() %>/goodogs/more",
		data : {cpage},
		success(news) {
			console.log(news);
			
			const container = document.querySelector("#news-container");
		
			news.forEach((news) => {
				const {renamedFilename, newsTitle, newsConfirmedDate, newsCategory} = news;
				container.innerHTML += `
					<a href=""></a>
						<div class="card-inner">
							<figure class="card-thumbnail">
								<img src="<%= request.getContextPath() %>/upload/thumbnail/\${renamedFilename}">
							</figure>
							<div class="card-body">
								<h3 class="card-title">\${newsTitle}</h3>
								<time class="card-date">\${newsConfirmedDate}</time>
								<i class="card-category">\${newsCategory}</i>
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
				btn.style.cursor = "not-alloewed";
			}
		}
	})
}

</script>    





<%@ include file="/WEB-INF/views/common/footer.jsp" %>