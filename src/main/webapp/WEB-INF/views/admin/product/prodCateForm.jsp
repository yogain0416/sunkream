<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../admin_top.jsp"%>
<script>
function utf(id){
	 var regexp = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
	    var value = $("#"+id).val();
	    if (regexp.test(value)) {
	        $("#"+id).val(value.replace(regexp, ''));
	    }
}
function onSubmit(){
	document.f.submit();
}
function reset(){
	document.f.reset();
}
</script>
<html>
<style>
input[type=text]{
	width:80%;
}
</style>
<head>
<meta charset="UTF-8">
<title>cateInput</title>
</head>
<body>
<div class = "div3" align = "left" id = "basicFont">
<div align="center">
<h3>카테고리 등록</h3>
<br>

<form name = "f" action = "prodCateInput.admin" method = "post" >
	<table class = "table" style="width:80%;">
		<thead>
		<tr align = "center">
		<th>분류
		</th>
		<th>입력</th>
		</tr>
		</thead>
		<tr align = "center">
			<td>카테고리 브랜드 영문명 </td>
			<td><input type = "text" class = "form-control" name = "cate_brand" style="ime-mode: disabled; text-transform: uppercase;">
		</tr>
		<tr align = "center">
			<td>카테고리 브랜드 한글명 </td>
			<td><input type = "text" class = "form-control" name = "cate_kr_brand" id = "cate_kr_brand" onkeyup="utf('cate_kr_brand')" style='ime-mode: active'>
		</tr>
		<tr align = "center">
			<td>카테고리 대분류 영문명 </td>
			<td><input type = "text" class = "form-control" name = "cate_type" style="ime-mode: disabled; text-transform: uppercase;">
		</tr>
		<tr align = "center">
			<td>카테고리 대분류 한글명 </td>
			<td><input type = "text" class = "form-control" name = "cate_kr_type" id = "cate_kr_type" onkeyup="utf('cate_kr_type')" style='ime-mode: active'>
		</tr>
		<tr align = "center">
			<td>카테고리 소분류 영문명 </td>
			<td><input type = "text" class = "form-control" name = "cate_subType" style="ime-mode: disabled; text-transform: uppercase;">
		</tr>
		<tr align = "center">
			<td>카테고리 소분류 한글명 </td>
			<td><input type = "text" class = "form-control" name = "cate_kr_subType" id = "cate_kr_subType" onkeyup="utf('cate_kr_subType')" style='ime-mode: active'>
		</tr>
		<tr align = "center">
		<td colspan = "2" align = "center">
		<i class="bi bi-check-lg" onclick="onSubmit()"  style= "cursor:pointer;">등록</i> &nbsp; &nbsp;
		<i class="bi bi-x-lg" onclick = "reset()"  style = "cursor:pointer">취소</i></td>
		</tr>
	</table>
	</form>
</div>
</div>
</div>
</body>
</html>
<%@include file="../../bottom.jsp"%>

