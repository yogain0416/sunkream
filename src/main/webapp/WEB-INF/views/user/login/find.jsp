<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디/비밀번호찾기</title>
	<link rel="stylesheet" href="resources/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="resources/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="resources/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="resources/css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="resources/css/magnific-popup.css" type="text/css">
    <link rel="stylesheet" href="resources/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="resources/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="resources/css/style.css" type="text/css">
<style>
        /* .help-block 을 일단 보이지 않게 설정 */
        
        #findPwForm .invalid-feedback{
        	display: none;
        }
        input[type=text]::-ms-clear {
  		display: none;
		}
		button[type=submit]{
		width:300pt;
		height:40pt;
		}
		.form-control{
		width:500pt;
		margin-bottom:20px;
		}
    </style>
</head>
<body>
<div id="findForm" class="container" align="center">
<h3>${title}</h3>
<hr color="Black" style="width:500pt;height:2px;">
<c:if test="${mode eq 'id'}">
	<form action="findId.login" method="post" id="findIdForm">
		<h5>휴대폰 번호</h5>
		<input class="form-control" type="text" name="phoneNum" id="phoneNum" placeholder="가입하신 휴대폰 번호" maxlength="11" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>
		<button style="margin-top:20px;" class="btn btn-outline-dark" type="submit" disabled>${title}</button>
	</form>
</c:if>
<c:if test="${mode eq 'pw'}">
	<form action="findPw.login" method="post" id="findPwForm">
		<h5>휴대폰 번호</h5>
		<input class="form-control" type="text" name="phoneNum" id="phoneNum" placeholder="가입하신 휴대폰 번호" maxlength="11" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>
		<h5>이메일 주소</h5>
		<div class="form-group has-danger">
		<input class="form-control" type="text" name="email" id="email" placeholder="예) kream@kream.co.kr">
		<div id="emailErr" class="invalid-feedback">올바른 이메일 형식이 아닙니다.</div>
		</div>
		<button style="margin-top:20px;" class="btn btn-outline-dark" type="submit" disabled>문자 발송하기</button>
	</form>
</c:if>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script>
$(document).keypress(function(e) { 
  	if (e.keyCode == 13) e.preventDefault(); 
  });
$("#findIdForm input").keyup(function(){
	var phoneNum=$("#phoneNum").val();
	var reg=/^[0-9]{11,11}$/;
	if(reg.test(phoneNum)){
		$("#findIdForm button[type=submit]")
		.attr("disabled",false)
	}else{
		$("#findIdForm button[type=submit]")
		.attr("disabled",true)
	}
});

$("#findPwForm input").keyup(function(){
	var phoneNum=$("#phoneNum").val();
	var reg=/^[0-9]{11,11}$/;

	var email=$("#email").val();
	var reg2=/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	
	if(email.trim()!=""){
	 if(reg2.test(email)){//정규표현식을 통과 한다면
                $("#emailErr").hide();
                successState("#email");
    	}else{//정규표현식을 통과하지 못하면
                $("#emailErr").show();
                errorState("#email");
    	}
    }
	if(reg.test(phoneNum)&&reg2.test(email)){
		$("#findPwForm button[type=submit]")
				.attr("disabled",false)
	}else{
		$("#findPwForm button[type=submit]")
				.attr("disabled",true)
	}

});

function successState(sel){
        $(sel)
        .removeClass("is-invalid")
        
    };

function errorState(sel){
        $(sel)
        .addClass("is-invalid")
        
    };
</script>
</body>
</html>
<%@include file="../../bottom.jsp" %>