<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../admin_top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PickSearch</title>
<script type="text/javascript">
	function checkDel(search_num){
		var isDel = window.confirm("정말로 삭제하시겠습니까?")
		if (isDel) {
			document.f.num.value = search_num
			document.f.submit()	
		}
	}
	
	function checkSearch(event){
		if(event.keyCode == 13){
			alert("동록할 검색어 : "+document.getElementById('pickSearch').value)
			checkSearchString();
			return
		} 
		return
	}
	
	
	function checkSearchString(){
		var pickSearch = document.getElementById('pickSearch').value;
		$.ajax({
	        url:'./pickSearchInput.admin', 
	        type:'post', 
	        data:{search_name:pickSearch},
	        cache:false,
	        success:function(res){
	        	if(res == -1){
	        		alert('10개까지만 등록 가능합니다.')
	        	}else if(res == 0){
					alert('이미 등록된 추천검색어 입니다.')
					return
				}else{
					alert('검색어가 등록되었습니다.')
					location.href('pickSearch.admin')
				}
	        },
	        error:function(){
	        	alert("에러");
	        }
	    });
	}
</script>
</head>
<body>
<div class="div3">
	<div align="center">
		<table class="table table-hover" style = "width:70%">
		<thead>
			<tr align = "center">
				<th>Search_name</th>
				<th>삭제</th>
			</tr>
			</thead>
			<div id="pickList">
			 <c:forEach var="dto" items="${pickList}">
			<tr align = "center">
				<td>${dto.search_name}</td>
				<td>
				<i style = "cursor:pointer;" onclick = "javascript:checkDel('${dto.search_num}')" class="bi bi-trash3"></i>
				
				</td>
			</tr>
			</c:forEach> 
			</div>
		</table>
		<input type="text" class = "form-control" style = "width:30%;" placeholder="등록할 추천검색어 " id="pickSearch" onkeypress="checkSearch(event)">
		<i  onclick="javascript:checkSearch()"  class="bi bi-check-circle" style = "cursor:pointer;">추천검색어등록</i>
	</div>
	</div>
	</div>
	<form name="f" method="POST" action="pickSearchDel.admin">
		<input type="hidden" name="num"/>
	</form>
</body>
</html>
<%@include file="../../bottom.jsp" %>