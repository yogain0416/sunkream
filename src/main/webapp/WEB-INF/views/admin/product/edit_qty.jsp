<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
	function setConfirmSize(prod_num) {
		var input = document.getElementById("size"+prod_num).value;
		var pageNum = document.getElementById("pageNum").value;
		alert(pageNum)
		if(input == null || input == ''){
			alert("수량을 입력해주세요 !")
			return;
		} 
		window.opener.location.href = "qty_edit_ok.admin?prod_num="+prod_num+"&prod_qty="+input+"&pageNum="+pageNum;
		window.close()
	}
</script>
<html>
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
   <link rel="stylesheet" href="resources/css/bootstrap.min.css"
   type="text/css">
<head>
<meta charset="UTF-8">
<title>사이즈 수량 수정</title>
</head>
<body>
	<div align="center">
		<font size="6" color="Black">${dto.prod_kr_subject }</font><br>
		<font size="4" color="Gray">상품 수량추가</font><br>
		<font size="4" color="Gray">현재수량:${dto.prod_qty }</font><br>
		<input type="text" class = "form-control" style = "display:inline;width:50%;" value="" id="size${dto.prod_num }"
			size="30"> <br> 
			<i class="bi bi-plus-circle" onclick="setConfirmSize(${dto.prod_num})" style = "cursor:pointer">수량추가</i>
		<input type="hidden" id="pageNum" name="pageNum" value="${pageNum }">
		&nbsp;&nbsp;<i class="bi bi-x-lg" onclick="window.close()" style = "cursor:pointer;">닫기</i>
	</div>
</body>
</html>