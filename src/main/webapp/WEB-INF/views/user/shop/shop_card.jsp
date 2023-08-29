<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Address</title>
</head>
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<link rel="stylesheet" href="resources/css/bootstrap.min.css"
   type="text/css">
<script type="text/javascript">
function changeCard(i){
	var name = document.getElementById('name'+i).value;
	var num = document.getElementById('num'+i).value;
	var date = document.getElementById('date'+i).value;
	if(window.opener.document.getElementById('emptyCard')){
		window.opener.document.getElementById('first_bankName').value = name;
		window.opener.document.getElementById('first_cardNum').value = num;
		window.opener.document.getElementById('first_cardDate').value = date;
		window.opener.document.getElementById('firstCardBt').style.display = 'block';
	}
	if(!window.opener.document.getElementById('emptyCard')){
		window.opener.document.getElementById('card_name').value = name;
		window.opener.document.getElementById('card_num').value = num;
		window.opener.document.getElementById('card_date').value = date;
	}	
	self.close();
}
function delCard(myCard_num,user_num,basic){
	if(basic == "Y"){
		alert('다른 카드를 기본카드로 변경 후, 삭제할 수 있습니다.')
	}else{
		location.href = "delCard.user?myCard_num="+myCard_num+"&user_num="+user_num+"&mode=D";
	}
}
</script>
<body>
<div class="basicFont">
<h2>카 드</h2>
<br>
<div align="center">
</div>
<c:forEach var="dto" items="${cardList}">
<table>
<c:set var = "i" value = "${i+1 }"/>
	<tr width="500">
		<th width="50%">
			<c:if test="${dto.basic == 'Y'}">
			<input type="text" id = "name${i }" value="${dto.bank_name} [기본카드]" style="border:none;" readOnly>
			</c:if>
			<c:if test="${dto.basic == 'N'}">
			<input type="text" id = "name${i}" value="${dto.bank_name}" style="border:none;  width:400px;" readOnly>
			</c:if>
		</th>
		<th rowspan="2" align="right" width="50%">
			<input type="button" value="이카드로 변경" onclick="changeCard('${i}')" class="btn btn-outline-dark">
		</th>
	</tr>
	<tr>
		<th><input type="text" id="num${i}" value="${dto.card_num}"
		 style="border:none;  width:400px;" readOnly></th>
	</tr>
	<tr>
		<th><input type="text" id = "date${i }" value="${dto.card_date}"
		style="border:none; width:400px;" readOnly></th>
		<td><input type="button" value="삭제" onclick="delCard('${dto.myCard_num}','${dto.user_num}','${dto.basic}')" class="btn btn-outline-dark"></td>
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
