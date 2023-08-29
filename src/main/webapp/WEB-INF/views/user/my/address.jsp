<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Address</title>
</head>
<script type="text/javascript">
	function addAddress(co){
		if(co >= 5){
			alert('주소는 5개까지 등록 가능합니다.')
			return
		}
		window.open('addAddress.user', '', "width=720, height=780,scrollbars=yes, resizable=no, left=pixels");
	}
	
	function changeBasicAddress(address_num,user_num){
		location.href = "changeBasicAddress.user?address_num="+address_num+"&user_num="+user_num;
	}
	
	function editAddress(address_num){
		window.open('editAddress.user?address_num='+address_num, '', "width=720, height=780,scrollbars=yes, resizable=no, left=pixels");
	}
	function delAddress(address_num,user_num,basic){
		if(basic == "Y"){
			alert('다른 주소를 기본배송지로 변경 후, 삭제할 수 있습니다.')
		}else{
			location.href = "delAddress.user?address_num="+address_num+"&user_num="+user_num;
		}
	}
</script>
<body>
<h2>주소록</h2>
<div align="right" class="basicFont">
<input type="button" value="+새 배송지 추가" onclick="addAddress('${count}')" class="btn btn-outline-dark">
</div>
<br>
<div align="center" class="basicFont">
<c:if test="${empty addressList}">
	<b>등록된 주소가 없습니다.</b>
</c:if>
</div>
<div class="basicFont">
<c:forEach var="dto" items="${addressList}">
<table>
	<tr width="500">
		<th width="50%">
			<c:if test="${dto.basic == 'Y'}">
			<input type="text" value="${dto.name} [기본배송지]" style="border:none;" readOnly>
			</c:if>
			<c:if test="${dto.basic == 'N'}">
			<input type="text" value="${dto.name}" style="border:none;" readOnly>
			</c:if>
		</th>
		<th rowspan="3" align="right" width="50%">
			<c:if test="${dto.basic == 'N'}">
				<input type="button" value="기본배송지" class="btn btn-outline-dark"
				onclick="changeBasicAddress('${dto.address_num}','${dto.user_num}')">
			</c:if>
			<input type="button" value="수정" class="btn btn-outline-dark"
			onclick="editAddress('${dto.address_num}')">
			<input type="button" value="삭제" class="btn btn-outline-dark"
			onclick="delAddress('${dto.address_num}','${dto.user_num}','${dto.basic}')">
		</th>
	</tr>
	<tr>
		<th><input type="text" value="${dto.phone_num}" style="border:none;" readOnly></th>
	</tr>
	<tr>
		<th><input type="text" value="(${dto.address1})${dto.address2} ${dto.address3}" style="border:none; width:500px;" readOnly></th>
	</tr>	
</table>
<c:if test="${dto.basic == 'Y'}">
<hr style="border:1px solid;">
</c:if>
<c:if test="${dto.basic == 'N'}">
<hr>
</c:if>
</c:forEach>
</div>
</body>
</html>
<%@include file="bottom.jsp" %>