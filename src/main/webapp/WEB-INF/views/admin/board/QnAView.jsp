<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../admin_top.jsp" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>QnAView</title>
</head>
<body>
<div class="div3" id = "basicFont">
	<div align="center">
	<h3>${getBoard.qna_subject}</h3>
	<br>
	<hr width = "60%">
		<table  style = "width:400px;" class = "table">
		<thead>
		<tr align = "center">
		<th colspan = "2">게시글 상세보기</th>
		</tr>
		</thead>
		<tbody>
		<tr align = "center">
			<td>번호</td>
			<td width = "70%">${getBoard.qna_num}</td>
		</tr>
		<tr align = "center">
			<td>카테고리</td>
			<td width = "70%">${getBoard.qna_cate}</td>
		</tr>
		<tr align = "center">
			<td>서브카테고리</td>
			<td width = "70%">${getBoard.qna_subCate}</td>
		</tr>
		<c:if test="${not empty imgList}">
			<tr align = "center" >
				<td>이미지</td>
				<td width = "70%">
				<c:forEach var="imgDTO" items="${imgList}">
				<img src="${upPath}/${imgDTO.qna_img}" width="100" height="100">
				</c:forEach>
				</td>
			</tr>
		</c:if>
		<tr align = "center">
			<td>내용</td>
			<td width = "70%">${getBoard.qna_contents}</td>
		</tr>
		</tbody>
		</table>
		<c:if test="${getBoard.qna_cate == '1:1문의' && getBoard.qna_process != '답변'}">
			<a href = "askReply.admin?qna_num=${getBoard.qna_num}">
			답변
			<svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" class="bi bi-reply-fill" viewBox="0 0 16 16">
  <path d="M5.921 11.9 1.353 8.62a.719.719 0 0 1 0-1.238L5.921 4.1A.716.716 0 0 1 7 4.719V6c1.5 0 6 0 7 8-2.5-4.5-7-4-7-4v1.281c0 .56-.606.898-1.079.62z"/>
</svg></a>
		</c:if>
		<c:if test="${getBoard.qna_process == '답변'}">
		<i class="bi bi-pencil-fill" style = "cursor:pointer;" onclick="location.href='QnABoardEdit.admin?qna_num=${getBoard.qna_num}'" >수정</i>
		</c:if>
		<c:if test="${getBoard.qna_cate != '1:1문의' }">
		<i class="bi bi-pencil-fill" style = "cursor:pointer;" onclick="location.href='QnABoardEdit.admin?qna_num=${getBoard.qna_num}'" >수정</i>
		&nbsp;&nbsp;
		<i class="bi bi-trash3" style = "cursor:pointer;" onclick="location.href='QnABoardDelete.admin?qna_num=${getBoard.qna_num}'">삭제</i>&nbsp;&nbsp;
		</c:if>
		<a href = "javascript:window.history.back()">
		목록으로
		<svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" class="bi bi-card-list" viewBox="0 0 16 16">
  <path d="M14.5 3a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-.5.5h-13a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h13zm-13-1A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-13z"/>
  <path d="M5 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 5 8zm0-2.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zm0 5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zm-1-5a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0zM4 8a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0zm0 2.5a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0z"/>
</svg>
		</a>
		
	</div>
	</div>
	</div>
</body>
</html>
<%@include file="../../bottom.jsp" %>