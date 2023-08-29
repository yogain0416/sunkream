<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../admin_top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnACateInput</title>
<script type="text/javascript">
	$(document).keypress(function(e) {
		if (e.keyCode == 13)
			e.preventDefault();
	});
	function enterBt(e){
		if(e.keyCode == 13){
			check();
		}
	}
	function check(){
		if (qna_cate.qna_cate.value=="선택"){
			alert("대분류를 선택해 주세요.")
			qna_cate.qna_cate.focus()
			return false
		}
		if (qna_cate.qna_subCate.value==""){
			alert("소분류를 입력해 주세요.")
			qna_cate.qna_subCate.focus()
			return false
		}
		if(qna_cate.qna_cate.value != "선택" && qna_cate.qna_subCate.value != ""){
			$.ajax({
		        url:'./checkSubCate.admin', 
		        type:'post', 
		        data:{qna_cate:qna_cate.qna_cate.value,qna_subCate:qna_cate.qna_subCate.value},
		        cache:false,
		        success:function(count){
		        	if(count == 1){
		        		alert("이미등록된 카테고리입니다.")
		        		return false
		        	}else{
		        		document.qna_cate.submit();
		        	}
		        },
		        error:function(){
		        	alert("에러");
		        }
		    });
		}
	}
</script>
</head>
<body>
<div class="div3">
	<div align="center">
		<form id="qna_cate" name="qna_cate" method="post" action="QnACateInput.admin" >
		<table class = "table table-hover" style = "width:60%;">
		<thead>
		<tr align ="center" >
		<td colspan = "2">
			<h3>카테고리 등록</h3>
			</td>
			</tr>
			</thead>
			<tr align = "center">
				<th>QnA_Cate</th>
				<td>
				<select name="qna_cate">
					<option value="선택" selected>---선택---</option>
					<option value="공지">공지</option>
					<option value="FAQ">FAQ</option>
					<option value="1:1문의">1:1문의</option>
				</select>
				</td>
			</tr>
			<tr align = "center">
				<th>QnA_subCate</th>
				<td><input type="text" name="qna_subCate" class = "form-control" onkeypress="enterBt(event)"></td>
			</tr>
		</table>
			<input type="button" value="등록" onclick="check()" class = "btn btn-outline-dark">
			<input type="reset" value="다시작성" class = "btn btn-outline-dark" >
		</form>
	</div>
	</div>
	</div>
</body>
</html>
<%@include file="../../bottom.jsp" %>