<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	var isName = false;
	var isPhone = false;
	var isAddress = false;
	var isDetailAddress = false;

	function inputFocus(e) {
		if (e.id == 'name') {
			$("#name_hr").css('border', '1px solid');
		} else if (e.id == 'phone') {
			$("#phone_hr").css('border', '1px solid');
		} else if (e.id == 'address3') {
			$("#address3_hr").css('border', '1px solid');
		}
	}

	function inputBlur(e) {
		if (e.id == 'name') {
			$("#name_hr").css('border', '');
		} else if (e.id == 'phone') {
			$("#phone_hr").css('border', '');
		} else if (e.id == 'address3') {
			$("#address3_hr").css('border', '');
		}
	}

	function checkText(e) {
		if (e.id == 'name') {
			e.value = e.value.replace(/[^ㄱ-ㅎ가-힣a-zA-Z]/gi, '')
		} else if (e.id == 'phone') {
			e.value = e.value.replace(/[^0-9]/gi, '')
		}
		if (e.id == 'name' && e.value != '') {
			isName = true;
		}
		if (e.id == 'name' && e.value == '') {
			isName = false;
			$("#save").attr('disabled', true);
		}
		if (e.id == 'phone' && e.value != '') {
			isPhone = true;
		}
		if (e.id == 'phone' && e.value == '') {
			isPhone = false;
			$("#save").attr('disabled', true);
		}
		if (e.id == 'address3' && e.value != '') {
			isDetailAddress = true;
		}
		if (e.id == 'address3' && e.value == '') {
			isDetailAddress = false;
			$("#save").attr('disabled', true);
		}
		if (isName && isPhone && isAddress && isDetailAddress) {
			$("#save").attr('disabled', false);
		}
	}

	function addressFind() {

		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
				// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var roadAddr = data.roadAddress; // 도로명 주소 변수
				var jibunAddr = data.jibunAddress; // 지번 주소 변수
				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('address1').value = data.zonecode;
				if (roadAddr !== '') {
					document.getElementById("address2").value = roadAddr;
					isAddress = true;
				} else if (jibunAddr !== '') {
					document.getElementById("address2").value = jibunAddr;
					isAddress = true;
				}
				if (isName && isPhone && isAddress && isDetailAddress) {
					$("#save").attr('disabled', false);
				}
			}
		}).open();
	}

	function basicAddressCheck(e) {
		var isBasic = e.checked;
		if (isBasic) {
			$("#basic").val('Y');
		} else {
			$("#basic").val('N');
		}
	}

	function cancel() {
		self.close();
	}

	function saveAddress() {
		//alert('첫부분')
		var oncheck = document.getElementById('basicCheckBox').checked;
		var name = document.getElementById('name').value;
		var phone = document.getElementById('phone').value;
		var address1 = document.getElementById('address1').value;
		var address2 = document.getElementById('address2').value;
		var address3 = document.getElementById('address3').value;
		var addr = address1 + address2 + address3;
		if (window.opener.document.getElementById('emptyAddress')) {
			window.opener.document.getElementById('emptyAddress').style.display = "none";
			window.opener.document.getElementById('first_name').style.display = "block";
			window.opener.document.getElementById('first_phone').style.display = "block";
			window.opener.document.getElementById('first_addr').style.display = "block";
			window.opener.document.getElementById('address_chBt_subject').style.display = "block";
			window.opener.document.getElementById('name').value = name;
			window.opener.document.getElementById('phone').value = phone;
			window.opener.document.getElementById('addr').value = addr;
			window.opener.document.getElementById('address1').value = address1;
			window.opener.document.getElementById('address2').value = address2;
			window.opener.document.getElementById('address3').value = address3;
			window.opener.document.getElementById('address_bt_subject').value = "+새 배송지";
			if (window.opener.document.getElementById('payChoice')) {
				window.opener.isAddress = true;
				if (window.opener.document.getElementById('accountPay').style.display != 'none') {
					if (window.opener.isAddress	&& window.opener.document.getElementById('bank_name').value != '') {
						window.opener.document.getElementById('confirm').disabled = false;
					}
				}
				if (window.opener.document.getElementById('cardPay').style.display != 'none') {
					if (window.opener.isAddress && window.opener.document.getElementById('first_bank_name').value != '') {
						window.opener.document.getElementById('confirm').disabled = false;
					}
				}
			}
		}
		if (oncheck) {
			window.opener.document.getElementById('name').value = name;
			window.opener.document.getElementById('phone').value = phone;
			window.opener.document.getElementById('addr').value = addr;
			window.opener.document.getElementById('address1').value = address1;
			window.opener.document.getElementById('address2').value = address2;
			window.opener.document.getElementById('address3').value = address3;
		}
		window.opener.isAddress = true;
		if (window.opener.isAccount && window.opener.isAddress
				&& window.opener.isPrice) {
			window.opener.document.getElementById('confirm').disabled = false;
		}

		if (window.opener.document.getElementById('payChoice')) {
			if (window.opener.document.getElementById('accountPay').style.display != 'none') {
				if (window.opener.isAddress	&& window.opener.document.getElementById('bank_name').value != '') {
					window.opener.document.getElementById('confirm').disabled = false;
				}
			}
			if (window.opener.document.getElementById('cardPay').style.display != 'none') {
				if (window.opener.isAddress && window.opener.document.getElementById('card_name').value != '') {
					window.opener.document.getElementById('confirm').disabled = false;
				}
			}
		}

		document.getElementById('addAddress').submit();
	}
