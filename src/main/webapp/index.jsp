<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<nav class="category" role="navigation" aria-label="카테고리">
		<div class="categoryInner">
			<a class="category-link is-active" href="/">카테고리 1</a>
			<a class="category-link is-active" href="/">카테고리 2</a>
			<a class="category-link is-active" href="/">카테고리 3</a>
			<a class="category-link is-active" href="/">카테고리 4</a>
			<a class="category-link is-active" href="/">카테고리 5</a>
			<a class="category-link is-active" href="/">카테고리 6</a>
		</div>
    </nav>


	<div class="posts">
		<a class="card" href="">기사 <!-- a태그 : 전체박스 -->
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
		<a class="card" href="">기사</a>
		<a class="card" href="">기사</a>
		<a class="card" href="">기사</a>
		<a class="card" href="">기사</a>
		<a class="card" href="">기사</a>
		<a class="card" href="">기사</a>
		<a class="card" href="">기사</a>
		<a class="card" href="">기사</a>
		<a class="card" href="">기사</a>
		<a class="card" href="">기사</a>
		<a class="card" href="">기사</a>
		<a class="card" href="">기사</a>
		<a class="card" href="">기사</a>
		<a class="card" href="">기사</a>
		<a class="card" href="">기사</a>
	</div>
	<nav class="postsPagination">
		<button type="button">더보기</button>
	</nav>
    
<%@ include file="/WEB-INF/views/common/footer.jsp" %>