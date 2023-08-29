<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <link rel="stylesheet" href="resources/css/bootstrap.min.css"
   type="text/css">
<style>
@font-face {
    font-family: 'Dovemayo_gothic';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.1/Dovemayo_gothic.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
.basicFont{
	font-family: 'Dovemayo_gothic';
}
#basicFont{
	font-family: 'Dovemayo_gothic';
}
</style>
<script>
function editAddress(i){
    var name = document.getElementById('name'+i).value;
    var phone = document.getElementById('phone'+i).value;
    var addr = document.getElementById('addr'+i).value;
    var address1 = document.getElementById('address1'+i).value;
    var address2 = document.getElementById('address2'+i).value;
    var address3 = document.getElementById('address3'+i).value;
    window.opener.document.getElementById('name').value = name; 
    window.opener.document.getElementById('phone').value = phone; 
    window.opener.document.getElementById('addr').value = addr;
    window.opener.document.getElementById('address1').value = address1;
    window.opener.document.getElementById('address2').value = address2;
    window.opener.document.getElementById('address3').value = address3;
	window.opener.isAddress = true;
	if(window.opener.isAccount && window.opener.isAddress && window.opener.isPrice){
  		window.opener.document.getElementById('confirm').disabled = false;  
  	  }
    self.close();
}

function delAddress(address_num,user_num,basic){
   var mode = document.getElementById('mode').value;
   if(basic == "Y"){
      alert('다른 주소를 기본배송지로 변경 후, 삭제할 수 있습니다.')
   }else{
      location.href = "delAddress.user?address_num="+address_num+"&user_num="+user_num+"&mode="+mode;
   }
}
</script>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>주소록</h2>
<br>
<div class="basicFont">
<div align="center">
<c:if test="${empty addressList}">
   <b>등록된 주소가 없습니다.</b>
</c:if>
</div>
<c:set var = "i" value = "0"/>
<c:forEach var="dto" items="${addressList}">
<table>
<c:set var = "i" value = "${i+1}"/>
   <tr>
      <th align="left">
         <c:if test="${dto.basic == 'Y'}">
         <input type="text" id = "name${i}" value="${dto.name}" style="border:none;" readOnly>
         </c:if>
         <c:if test="${dto.basic == 'N'}">
         <input type="text" id ="name${i}"  value="${dto.name}" style="border:none;" readOnly>
         </c:if>
      </th>
      <th rowspan="3">
         <input type="button" value="이 주소로 변경" onclick="editAddress(${i})" class="btn btn-outline-dark">
      </th>
   </tr>
   <tr>
      <th><input type="text" id = "phone${i }" value="${dto.phone_num}" style="border:none; width:400px" readOnly></th>
   </tr>
   <tr>
      <th><input type="text" id ="address1${i}" value="${dto.address1}" style="border:none; width:400px;" readOnly></th>
   </tr>
   <tr>
   		<th><input type="text" id ="address2${i}" value="${dto.address2}" style="border:none; width:400px;" readOnly></th>
   		<th rowspan="2"><input type="button" value="삭제" class="btn btn-outline-dark" onclick="delAddress('${dto.address_num}','${dto.user_num}','${dto.basic}')"></th>
   </tr>
   <tr>
   		<th><input type="text" id ="address3${i}" value="${dto.address3}" style="border:none; width:400px;" readOnly></th>
   </tr>
</table>
<input type="hidden" id ="addr${i}" value="(${dto.address1})${dto.address2} ${dto.address3}" style="border:none; width:400px;" readOnly>
<input type=  "hidden" id = "mode" value = "${mode }">
<c:if test="${dto.basic == 'Y'}">
<hr style="border:1px solid;">
</c:if>
<c:if test="${dto.basic == 'N'}">
<hr>
</c:if>
</c:forEach>
<div align="center">
	<input type="button" class="btn btn-outline-dark" value="확인" onclick="self.close()">
</div>
</div>
</body>
</html>