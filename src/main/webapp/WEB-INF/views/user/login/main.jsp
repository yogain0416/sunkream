<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../../top.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>whippingkream</title>
<link rel="stylesheet" href="resources/css/bootstrap.min.css"
	type="text/css">
<link rel="stylesheet" href="resources/css/font-awesome.min.css"
	type="text/css">
<link rel="stylesheet" href="resources/css/elegant-icons.css"
	type="text/css">
<link rel="stylesheet" href="resources/css/jquery-ui.min.css"
	type="text/css">
<link rel="stylesheet" href="resources/css/magnific-popup.css"
	type="text/css">
<link rel="stylesheet" href="resources/css/owl.carousel.min.css"
	type="text/css">
<link rel="stylesheet" href="resources/css/slicknav.min.css"
	type="text/css">
<link rel="stylesheet" href="resources/css/style.css" type="text/css">
<link href="https://getbootstrap.com/docs/5.0/components/buttons/">
<style>
/* .help-block 을 일단 보이지 않게 설정 */
#myForm .invalid-feedback {
	display: none;
}

input[type=text]::-ms-clear {
	display: none;
}

.bottom_container {
	width: auto;
}

.container {
	width: 700px;
	margin: 0 auto;
	background-color: #fff;
	border: 1px solid #000;
	text-align: center;
	border-style: none;
}

.container div {
	margin: 0 auto;
	/* text-align: center; */
}

.main_login button {
	width: 400px;
}

.naver_id_login img {
	width: 250px;
}

.kakao_id_login img {
	width: 250px;
}

.form-control {
	width: 400px;
	margin: 0 auto;
	text-align: center;
	align-items: center;
}
</style>
</head>
<body>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<div class="container">
		<form action="loginCheck.login" method="post" id="myForm">
			<div class="form-group has-danger">
				<div class="">
					<h5>이메일</h5>
					<input class="form-control" type="text" name="email" id="email"
						placeholder="예) kream@kream.co.kr" />
					<div id="emailErr" class="invalid-feedback">올바른 이메일 형식이 아닙니다.</div>
				</div>
			</div>
			<div class="">
				<div class="form-group has-danger">
					<h5>비밀번호</h5>
					<input class="form-control" type="password" name="passwd"
						id="passwd" />
					<p id="pwdRegErr" class="invalid-feedback">영문,숫자,특수문자 조합해서
						입력해주세요.(8-16자)</p>
				</div>
			</div>
			<br>
			<div class="main_login">
				<button class="btn btn-outline-primary" id="loginButton" type="submit" disabled>로그인</button>
				<br>
			</div>
			<br>

		</form>
		<div class="">
			<input type="button" class="btn btn-outline-info"
				onclick="location='newMember.login'" value="이메일 가입" /> <input
				type="button" class="btn btn-outline-info"
				onclick="location='findId.login'" value="이메일 찾기" /> <input
				type="button" class="btn btn-outline-info"
				onclick="location='findPw.login'" value="비밀번호 찾기" /> <br>
		</div>
		<br> <br>
		<div class="naver_id_login">
			<a href="javascript:naverLoginpopup('${naverUrl}')"> <img
				src="resources/img/naverBtn.png" alt="네이버">
			</a>
		</div>
		<br>
		<div class="kakao_id_login">
			<a href="javascript:kakaoLoginpopup('${kakaoUrl}')"> <img
				src="resources/img/kakaoBtn.png" alt="카카오">
			</a>
		</div>
	</div>
	<br>
<br>
<br>
<br>
<br>
<br>
<br>
</body>
<script type="text/javascript">
	function naverLoginpopup(url) {
		window.open(url, "", "width=700, height=800")
	}
	function kakaoLoginpopup(url) {
		window.open(url, "", "width=700, height=800")
	}
</script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script>
	// 페이지 전체 엔터 키 막기
	$(document).keypress(function(e) {
		if (e.keyCode == 13)
			e.preventDefault();
	});
	$("#myForm input")
			.keyup(
					function() {
						var email = $("#email").val();
						var reg = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
						if (email.trim() != "") {
							if (reg.test(email)) {//정규표현식을 통과 한다면
								$("#emailErr").hide();
								successState("#email");
							} else {//정규표현식을 통과하지 못하면
								$("#emailErr").show();
								errorState("#email");
							}
						}
						var pwd = $("#passwd").val();
						// 비밀번호 검증할 정규 표현식
						var reg2 = /^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
						if (pwd.trim() != "") {
							if (reg2.test(pwd)) {//정규표현식을 통과 한다면
								$("#pwdRegErr").hide();
								successState("#passwd");
							} else {//정규표현식을 통과하지 못하면
								$("#pwdRegErr").show();
								errorState("#passwd");
							}
						}
						if (reg.test(email) && reg2.test(pwd)) {
							$("#myForm button[type=submit]").attr("disabled",false)
							
							var btPass = document.getElementById('passwd');
							btPass.addEventListener("keypress", function(event) {
								if (event.keyCode == 13) {
									document.getElementById('loginButton').click();
								}
							});
							var btId = document.getElementById('email');
							btId.addEventListener("keypress", function(event) {
								if (event.keyCode == 13) {
									document.getElementById('loginButton').click();
								}
							});
						} else {
							$("#myForm button[type=submit]").attr("disabled",true)
						}

					});

	function successState(sel) {
		$(sel).removeClass("is-invalid")

	};
	// 에러 상태로 바꾸는 함수
	function errorState(sel) {
		$(sel).addClass("is-invalid")

	};
</script>
</html>
<%@include file="../../bottom.jsp"%>