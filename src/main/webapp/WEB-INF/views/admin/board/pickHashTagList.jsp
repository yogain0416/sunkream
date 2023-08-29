<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../admin_top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PickHashTag</title>
<script type="text/javascript">
	function checkDel(pick_num){
		var isDel = window.confirm("정말로 삭제하시겠습니까?")
		if (isDel) {
			document.f.num.value = pick_num
			document.f.submit()	
		}
	}
	
	function checkHashTag(event){
		if(event.keyCode == 13){
			alert("동록할 해쉬태그 : "+document.getElementById('pickHash').value)
			checkHash();
			return
		} 
		return
	}
	
	
	function checkHash(){
		var pickHashTag = document.getElementById('pickHash').value;
		$.ajax({
	        url:'./pickHashTagInput.admin', 
	        type:'post', 
	        data:{pick_name:pickHashTag},
	        cache:false,
	        success:function(res){
	        	if(res == -1){
	        		alert('10개까지만 등록 가능합니다.')	
	        		return
	        	}else if(res == 0){
	        		alert('이미 등록된 추천 해시태그입니다.')	
	        		return
	        	}else if(res == 1){
	        		alert('새로 추가.')
	        	}else{
	        		alert('원래있던거에서 추가.')
	        	}
	        	location.href('pickHashTag.admin')
	        },
	        error:function(){
	        	alert("에러");
	        }
	    });
	}
</script>
</head>
<body>
<div class="div3" id = "basicFont">
	<div align="center">
		<table class="table table-hover" style="width:70%">
		<thead>
			<tr align = "center">
				<th>#Pick_name</th>
				<th>삭제</th>
			</tr>
			</thead>
			<div id="pickList">
			 <c:forEach var="dto" items="${pickList}">
			<tr align = "center">
				<td>${dto.pick_name}</td>
				<td>
				<i style = "cursor:pointer;" onclick = "javascript:checkDel('${dto.pick_num}')" class="bi bi-trash3"></i>
				</td>
			</tr>
			</c:forEach> 
			</div>
		</table>
		<input type="text" class = "form-control" style = "width:30%;" placeholder="등록할 추천해시태그 " id="pickHash" onkeypress="checkHashTag(event)">
		<br>
		<i class="bi bi-hash" onclick ="javascript:checkHash()" style = "cursor:pointer;" >추천해시태그등록</i>
	</div>
	</div>
	</div>
	<form name="f" method="POST" action="pickHashTagDel.admin">
		<input type="hidden" name="num"/>
	</form>
</body>
</html>
<%@include file="../../bottom.jsp" %>