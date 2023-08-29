<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../admin_top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>StyleList</title>
<script type="text/javascript">
	function likeAfterPage(styleNum, search) {
		location.href = 'likeStyle.user?styleNum=' + styleNum + '&search='
				+ encodeURIComponent(search)
	}
</script>
</head>
<body>
<div class="div3">
	<div align="center">
		<h1>${search}</h1>

		<table>
			<c:set var="count" value="0" />
			<tr>
				<c:forEach var="dto" items="${styleList}">
					<td>사진:${dto.style_img1} <br> 
					<img src="${upPath}/${dto.style_img1}"> <br> 
					작성자:${dto.profile_name} <br> 
					<a href="javascript:likeAfterPage('${dto.style_num}','${search}')">좋아요</a>: ${dto.style_like}
					<br>글 내용: ${dto.style_contents}
					</td>
					<c:set var="count" value="${count+1}" />
					<c:if test="${count%4==0}">
			</tr>
			<tr>
				</c:if>
				</c:forEach>
		</table>
	</div>
	</div>
	</div>
</body>
</html>
<%@include file="../../bottom.jsp" %>