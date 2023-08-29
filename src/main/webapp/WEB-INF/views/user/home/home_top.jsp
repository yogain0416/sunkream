<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "../../top.jsp"%>
<script>
function send(str) {
	var st = str;
	location.href = "tab.user?tab_name=" + encodeURI(st);
}
</script>
<style>
@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
.homeTop{
	font-family : 'GmarketSansMedium';
}
</style>
<header class = "header">
	<c:if test = "${not empty userTabList }">
				<div class ="homeTop" align = "left">
			<div class="container-fluid">
				<div class="col-xl-6 col-lg-7">
					<nav class="header__menu">
						<ul>
							<c:forEach var="dto" items="${userTabList}">
								<li><a href="javascript:send('${dto}')"><font size="5px">${dto}</font></a></li>
							</c:forEach>
						</ul>
					</nav>
				</div>
			</div>
			</div>
</c:if>
</header>