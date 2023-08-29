<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="resources/css/bootstrap.min.css" type="text/css">
<script type="text/javascript">
var isName = false;
var isPhone = false;
var isAddress = false;
var isDetailAddress = false;

	function inputFocus(e){
		if(e.id == 'name'){
			$("#name_hr").css('border','1px solid');
		}else if(e.id == 'phone'){
			$("#phone_hr").css('border','1px solid');
		}else if(e.id =='address3'){
			$("#address3_hr").css('border','1px solid');
		}
	}
	
	function inputBlur(e){
		if(e.id == 'name'){
			$("#name_hr").css('border','');
		}else if(e.id == 'phone'){
			$("#phone_hr").css('border','');
		}else if(e.id =='address3'){
			$("#address3_hr").css('border','');
		}
	}
	
	function checkText(e){
		if(e.id == 'name'){
			e.value = e.value.replace(/[^ㄱ-ㅎ가-힣a-zA-Z]/gi, '')
		}else if(e.id == 'phone'){
			e.value = e.value.replace(/[^0-9]/gi, '')
		}
		if(e.id == 'name' && e.value != ''){
			isName = true;
		}
		if(e.id == 'name' && e.value == ''){
			isName = false;
			$("#save").attr('disabled',true);
		}
		if(e.id == 'phone' && e.value != ''){
			isPhone = true;			
		}
		if(e.id == 'phone' && e.value == ''){
			isPhone = false;		
			$("#save").attr('disabled',true);
		}
		if(e.id == 'address3' && e.value != ''){
			isDetailAddress = true;
		}
		if(e.id == 'address3' && e.value == ''){
			isDetailAddress = false;
			$("#save").attr('disabled',true);
		}
		if(isName && isPhone && isAddress && isDetailAddress){
			$("#save").attr('disabled',false);
		}
	}
	
	function addressFind(){
		
		new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var roadAddr = data.roadAddress; // 도로명 주소 변수
	            var jibunAddr = data.jibunAddress; // 지번 주소 변수
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('address1').value = data.zonecode;
	            if(roadAddr !== ''){
	                document.getElementById("address2").value = roadAddr;
	                isAddress = true;
	            }else if(jibunAddr !== ''){
	                document.getElementById("address2").value = jibunAddr;
	                isAddress = true;
	            }
	            if(isName && isPhone && isAddress && isDetailAddress){
	    			$("#save").attr('disabled',false);
	    		}
	        }
	    }).open();
	}
	
	function basicAddressCheck(e){
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
	
	function saveAddress(){
		document.getElementById('addAddress').submit();
	}
</script>
<body>
<div class="basicFont">
<form id="addAddress" method="post" action="addAddress.user">
	<input type="hidden" name="user_num" value="${sessionUser_num}">
	
	<div align="center">
		<h3>새 주소 추가</h3>
	</div>
	
	<div id="name_subject"><b>이름</b></div>
	<input type="text" id="name" name="name" placeholder="수령인 이름을 입력하세요." style="border:none; width:500px;"
		onfocus="inputFocus(this)" onblur="inputBlur(this)" oninput="checkText(this)">
	<hr id="name_hr">
	
	<br>
	<div id="phone_subject"><b>휴대폰 번호</b></div>
	<input type="text" id="phone" name="phone_num" placeholder="-을제외하고입력하세요." style="border:none; width:500px;"
		onfocus="inputFocus(this)" onblur="inputBlur(this)" oninput="checkText(this)">
	<hr id="phone_hr">
	
	<br>
	<div id="address1_subject"><b>우편번호</b></div>
	<input type="text" id="address1" name="address1" placeholder="우편 번호를 검색하세요." style="border:none; width:500px;"
		readOnly>
	<input type="button" value="우편번호" onclick="addressFind()" class="btn btn-outline-dark">	
	<hr id="address1_hr">
	
	<br>
	<div id="address2_subject"><b>주소</b></div>
	<input type="text" id="address2" name="address2" placeholder="우편번호 검색후 자동입력됩니다." style="border:none; width:500px;"
		readOnly>
	<hr id="address2_hr">
	
	<br>
	<div id="address3_subject"><b>상세 주소</b></div>
	<input type="text" id="address3" name="address3" placeholder="건물,아파트,동/호수 입력." style="border:none; width:500px;"
		onfocus="inputFocus(this)" onblur="inputBlur(this)" oninput="checkText(this)">
	<hr id="address3_hr">
	
	<input type="checkbox" id="basicCheckBox" onclick="basicAddressCheck(this)">기본 배송지로 설정
	<input type="hidden" id="basic" name="basic" value="N">
	
	<div align="center">
		<input type="button" id="save" value="저장하기" onclick="saveAddress()" disabled class="btn btn-outline-dark">
		<input type="button" value="취소" onclick="cancel()" class="btn btn-outline-dark">
	</div>
</form>
</div>
</body>
</html>