<%@page import="com.sk.goodogs.bookmark.model.vo.Bookmark"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script src="<%= request.getContextPath() %>/js/jquery-3.7.0.js"></script>

<%
	List<Bookmark> bookmarks = (List<Bookmark>) request.getAttribute("bookmarks");
%>
<!-- 
	@author 이혜령, 전수경
	- 북마크 목록 페이지
-->
<script>
bannerContainerLower = document.querySelector(".bannerContainerLower");
bannerContainerLower.style.display = "none";
bannerContainerUpper = document.querySelector(".bannerContainerUpper");
bannerContainerUpper.style.display = "none";
</script>

<section id=bookMark-container>
	<br>
		<h1>어떤 부분이 인상깊었개</h1>

	<% if(bookmarks.isEmpty() || bookmarks == null) { %>
	<h1>아직 북마크 한 기사가 없개!</h1>
	<% } else { %>
	<h1><%= bookmarks.size() %>개의 기사에 북마크 눌렀개!</h1>
	<% } %>
</section>

<style>
#tbl-script {
    border-collapse: collapse;
    margin: auto;
    table-layout: fixed;
}

#tbl-script th,
#tbl-script td {
    border: 1px solid black;
    padding: 5px;
    text-align: center;
}

#tbl-script th {
    background-color: #B5C99A;
}

#tbl-script tbody {
    background-color: #FFFFFF; /* 하얀색 배경 설정 */
}

#tbl-script tr th:first-of-type,
#tbl-script tr td:first-of-type {
    min-width: 70px;
}
#tbl-script tr th:nth-of-type(2),
#tbl-script tr td:nth-of-type(2) {
    max-width: 500px;
    min-width: 500px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
#tbl-script tr th:nth-of-type(3),
#tbl-script tr td:nth-of-type(3) {
    min-width: 70px;
}
#tbl-script tr th:nth-of-type(4),
#tbl-script tr td:nth-of-type(4) {
    min-width: 190px;
}
#tbl-script tr th:last-of-type,
#tbl-script tr td:last-of-type {
    min-width: 50px;
}
</style>
<section class="bookmark-container">
    <div class="bookmark">
        <% if (!bookmarks.isEmpty() && bookmarks != null) { %>
            <table id="tbl-script">
                <thead>
                    <tr>
                        <th>뉴스번호</th>
                        <th>뉴스제목</th>
                        <th>북마크내용</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Bookmark bookmark : bookmarks) { %>
                        <tr>
                            <td style="background-color: #FFFFFF;"><%= bookmark.getNewsNo() %></td>
                            <td style="background-color: #FFFFFF;"><%= bookmark.getNewsTitle() %></td>
                            <td style="background-color: #FFFFFF;"><%= bookmark.getNewBookmarkedContent() %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>
    </div>
</section>






<%@ include file="/WEB-INF/views/common/footer.jsp" %>