<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/bootstrap.min.css" type="text/css">
<style>
.reportOpen{
	padding-top : 1em;
}

</style>
</head>
<script type="text/javascript">
	function closeAndGo(url) {
		self.close()
		window.opener.location.href = url
	}
	function ban(user_num, mode) {
		var isDel = window.confirm("정말로 차단하시겠습니까?")
		if (isDel) {
			location.href = 'ban.user?user_num=' + user_num + '&mode=' + mode;
		}
	}
</script>
<body>
	<div align="center" class="reportOpen">
	<input type="button" value="프로필 신고 " onclick="closeAndGo('qnaWriteForm.user?report_num=${report_num}')" 
					class="btn btn-outline-dark"/>
	<br>
	<input type="button" value="프로필 차단 " onclick="ban('${report_num}','ban')" 
					class="btn btn-outline-dark"/>
	</div>
</body>
</html>