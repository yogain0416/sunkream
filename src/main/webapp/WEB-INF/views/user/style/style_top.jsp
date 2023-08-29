<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../../top.jsp"%>
<!DOCTYPE html>
<html>
<style>
.midleTopFont{
	font-family: 'GmarketSansMedium';
}
.filterStyle{
	padding-right : 20%;
	font-family : 'RixYeoljeongdo_Regular';
}
@font-face {
    font-family: 'RixYeoljeongdo_Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2102-01@1.0/RixYeoljeongdo_Regular.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
.styleTop{
	font-family : 'GmarketSansMedium';
}
@font-face {
    font-family: 'Dovemayo_gothic';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.1/Dovemayo_gothic.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
.basicFont{
	font-family: 'Dovemayo_gothic';
}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$('clickStyle').css("font-weight","bold");
	});
</script>
<body>
	<div align="center" class="styleTop">
		<a href="style.user"><h2>STYLE</h2></a>

		<div class="container-fluid">
			<div class="row"></div>
			<div class="col-xl-6 col-lg-7" align="left">
				<nav class="header__menu">
					<ul>
						<li><c:if test="${empty sessionUser_num}">
								<a href="main.login"> 팔로잉</a>
							</c:if> <c:if test="${not empty sessionUser_num}">
								<a href="styleFollowing.user">팔로잉</a>
							</c:if></li>
						<li><a href="style.user">발견</a></li>
						<li><a href="styleRanking.user">랭킹</a></li>
						<c:forEach var="dto" items="${cate_list}">
							<li><a href="styleProdTag.user?cate=${dto.cate_type}"
								style="font-size: 15px;">${dto.cate_kr_type}</a></li>
						</c:forEach>

						<div align="right">
							<c:if test="${empty sessionUser_num}">
								<li><a href="main.login">글쓰기</a></li>
							</c:if>
							<c:if test="${not empty sessionUser_num}">
								<li><a href="styleWrite.user">글쓰기</a></li>
							</c:if>
							<li><a href="styleSearch.user">검색</a></li>
						</div>
					</ul>
				</nav>
			</div>

			</div>
		</div>
</body>
</html>