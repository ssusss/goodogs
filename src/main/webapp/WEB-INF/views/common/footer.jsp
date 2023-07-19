<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	    <aside>
	      <a class="home-banner" href=" " target=" " rel=" ">
	        <figure class="home-banner-image">
	        	<img src="<%= request.getContextPath() %>/images/character/goodogs_laptop.png">
	        </figure>
	      </a>
	    </aside>
	
	    <footer class="footer" role="contentinfo">
	
	      <div class="footerAddress">
	      	<h1 id="toMain2">goodogs</h1>
	      </div>
	      <nav class="footer-sitemap">
	        <div class="footer-sitemap-item">
	          <a class="footer-sitemap-item-link"> 뉴닉 탄생기</a>
	          <a class="footer-sitemap-item-link"> 고객센터 </a>
	        </div>
	      </nav>
	      <div class="footer-address-info"></div>
	    </footer>
    </div>
    <script>
    toMain2.onclick = () => {
      location.href = '<%=request.getContextPath()%>/';
    }
    </script>
</body>
</html>