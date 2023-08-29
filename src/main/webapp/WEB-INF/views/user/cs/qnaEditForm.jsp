<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="top.jsp" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<style>
#reportRow {
	display: none;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>qnaEditForm</title>
</head>
<script src="resources/js/admin/board/QnABoardEdit.js"></script>
<body>
	<script>
	function onSubmit(){
		document.QnABoardEdit.submit();
	}
	</script>
	<div class="div3" id = "basicFont">
	<div align="center">
		<form name="QnABoardEdit" method="post" action="qnaEditForm.user"
			onsubmit="return checkInput()" enctype="multipart/form-data">
			<input type="hidden" name="user_num" value="${sessionUser_num }">
			<input type="hidden" name="qna_num" value="${getBoard.qna_num}">
			<input type="hidden" name="qna_cate" value="${getBoard.qna_cate}">
			<input type="hidden" name="qna_subCate" value="${getBoard.qna_subCate}">
			
			<!-- <input type="hidden" name = "user_num" value="1"> -->

			<table class = "table" style = "width:70%;">
			<thead>
			<tr align = "center">
			<td colspan = "2"><h3>게시글 수정</h3></td>
			</tr>
			</thead>
				<tr align = "center">
					<th>카테고리</th>
					<th>${getBoard.qna_cate}[${getBoard.qna_subCate}]</th>
				</tr>
				<tr align = "center">
					<th>제목</th>
					<td><input type="text" name="qna_subject" class = "form-control" style = "width:40%;"
						value="${getBoard.qna_subject}"></td>
				</tr>
				<c:if test="${not empty imgList}">
					<tr align = "center">
						<th>이미지</th>
						<td>
							<div class="form-group file-group" id="file-list">
								<c:forEach items="${imgList}" var="file">
									<div class="file-input">
										<!-- <span class="glyphicon glyphicon-camera" aria-hidden="true"></span> -->
										<img src="${upPath}/${file.qna_img}" width="50" height="50"><br>
										${file.qna_img} <a href='#this' name='file-delete'>삭제</a> 
										<input type="hidden" name="file_img" value="${file.qna_img}">
									</div>
								</c:forEach>
							</div>
							<div id="attachFileDiv">
								<div id="file0">
									<input type="file" id="file_img0" name="file_img0" value=""
										size="20" onchange="javascript:attachFile.add(0)">
								</div>
							</div>
						</td>
					</tr>
				</c:if>
				<tr align = "center">
					<th>내용</th>
					<td><textarea class = "form-control"  style = "width:60%;" name="qna_contents" cols="30" rows="15">${getBoard.qna_contents}</textarea>
					</td>
				</tr>
			</table>
			<i onclick = "onSubmit()" class="bi bi-pencil-square" style = "cursor:pointer;">수정</i>
			<i onclick= "location.href='qnaEditForm.user?qna_num=${getBoard.qna_num}'" style = "cursor:pointer;" class="bi bi-x-circle">다시작성</i>
		</form>
	</div>
	</div>
	</div>
</body>
</html>
<%@include file="../../bottom.jsp"%>