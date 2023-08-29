<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Account</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
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
<link rel="stylesheet" href="resources/css/bootstrap.min.css"
   type="text/css">
<script type="text/javascript">
var isName = false;
var isNum = false;
var isOwner = false;

	function inputFocus(e){
		if(e.id == 'name'){
			$("#name_hr").css('border','1px solid');
		}else if(e.id == 'num'){
			$("#num_hr").css('border','1px solid');
		}else if(e.id =='owner'){
			$("#owner_hr").css('border','1px solid');
		}
	}
	
	function inputBlur(e){
		if(e.id == 'name'){
			$("#name_hr").css('border','');
		}else if(e.id == 'num'){
			$("#num_hr").css('border','');
		}else if(e.id =='owner'){
			$("#owner_hr").css('border','');
		}
	}
	
	function checkText(e){
		if(e.id == 'name'){
			e.value = e.value.replace(/[^ㄱ-ㅎ가-힣a-zA-Z]/gi, '')
		}else if(e.id == 'num'){
			e.value = e.value.replace(/[^0-9]/gi, '')
		}else if(e.id == 'owner'){
			e.value = e.value.replace(/[^ㄱ-ㅎ가-힣a-zA-Z]/gi, '')
		}
		
		if(e.id == 'name' && e.value != ''){
			isName = true;
		}
		if(e.id == 'name' && e.value == ''){
			isName = false;
			$("#save").attr('disabled',true);
			$("#edit").attr('disabled',true);
		}
		if(e.id == 'num' && e.value != ''){
			isNum = true;			
		}
		if(e.id == 'num' && e.value == ''){
			isNum = false;		
			$("#save").attr('disabled',true);
			$("#edit").attr('disabled',true);
		}
		if(e.id == 'owner' && e.value != ''){
			isOwner = true;			
		}
		if(e.id == 'owner' && e.value == ''){
			isOwner = false;		
			$("#save").attr('disabled',true);
			$("#edit").attr('disabled',true);
		}
		if(isName && isNum && isOwner){
			$("#save").attr('disabled',false);
			$("#edit").attr('disabled',false);
		}
	}	
	
	function saveAccount(){
		document.getElementById('saveAccount').submit();
		if(window.opener.document.getElementById('emptyAccount')){
			window.opener.document.getElementById('emptyAccount').style.display = "none";
			window.opener.document.getElementById('bank_name_subject').style.display = "block";
			window.opener.document.getElementById('account_num_subject').style.display = "block";
			window.opener.document.getElementById('account_owner_subject').style.display = "block";
			window.opener.document.getElementById('account_bt_subject').value ="정산계좌변경";
		}
		window.opener.document.getElementById('bank_name').value = document.getElementById('name').value;
		window.opener.document.getElementById('account_num').value = document.getElementById('num').value;
		window.opener.document.getElementById('account_owner').value = document.getElementById('owner').value;
		window.opener.isAccount = true;
		if(window.opener.isAccount && window.opener.isAddress && window.opener.isPrice){
	  		window.opener.getElementById('confirm').disabled = false;  
	  	  }
		if (window.opener.document.getElementById('accountPay')){
	         if(window.opener.isAccount && window.opener.isAddress){
	              window.opener.document.getElementById('confirm').disabled = false;  
	             }
	      }
	}
	function editAccount(){
		document.getElementById('editAccount').submit();
		window.opener.document.getElementById('bank_name').value = document.getElementById('name').value;
		window.opener.document.getElementById('account_num').value = document.getElementById('num').value;
		window.opener.document.getElementById('account_owner').value = document.getElementById('owner').value;
		window.opener.isAccount = true;
		if(window.opener.isAccount && window.opener.isAddress && window.opener.isPrice){
	  		window.opener.getElementById('confirm').disabled = false;  
	  	  }
	}
</script>
<body>
<div class="basicFont">
<c:if test="${empty accountDTO}">
	<h2>정 산 계 좌 추 가</h2>
</c:if>
<c:if test="${not empty accountDTO}">
	<h2>정 산 계 좌 변 경</h2>
	<table>
		<tr>
			<th>등록된 계좌 정보</th>
		</tr>
		<tr>
			<td><div style="font-size:25px">${accountDTO.bank_name} ${accountDTO.account_num}/${accountDTO.account_owner}</div></td>
		</tr>	
	</table>
</c:if>
<div align="right">
</div>
	<c:if test="${empty accountDTO}">
	<form id="saveAccount" method="post" action="addAccount.user">
	</c:if>
	<c:if test="${not empty accountDTO}">
	<form id="editAccount" method="post" action="editAccount.user">
	</c:if>
	<input type="hidden" name="user_num" value="${sessionUser_num}">
	<input type="hidden" name="mode" value="sell">
	<br>
	<div id="name_subject"><b>은행명</b></div>
	<input type="text" id="name" name="bank_name" placeholder="은행명을 입력하세요." style="border:none; width:500px;"
		onfocus="inputFocus(this)" onblur="inputBlur(this)" oninput="checkText(this)">
	<hr id="name_hr">

	<br>
	<div id="num_subject"><b>계좌 번호</b></div>
	<input type="text" id="num" name="account_num" placeholder="-을제외하고입력하세요." style="border:none; width:500px;"
		onfocus="inputFocus(this)" onblur="inputBlur(this)" oninput="checkText(this)">
	<hr id="num_hr">
	
	<br>
	<div id="owner_subject"><b>예금주</b></div>
	<input type="text" id="owner" name="account_owner" placeholder="예금주명을 정확히입력해주세요." style="border:none; width:500px;"
		onfocus="inputFocus(this)" onblur="inputBlur(this)" oninput="checkText(this)">
	<hr id="owner_hr">
	
	<br>
	<div align="center">
		<c:if test="${empty accountDTO}">
			<input type="button" id="save" value="저장하기" onclick="saveAccount()" disabled class="btn btn-outline-dark">
		</c:if>
		<c:if test="${not empty accountDTO}">
			<input type="button" id="edit" value="변경하기" onclick="editAccount()" disabled class="btn btn-outline-dark">
		</c:if>
		<input type="button" value="취소" onclick="self.close()" class="btn btn-outline-dark">
	</div>
	</form>
</div>
</body>
</html>
