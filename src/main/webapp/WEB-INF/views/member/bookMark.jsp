<%@page import="com.sk.goodogs.bookmark.model.vo.Bookmark"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/member.css" />

<%
    List<Bookmark> bookmarks = (List<Bookmark>) request.getAttribute("bookmarks");
%>
<!--
    author 이혜령
    - 북마크 목록 페이지
-->
<script>
    bannerContainerLower = document.querySelector(".bannerContainerLower");
    bannerContainerLower.style.display = "none";
    bannerContainerUpper = document.querySelector(".bannerContainerUpper");
    bannerContainerUpper.style.display = "none";
</script>

<section id="bookMark-container">
    <br>
    <h1>어떤 부분이 인상깊었개</h1>

    <% if(bookmarks.isEmpty() || bookmarks == null) { %>
        <h1>아직 북마크 한 기사가 없개!</h1>
    <% } else { %>
        <h1><%= bookmarks.size() %>개의 북마크를 눌렀개!</h1>
    <% } %>
</section>

<section class="bookmark-container">
    <div class="bookmark">
        <% if (!bookmarks.isEmpty() && bookmarks != null) { %>
            <form id="deleteForm" method="POST" action="<%= request.getContextPath() %>/bookmark/deleteBookmark">
				<table class="tbl-bookmark">
				    <thead>
				        <tr>
				            <th></th>
				            <th>뉴스번호</th>
				            <th>뉴스제목</th>
				            <th>북마크내용</th>
				            <th>시간</th>
				            <th></th>
				        </tr>
				    </thead>
				    <tbody>
				        <% for (Bookmark bookmark : bookmarks) { %>
				            <tr>
				                <td>
				                    <input type="checkbox" name="bookmark" value="<%= bookmark.getMemberId() %>,<%= bookmark.getNewsNo() %>">
				                </td>
				                <td><%= bookmark.getNewsNo() %></td>
				                <td>
				                    <!-- 뉴스 제목을 링크로 감싸기 -->
				                    <a href="<%= request.getContextPath() %>/news/newsDetail?no=<%= bookmark.getNewsNo() %>">
				                        <%= bookmark.getNewsTitle() %>
				                    </a>
				                </td>
				                <td><%= bookmark.getNewBookmarkedContent() %></td>
				                <td><%= bookmark.getBookmarkDate() %></td>
				                <td>
				                    <button type="button" class="deleteButton" data-member="<%= bookmark.getMemberId() %>" data-news-no="<%= bookmark.getNewsNo() %>">삭제</button>
				                </td>
				            </tr>
				        <% } %>
				    </tbody>
				</table>
            </form>
        <% } %>
    </div>
</section>
<br>

<script>

    $(document).ready(function() {
        $(".deleteButton").click(function() {
            const memberId = $(this).data("member");
            const newsNo = $(this).data("news-no");
            
            // 체크 상태인지 확인
            const isChecked = $(this).closest("tr").find("input[type='checkbox']").prop("checked");
            
            if (isChecked) {
                // 선택된 항목 삭제
                $(this).closest("tr").remove();
            } else {
                // AJAX를 통해 북마크 삭제 요청
                $.ajax({
                    url: "<%= request.getContextPath() %>/bookmark/deleteBookmark",
                    type: "POST",
                    data: {
                        newsNo: newsNo
                    },
                    success: function(response) {
                        // 삭제 성공 시 페이지 리로드
                        window.location.reload();
                    }
                });
            }
        });
        
        // 선택 항목 삭제 버튼 클릭 시 form 제출
        $("#deleteSelectedButton").click(function() {
            $("#deleteForm").submit();
        });
    });
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
