<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
<script type="text/javascript">
var isName = false;
var isCard = false;
var isCardDate1 = false;
var isCardDate2 = false;

	function inputFocus(e){
		if(e.id == 'name'){
			$("#name_hr").css('border','1px solid');
		}else if(e.id == 'card'){
			$("#card_hr").css('border','1px solid');
		}else if(e.id =='cardDate1'){
			$("#cardDate1_hr").css('border','1px solid');
		}else if(e.id =='cardDate2'){
			$("#cardDate2_hr").css('border','1px solid');
		}
	}
	
	function inputBlur(e){
		if(e.id == 'name'){
			$("#name_hr").css('border','');
		}else if(e.id == 'card'){
			$("#card_hr").css('border','');
		}else if(e.id =='cardDate1'){
			$("#cardDate1_hr").css('border','');
		}else if(e.id =='cardDate2'){
			$("#cardDate2_hr").css('border','');
		}
	}
	function checkCardDate(e){
		if(e.id == 'cardDate1'){
			if(e.value.length == 2 && (e.value != '10' && e.value != '11' && e.value != '12')){
				e.value = ''
			}
			if(e.value.length == 1){
				e.value = '0'+e.value
			}
			isCardDate1 = true;
		}else if(e.id == 'cardDate2'){
			if(e.value.length == 1){
				e.value = '0'+e.value
			}
			isCardDate2 = true;
		}	
	}
	function checkText(e){
		if(e.id == 'name'){
			e.value = e.value.replace(/[^ㄱ-ㅎ가-힣a-zA-Z]/gi, '')
		}else if(e.id == 'card'){
			e.value = e.value.replace(/[^0-9]/gi, '')
		}else if(e.id == 'cardDate1'){
			e.value = e.value.replace(/[^0-9]/gi, '')
		}else if(e.id == 'cardDate2'){
			e.value = e.value.replace(/[^0-9]/gi, '')
		}
		if(e.id == 'name' && e.value != ''){
			isName = true;
		}
		if(e.id == 'name' && e.value == ''){
			isName = false;
			$("#save").attr('disabled',true);
		}
		if(e.id == 'card' && e.value != ''){
			isCard = true;			
		}
		if(e.id == 'card' && e.value == ''){
			isCard = false;		
			$("#save").attr('disabled',true);
		}
		if(e.id == 'cardDate1' && e.value != ''){
			isCardDate1 = true;			
		}
		if(e.id == 'cardDate1' && e.value == ''){
			isCardDate1 = false;		
			$("#save").attr('disabled',true);
		}
		if(e.id == 'cardDate2' && e.value != ''){
			isCardDate2 = true;			
		}
		if(e.id == 'cardDate2' && e.value == ''){
			isCardDate2 = false;		
			$("#save").attr('disabled',true);
		}
		if(isName && isCard && isCardDate1 && isCardDate2){
			$("#save").attr('disabled',false);
		}
	}
	
	function basicCardCheck(e){
		var isBasic = e.checked;
		if(isBasic){
			$("#basic").val('Y');
		}else{
			$("#basic").val('N');
		}
	}
	
	function cancel(){
		self.close();
	}
	
	function saveCard(){
		document.getElementById('card_date').value 
			= document.getElementById('cardDate1').value+'/'+document.getElementById('cardDate2').value
		if(window.opener.document.getElementById('emptyCard')){
			window.opener.document.getElementById('emptyCard').style.display = 'none';
			var first_bank_name = document.getElementById('name').value;
			var first_card_num = document.getElementById('card').value;
			var first_card_date = document.getElementById('card_date').value;
			window.opener.document.getElementById('first_bank').style.display = "block";
			window.opener.document.getElementById('first_num').style.display = "block";
			window.opener.document.getElementById('first_date').style.display = "block";
			window.opener.document.getElementById('first_bank_name').value = first_bank_name;
			window.opener.document.getElementById('first_card_num').value = first_card_num;
			window.opener.document.getElementById('first_card_date').value = first_card_date;
			window.opener.document.getElementById('firstCardBt').style.display = "block";
			if(window.opener.isAddress){
		  		window.opener.document.getElementById('confirm').disabled = false;  
		  	 }
		}	
		 document.getElementById('addCard').submit(); 
	}
</script>
<body>
<div class="basicFont">
<form id="addCard" method="post" action="shop_addCard.user">
	<input type="hidden" name="user_num" value="${sessionUser_num}">
	<div align="center">
		<h3>새 카드 추가</h3>
	</div>
	
	<div id="name_subject"><b>은행 이름</b></div>
	<input type="text" id="name" name="bank_name" placeholder="은행 이름을 입력하시오." style="border:none; width:500px;"
		onfocus="inputFocus(this)" onblur="inputBlur(this)" oninput="checkText(this)">
	<hr id="name_hr">
	
	<br>
	<div id="card_subject"><b>카드 번호</b></div>
	<input type="text" id="card" name="card_num" placeholder="-을제외하고입력하세요." style="border:none; width:500px;"
		onfocus="inputFocus(this)" onblur="inputBlur(this)" oninput="checkText(this)">
	<hr id="card_hr">
	
	<br>
	<div id="cardDate_subject"><b>카드 날짜</b></div>
	<input type="text" id="cardDate1" name="cardDate1" placeholder="달력을 입력해주세요.(MM)" 
		style="border:none; width:500px;" onfocus="inputFocus(this)" onblur="inputBlur(this)"
		onchange="checkCardDate(this)" oninput="checkText(this)" maxlength="2">
	<hr id="cardDate1_hr">
	<input type="text" id="cardDate2" name="cardDate2" placeholder="년도를 입력해주세요.(YY)" 
		style="border:none; width:500px;" onfocus="inputFocus(this)" onblur="inputBlur(this)"
		onchange="checkCardDate(this)" oninput="checkText(this)" maxlength="2">
	<hr id="cardDate2_hr">
	
	<input type="hidden" id="card_date" name="card_date">
	
	<input type="checkbox" id="basicCheckBox" onclick="basicCardCheck(this)">기본 카드로 설정
	<input type="hidden" id="basic" name="basic" value="N">
	
	<div align="center">
		<input type="button" id="save" value="저장하기" onclick="saveCard()" 
		 class="btn btn-outline-dark" disabled>
		<input type="button" value="취소" onclick="cancel()" class="btn btn-outline-dark">
	</div>
</form>
</div>
</body>
</html>