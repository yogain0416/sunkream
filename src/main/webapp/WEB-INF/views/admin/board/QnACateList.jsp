<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../admin_top.jsp" %>
<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function checkDel(qna_cate_num){
		var isDel = window.confirm("정말로 삭제하시겠습니까?")
		if (isDel) {
			document.f.num.value = qna_cate_num
			document.f.submit()	
		}
	}
</script>
</head>
<body>
<div class="div3" id = "basicFont">
	<div align="center">
	<h3>QnA카테고리</h3>
	<hr width = "60%">
		<table class = "table table-hover" style="width:80%;">
		<thead>
			<tr align = "center">
				<th>QnA_Cate</th>
				<th>QnA_subCate</th>
				<th>삭제</th>
			</tr>
			</thead>
			 <c:forEach var="dto" items="${qnaList}">
			<tr align = "center">
				<td>${dto.qna_cate}</td>
				<td>${dto.qna_subCate}</td>
				<td><i style="cursor:pointer;"  onclick = "javascript:checkDel('${dto.qna_cate_num}')" class="bi bi-trash3"></i>
</td>
			</tr>
			</c:forEach> 
		</table>
		<br>
		<a href = "QnACateInput.admin">등록하기<i style = "cursor:pointer;"  class="bi bi-pencil-square"></i></a>
	</div>
	</div>
	</div>
	<form name="f" method="POST" action="QnACateDelete.admin">
		<input type="hidden" name="num"/>
	</form>
</body>
</html>
<%@include file="../../bottom.jsp" %>