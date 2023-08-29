<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="../../top.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<title>아이디/비밀번호찾기</title>
<link rel="stylesheet" href="resources/css/bootstrap.css"/>
</head>
<body>
<div class="container" align="center">

<c:if test="${mode eq 'id'}">
<h1>이메일 주소 찾기에 성공하였습니다.</h1>
<hr width="500" color="Black" size="2">
<h3>${email}</h3><br>
<button class="btn btn-outline-info" type=button onclick="location='findPw.login'">비밀번호 찾기</button>
<button class="btn btn-outline-dark" type=button onclick="location='main.login'">로그인</button>
</c:if>
<c:if test="${mode eq 'pw'}">
<h1>휴대폰번호로 임시 비밀번호가 전송되었습니다.
전송 받은 임시 비밀번호로 로그인해주세요.</h1>
<button class="btn btn-outline-dark" type=button onclick="location='main.login'">로그인</button>
</c:if>
</div>
</body>
</html>
<%@include file="../../bottom.jsp" %>