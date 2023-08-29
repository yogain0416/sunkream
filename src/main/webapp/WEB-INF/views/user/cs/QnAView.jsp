<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnAView</title>
</head>
<body>
<div class="div3" id = "basicFont">
	<div align="center">
		<table class="table table-hover" style = "width:70%;">
		<thead>
		<tr align = "center"><td colspan="2"><h3>[${getBoard.qna_subject}]</h3></td>
		
		</tr>
		</thead>
		<tr align = "center">
			<th>번호</th>
			<td>${getBoard.qna_num}</td>
		</tr>
		<tr align = "center">
			<th>분류</th>
			<td>${getBoard.qna_cate}</td>
		</tr>
		<tr align = "center">
			<th>상세분류</th>
			<td>${getBoard.qna_subCate}</td>
		</tr>
		<tr align = "center">
			<th>제목</th>
			<td>${getBoard.qna_subject}</td>
		</tr >
		<c:if test="${not empty imgList}">
		<tr align = "center">
			<th>이미지</th>
			<td>
			<c:forEach var="imgDTO" items="${imgList}">
			<img src="${upPath}/${imgDTO.qna_img}" width="100" height="100">
			</c:forEach>
			</td>
		</tr>
		</c:if>
		<tr align = "center">
			<th>내용</th>
			<td>${getBoard.qna_contents}</td>
		</tr>
		</table>
		<c:if test="${getBoard.user_num == sessionUser_num && getBoard.qna_process != '답변'}">
		<input type="button" class="btn btn-outline-dark" value="수정" onclick="location.href='qnaEditForm.user?qna_num=${getBoard.qna_num}'">
		</c:if>
		<input type="button" class="btn btn-outline-dark" value="돌아가기" onclick="window.history.back()">
	</div>
	</div>
	</div>
</body>
</html>
<%@include file="../../bottom.jsp" %>