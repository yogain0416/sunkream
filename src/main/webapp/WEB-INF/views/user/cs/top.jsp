<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file = "../../top.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
	var link =  document.location.href.split("/")[4].split("?")[0];
	document.getElementById(link).className = "nav-link active";
})
</script>    
<header class = "header">
	<div class ="shopTop" align = "center">
			<div class="container-fluid">
				<div class="col-xl-6 col-lg-7">
					<nav class="header__menu">
						<div class="col" align="center">
							<h3>
								<b>고객센터</b>
							</h3>
						</div>
						<div align="center">
							<ul>
							  <li class="nav-item">
							    <a class="nav-link" href="announce.user" aria-current="page" id="announce.user">공지사항</a>
							  </li>
							  <li class="nav-item">
							    <a class="nav-link" href="faq.user" id="faq.user">자주하는질문</a>
							  </li>
							  <c:if test="${empty sessionUser_num}">
							  <li class="nav-item">
							    <a class="nav-link" href="main.login">1:1문의</a>
							  </li>
							  </c:if>
							  <c:if test="${not empty sessionUser_num}">
							  <li class="nav-item">
							    <a class="nav-link" href="qna.user?user_num=${sessionUser_num}" id="qna.user">1:1문의</a>
							  </li>
							  </c:if>
							</ul>
						</div>
					</nav>
				</div>
			</div>
		</div>
</header>