</script>
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
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="basicFont">
	<form id="addAddress" method="post" action="shop_addAddress.user">
		<input type="hidden" name="user_num" value="${sessionUser_num}">
		<input type="hidden" name="prod_num" value="${prod_num }"> <input
			type="hidden" name="mode" value="${mode }">
		<div align="center">
			<h3>새 주소 추가</h3>
		</div>

		<div id="name_subject">
			<b>이름</b>
		</div>
		<input type="text" id="name" name="name" placeholder="수령인 이름을 입력하세요."
			style="border: none; width: 500px;" onfocus="inputFocus(this)"
			onblur="inputBlur(this)" oninput="checkText(this)">
		<hr id="name_hr">

		<br>
		<div id="phone_subject">
			<b>휴대폰 번호</b>
		</div>
		<input type="text" id="phone" name="phone_num"
			placeholder="-을제외하고입력하세요." style="border: none; width: 500px;"
			onfocus="inputFocus(this)" onblur="inputBlur(this)"
			oninput="checkText(this)">
		<hr id="phone_hr">

		<br>
		<div id="address1_subject">
			<b>우편번호</b>
		</div>
		<input type="text" id="address1" name="address1"
			placeholder="우편 번호를 검색하세요." style="border: none; width: 500px;"
			readOnly> <input type="button" value="우편번호" class="btn btn-outline-dark"
			onclick="addressFind()">
		<hr id="address1_hr">

		<br>
		<div id="address2_subject">
			<b>주소</b>
		</div>
		<input type="text" id="address2" name="address2"
			placeholder="우편번호 검색후 자동입력됩니다." style="border: none; width: 500px;"
			readOnly>
		<hr id="address2_hr">

		<br>
		<div id="address3_subject">
			<b>상세 주소</b>
		</div>
		<input type="text" id="address3" name="address3"
			placeholder="건물,아파트,동/호수 입력." style="border: none; width: 500px;"
			onfocus="inputFocus(this)" onblur="inputBlur(this)"
			oninput="checkText(this)">
		<hr id="address3_hr">

		<input type="checkbox" id="basicCheckBox"
			onclick="basicAddressCheck(this)">기본 배송지로 설정 <input
			type="hidden" id="basic" name="basic" value="N">

		<div align="center">
			<input type="button" id="save" value="저장하기" onclick="saveAddress()"
				class="btn btn-outline-dark" disabled> 
				<input type="button" value="취소" onclick="cancel()" class="btn btn-outline-dark">
		</div>
	</form>
</div>
</body>
</html>