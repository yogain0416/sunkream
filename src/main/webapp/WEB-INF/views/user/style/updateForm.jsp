<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="style_top.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function styleContents() {
   const text = document.querySelector('#textarea');
   const value = text.value;

   document.getElementById('style_contents').value = value.replace(
         /(?:\r\n|\r|\n)/g, '<br>');
   document.getElementById('ex_style_contents').value = document.getElementById('ex_style_contents').value.replace(
         /(?:\r\n|\r|\n)/g, '<br>');
   return true
}

function styleEdit(){
	var check = styleContents();
	if(check){
		document.f.submit();
	}
}
</script>



</head>
<body>
<div align = "center" class="basicFont">
<img src="${upPath}/${dto.style_img1}" height="150" width="150">
<c:if test="${dto.style_img2 ne null}">
<img src="${upPath}/${dto.style_img2}" height="150" width="150">
</c:if>
<c:if test="${dto.style_img3 ne null}">
<img src="${upPath}/${dto.style_img3}" height="150" width="150">
</c:if>
<c:if test="${dto.style_img4 ne null}">
<img src="${upPath}/${dto.style_img4}" height="150" width="150">
</c:if>
<c:if test="${dto.style_img5 ne null}">
<img src="${upPath}/${dto.style_img5}" height="150" width="150">
</c:if>
<br>
<form name = "f" action="updateBoard.user" method="post">
<textarea rows="15" class = "form-control" style= "display:inline;width:40%;" cols="30" id="textarea">${dto.style_contents}</textarea>
<input type="hidden" id="style_contents" name="style_contents">
<input type="hidden" id="ex_style_contents" name="ex_style_contents" value="${dto.style_contents}">
<input type="hidden" id="reg_date" name="reg_date" value="${dto.reg_date}">
<input type="hidden" id="style_num" name="style_num" value="${dto.style_num}">
<input type="hidden" id="user_num" name="user_num" value="${dto.user_num}">
<br>
<i class="bi bi-pencil-square" onclick="styleEdit()" style = "cursor:pointer;">수정</i>
<i onclick= "location.href='styleView.user?userNum=${dto.user_num}&styleNum=${dto.style_num}'" style = "cursor:pointer;" class="bi bi-x-circle">다시작성</i>
</form>
</div>
</div>
</body>
</html>
<%@include file="../../bottom.jsp"%>