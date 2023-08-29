<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../admin_top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<style>
.table table-hover {
	width:"400px";
}
</style>
<meta charset="UTF-8">
<title>askReply</title>
</head>
<script type="text/javascript">
	function setPenalty(report_num){
		var isReport = confirm("패널티 점수를 주시겠습니까?")
		if(isReport){
			var info = prompt("신고 정보를 입력해 주세요.")
			if(info == null) return
			document.getElementById('admin_info').value = info;
			document.getElementById('penalty').value = "패널티 취소";
        	document.getElementById('penalty').onclick=function(){
        		cancelPenalty(report_num);
        	}	
        	document.getElementById('qna_process').value = "처리완료";
		}
	}
	
	function cancelPenalty(report_num){
		document.getElementById('admin_info').value = "";
		document.getElementById('penalty').value = "패널티 추가";
    	document.getElementById('penalty').onclick=function(){
   			setPenalty(report_num);
    	}
    	document.getElementById('qna_process').value="대기중";
	}
	
	function check(){
		if(askReply.qna_subject.value == ""){
			alert("제목을 입력하세요.")
			askReply.qna_subject.focus();
			return false
		}
		if(askReply.qna_contents.value == ""){
			alert("내용을 입력하세요.")
			askReply.qna_contents.focus();
			return false
		}
		return true
	}
	function onSubmit(){
		document.askReply.submit();
	}
</script>
<body>
<div class="div3">
<div align="center">
	<form name="askReply" method="post" action="askReply.admin" onsubmit="return check()">
		<input type="hidden" name="qna_num" value="${getBoard.qna_num}">
		<input type="hidden" name="user_num" value="${getBoard.user_num}">
		<input type="hidden" name="qna_step" value="${getBoard.qna_step}">
		<input type="hidden" name="qna_cate" value="${getBoard.qna_cate}">
		<input type="hidden" name="qna_subCate" value="${getBoard.qna_subCate}">
		<input type="hidden" name="report_num" value="${getBoard.report_num}">
		<input type="hidden" name="reg_date" value="${getBoard.reg_date}">
		<table class = "table" style = "width:80%">
		<thead>
		<tr align= "center">
		<td colspan = "2">[${getBoard.qna_subject}] 게시글 답변</td>
		</tr>
		</thead>
			<tr align= "center">
				<th>제목</th>
				<td><input type="text" name="qna_subject" class="form-control" style = "width:60%;"></td>
			</tr>
			<tr align = "center">
				<th>답변내용</th>
				<td><textarea name="qna_contents" class="form-control" style = "width:60%;" cols="30" rows="10"></textarea></td>
			</tr>
			<tr align = "center">
				<th>진행상황</th>
				<td>
				<c:if test="${getBoard.report_num == 0}">
				<select name="qna_process" style = "width:30%;"class="form-select form-select-lg mb-3" aria-label=".form-select-lg example">
					<option value="대기중">대기중</option>
					<option value="처리완료">처리완료</option>
				</select>
				</c:if>
				<c:if test="${getBoard.report_num != 0}">
				<input type="text" id="qna_process" name="qna_process" value="대기중" size="5" readOnly>
				<input type="button" id="penalty"  value="패널티 추가" onclick="setPenalty('${getBoard.report_num}')">
				<input type="hidden" id="admin_info" name="admin_info">
				</c:if>
				</td>
			</tr>
			<tr align = "center">
				<td colspan="2" align="center">
				<i onclick = "onSubmit()" style = "cursor:pointer;" class="bi bi-reply">답변</i>
				&nbsp;&nbsp;
				<i onclick = "history.back()" class="bi bi-x-circle-fill" style = "cursor:pointer;">취소</i>
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