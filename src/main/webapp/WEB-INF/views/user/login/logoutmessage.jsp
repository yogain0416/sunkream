<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- logoutmessage.jsp -->
<script type="text/javascript">
	if('${social}'=='naver'){
		location.href="${url}"
		alert("${msg}")
		location.href="main.login"
	};
	
	if('${social}'=='kakao'){
		location.href="${url}"
		alert("${msg}")
		location.href="main.login"
	};
	
	
	if('${social}'== ''){
		alert("${msg}")
		location.href="main.login"
	};
</script>