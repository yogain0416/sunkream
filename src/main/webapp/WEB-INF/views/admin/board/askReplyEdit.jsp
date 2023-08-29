<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../admin_top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>askReply</title>
</head>
<body>
<div class="div3">
<div align="center">
	<form name="askReplyEdit" method="post" action="askReplyEdit.admin">
		<input type="hidden" name="qna_num" value="${getBoard.qna_num}">
		<input type="hidden" name="user_num" value="${getBoard.user_num}">
		<input type="hidden" name="qna_step" value="${getBoard.qna_step}">
		<input type="hidden" name="qna_cate" value="${getBoard.qna_cate}">
		<input type="hidden" name="qna_subCate" value="${getBoard.qna_subCate}">
		<input type="hidden" name="report_num" value="${getBoard.report_num}">
		<input type="hidden" name="reg_date" value="${getBoard.reg_date}">
		<table border="1">
		<caption>${getBoard.qna_subject} 게시글 답변</caption>
			<tr>
				<th>제목</th>
				<td><input type="text" name="qna_subject" value="${getBoard.qna_subject}"></td>
			</tr>
			<tr>
				<th>답변내용</th>
				<td><textarea name="qna_contents" cols="30" rows="30">${getBoard.qna_contents}</textarea></td>
			</tr>
			<tr>
				<th>진행상황</th>
				<td>
				<select name="qna_process">
					<option value="대기중">대기중</option>
					<option value="처리완료">처리완료</option>
				</select>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<input type="submit" value="확인">
				<input type="button" value="취소" onclick="location.href='QnABoardList.admin'">
				</td>
			</tr>
		</table>
	</form>
</div>
</div>
</div>
</body>
</html>
<%@include file="../../bottom.jsp" %>