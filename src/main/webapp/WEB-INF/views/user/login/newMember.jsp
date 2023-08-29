<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>회원가입</title>
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
        #newMemberForm .invalid-feedback{
            display: none;
        }
        input[type=text]::-ms-clear {
  		display: none;
		}
        .form-control{
        	width:300pt;
        	margin-bottom:5px;
        }
        .size-popup {
			display:none;
			position: fixed;
			top: 0;
			right: 0;
			bottom: 0;
			left: 0;
			background-color: rgba(0, 0, 0, 0.5);
			z-index: 100;
		}
		
		.size-popup.show {
			display: block;
		}
		.agree-popup {
			display: none;
			position: fixed;
			top: 0;
			right: 0;
			bottom: 0;
			left: 0;
			background-color: rgba(0, 0, 0, 0.5);
			z-index: 101;
		}
		.agree-popup.show {
			display: block;
		}
		
		.modal-dialog {
			width: 300px;
			height: 440px;
			margin: 150px auto;
			background-color: #fff;
		}
		
		.modal-content {
			padding:10px 15px;
			text-align: center;
			line-height: 20px;
		}
		.agreemodal-content {
			padding:10px 15px;
			line-height: 20px;
		}
</style>
</head>
<body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<div class="container">
	<script type="text/javascript">
	function agreepopup(){
		$(".agree-popup").addClass("show");
	}
	function setConfirmSize(size){
		 document.getElementById("selectSize").value = size
	 }
	function setParentSize(){
		 document.getElementById("size").value = document.getElementById("selectSize").value
		$(".size-popup").removeClass("show");
	 }
	$(document).ready(function(){            
	    var now = new Date();
	    var year = now.getFullYear();
	    var mon = (now.getMonth() + 1) > 9 ? ''+(now.getMonth() + 1) : '0'+(now.getMonth() + 1); 
	    var day = (now.getDate()) > 9 ? ''+(now.getDate()) : '0'+(now.getDate());           
	    //년도 selectbox만들기               
	    for(var i = 1900 ; i <= year ; i++) {
	        $('#year').append('<option value="' + i + '">' + i + '년</option>');    
	    }

	    // 월별 selectbox 만들기            
	    for(var i=1; i <= 12; i++) {
	        var mm = i > 9 ? i : "0"+i ;            
	        $('#month').append('<option value="' + mm + '">' + mm + '월</option>');    
	    }
	    
	    // 일별 selectbox 만들기
	    for(var i=1; i <= 31; i++) {
	        var dd = i > 9 ? i : "0"+i ;            
	        $('#day').append('<option value="' + dd + '">' + dd+ '일</option>');    
	    }
	    $("#year  > option[value="+year+"]").attr("selected", "true");        
	    $("#month  > option[value="+mon+"]").attr("selected", "true");    
	    $("#day  > option[value="+day+"]").attr("selected", "true");       
	  
	})
	</script>
	<div class="size-popup" id="size-popup">
		<div class="modal-dialog">
			<div class="modal-content">
				<h3 style="color:#585858;">사이즈선택</h3>
				<hr color="Black" style="width:200pt;height:1px;">
				<div id="sizeButton" class="container">
					<c:forEach var="i" begin="220" end="300" step="5">
						<input type="button" class="btn btn-outline-dark" id="${i}" value="${i}" onclick="setConfirmSize('${i}')"/>
					</c:forEach>
				</div>
				<h4 style="color:#585858;">선택된사이즈</h4>
				<div align="center">
					<input style="font-size:18pt; text-align:center; width:100pt; height:50pt;" type="text" id="selectSize" name="selectSize" class="form-control" readonly/><br>
					<button type="button" id="confirm" class="btn btn-outline-dark" onclick="setParentSize()" disabled>확인</button>
				</div>
			</div>
		</div>
	</div>
	<div class="agree-popup" id="agree-popup">
		<div class="modal-dialog">
			<div class="agreemodal-content">
				<h3 style="color:#585858; text-align:center;">이용약관</h3>
				<hr color="Black" style="width:200pt;height:1px;">
				동의보감
			</div>
		</div>
	</div>
	<div align="center"><h2>회 원 가 입</h2></div>
	<form action="newMember.login" method="post" id="newMemberForm">
		<div class="form-group has-danger" align="center">
			<!-- 이메일주소 -->
			<h5>이메일 주소<span style="color=red;">*</span></h5>
			<input class="form-control" type="text" name="email" id="email" placeholder="예) kream@kream.co.kr" oninput="checkEmail()"/>
			<div id="emailErr" class="invalid-feedback">이메일 주소를 정확히 입력해주세요.</div>
			<div id="email-already" class="invalid-feedback">이미 사용 중인 이메일입니다.</div>
			<!-- 비밀번호 -->
			<h5>비밀번호*</h5>
			<input class="form-control" type="password" name="passwd" id="passwd" maxlength="16" placeholder="영문,숫자,특수문자 조합하여 입력해주세요.(8-16자)"/>
			<div id="pwdRegErr" class="invalid-feedback">영문,숫자,특수문자 조합하여 입력해주세요.(8-16자)</div>
			<!-- 프로필이름 -->
			<h5>프로필 이름*</h5>
			<input style="IME-MODE:disabled" class="form-control" type="text" name="profile_name" 
			id="profile_name" oninput="checkProfileName()" maxlength="13" placeholder="영문대소문자, 숫자, '-', (2-13자)"/>
			<div id="profileName-already" class="invalid-feedback">이미 사용 중인 프로필 이름입니다.</div>
			<!-- 이름 -->
			<h5>이름*</h5>
			<input class="form-control" type="text" name="name" id="name" maxlength="20" placeholder="이름을 입력해주세요."/>
			<!-- 소개 -->
			<h5>소개</h5>
			<input class="form-control" type="text" name="info" id="info"/>
			<!-- 신발사이즈 -->
			<h5>신발사이즈</h5>
			<div class="row justify-content-center">
			<input class="form-control" type="text" name="user_size" id="size" style="width:80pt; text-align:center;" readonly/>
			<button type="button" id="sizepop" class="btn btn-open btn-outline-primary" style="margin-bottom:5px;">사이즈선택</button>
			</div>
			<!-- 생년월일 -->
			<h5>생년월일*</h5>
			<select name="yy" id="year"></select>년
			<select name="mm" id="month"></select>월
			<select name="dd" id="day"></select>일
			<!-- 성별 -->
			<h5>성별*</h5>
			<select name="gender" id="gender" onchange="genderOk()" >
				<option value="none">성별을 선택해주세요.</option>
				<option value="M">남</option>
				<option value="F">여</option>
			</select>
			<!-- 휴대폰인증 -->
			<h5>휴대폰인증*</h5>
			<div class="row justify-content-center">
			<input class="form-control" type="text" name="phone_num" id="phone_num" maxlength="11" oninput="this.value=this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');checkPhoneNum()" style="width:205pt;"/>
			<input class="btn btn-outline-primary" type="button" value="인증번호 발송" id="phoneChk" style="margin-bottom:5px; width:95pt" disabled/>
			</div>
			<div id="phoneNum-already" class="invalid-feedback">이미 등록된 휴대폰번호입니다.</div>
			<div class="row justify-content-center">
			<input class="form-control" type="text" name="randNum" id="randNum" maxlength="6" placeholder="인증번호 입력" oninput="this.value=this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" style="width:153pt;" disabled/>
			<input class="btn btn-outline-primary" type="button" value="확인" id="phoneChk2" style="margin-bottom:5px;" disabled/>
			</div>
			<br>
			<!-- 동의 -->
			<input style="zoom:1.4;" type="checkbox" name="agreement" id="agreement">
			[필수]만 14세 이상이며 모두 동의합니다.
			<a href="javascript:agreepopup()"><u>내용보기</u></a>
			<input type="hidden" name="profile_img" value="none"/>
		</div>
		<div align="center">
		<br>
		<!-- 가입하기 -->
		<button style="font-size:18pt; WIDTH:100pt; HEIGHT:40pt" class="btn btn-outline-dark" type="submit" disabled>가입하기</button>
		</div>
	</form>
</div>

<script>
//엔터키방지
$(document).keypress(function(e) { 
  	if (e.keyCode == 13) e.preventDefault(); 
  });
//백스페이스 뒤로가기방지
$("input[readonly]").on("keydown", function(event){
    if(event.keyCode == 8){
        event.preventDefault();
    }
});
$("select").on("keydown", function(event){
	if(event.keyCode == 8){
		event.preventDefault();
	}
});
var emailChkOk = false;
var profileNameChkOk = false;
var phoneChkOk = false;
var genderChkOk = false;
var agreeChkOk= false;
var phoneDupChkOk = false;
var sendCode = true;
var regE=/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
var regP=/^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
var regPn=/^[a-zA-Z0-9_-]{2,14}$/;
var regN=/^[가-힣a-zA-Z]+$/;

function genderOk(){
if($("#gender option:selected").val()=="none"){
		genderChkOk=false;
		checkAll();
	}else{
		genderChkOk=true;
		checkAll();
	}
};


function checkEmail(){
    var email = $('#email').val(); //email값이 "email"인 입력란의 값을 저장
    $.ajax({
        url:'./emailCheck', //Controller에서 요청 받을 주소
        type:'post', //POST 방식으로 전달
        data:{email:email},
        cache:false,
        success:function(cnt){//컨트롤러에서 넘어온 cnt값을 받는다 
            if(cnt == 0){ //cnt가 1이 아니면(=0일 경우) -> 사용 가능한 이메일
                $("#email-already").hide();
            	emailChkOk = true;
            	checkAll();
            } else { // cnt가 1일 경우 -> 이미 존재하는 이메일
                $("#email-already").show();
            	emailChkOk = false;
            	checkAll();
            }
        },
        error:function(){
        	alert("에러");
        }
    });
};

function checkPhoneNum(){
	var phone = $("#phone_num").val();
	$.ajax({
		url:'./checkPhoneNum',
		type:'post',
		data:{phoneNum:phone},
		cache:false,
		success:function(cnt3){
			if(cnt3 == 0){
				phoneDupChkOk = true;
				$("#phoneNum-already").hide();
			}else{
				phoneDupChkOk = false;
				$("#phoneNum-already").show();
			}
		},
		error:function(){
			alert("에러");
		}
	});
};

function checkProfileName(){
	var profileName = $('#profile_name').val();
	$.ajax({
		url:'./checkProfileName',
		type:'post',
		data:{profile_name:profileName},
		cache:false,
		success:function(cnt2){
			if(cnt2 == 0){
				$("#profileName-already").hide();
				profileNameChkOk = true;
				checkAll();
			}else{
				$("#profileName-already").show();
				profileNameChkOk = false;
				checkAll();
			}
		},
		error:function(){
			alert("에러");
		}
	});
};
$(function(){
//휴대폰 번호 인증var code2 = "";
	$("#phoneChk").click(function(){
		var phone = $("#phone_num").val();
		$.ajax({
			type:"post",
			url:"./sendSMS",
			data:{phone_num:phone},
			cache:false,
			success:function(data){
				if(data=="error"){
					alert("휴대폰 번호가 올바르지 않습니다.")	//이거 안됨 모르겠음
				}else{
					alert("휴대폰 번호로 인증번호가 전송되었습니다. 인증번호를 입력해주세요.")
					$("#randNum").attr("disabled",false);
					$("#phone_num").attr("readonly",true);
					$("#phoneChk").attr("disabled",true);
					$("#phoneChk").val('전송완료');
					sendCode = false;
					code2 = data;
				}
			}
			
		});
	});
	$("#phoneChk2").click(function(){
		if($("#randNum").val()==code2){
			alert("인증성공")
			$("#phone_num").attr("readonly",true);
			$("#phoneChk").attr("disabled",true);
			$("#phoneChk").val('인증완료');
			$("#randNum").hide();
			$("#phoneChk2").hide();
			phoneChkOk = true;
			sendCode = false;
			checkAll();
		}else{
			alert("인증실패")
		}
	});
	$("#agreement").click(function(){
		var agree=$('#agreement').is(':checked');
		if(agree){
			agreeChkOk = true;
			checkAll();
		}else{
			agreeChkOk = false;
			checkAll();
		}
	});
	$("#phone_num").keyup(function(){
		var phoneNum=$("#phone_num").val();
		var reg=/^[0-9]{11,11}$/;
		if(reg.test(phoneNum) && phoneDupChkOk && sendCode){
			$("#phoneChk").attr("disabled",false)
		}else{
			$("#phoneChk").attr("disabled",true)
		}
	});
	$("#randNum").keyup(function(){
		var randomNum=$("#randNum").val();
		var reg=/^[0-9]{6,6}$/;
		if(reg.test(randomNum)){
			$("#phoneChk2").attr("disabled",false)
		}else{
			$("#phoneChk2").attr("disabled",true)
		}
	});
});
$("#newMemberForm input").keyup(function(){
	var email=$('#email').val();
	if(email.trim()!=""){
		if(regE.test(email)){
			$("#emailErr").hide();
			$("#email").removeClass("is-invalid")
		}else{
			$("#emailErr").show();
			$("#email").addClass("is-invalid")
		}
	}
	var pwd=$("#passwd").val();
	if(pwd.trim()!=""){
		if(regP.test(pwd)){
		     $("#pwdRegErr").hide();
		     $("#passwd").removeClass("is-invalid")
		}else{
			 $("#pwdRegErr").show();
			 $("#passwd").addClass("is-invalid")
		}
	}
	checkAll();
}); 
function checkAll(){
	var email=$('#email').val();
	var pwd=$('#passwd').val();
	var profileName = $('#profile_name').val();
	var name=$('#name').val();
	if(regE.test(email) && regP.test(pwd) && regPn.test(profileName) 
		&& regN.test(name) && emailChkOk && profileNameChkOk && phoneChkOk && genderChkOk && agreeChkOk){
		$("#newMemberForm button[type=submit]").attr("disabled",false)
	}else{
		$("#newMemberForm button[type=submit]").attr("disabled",true)
	}
};
//팝업 열기
$(document).on("click", ".btn-open", function (e){
	$("#size-popup").addClass("show");
});

// 외부영역 클릭 시 팝업 닫기
$(document).mouseup(function (e){
	var sizePopup = $(".size-popup");
	if(sizePopup.has(e.target).length === 0){
		sizePopup.removeClass("show");
	}
});
$(document).mouseup(function (g){
	var agreePopup = $(".agree-popup");
	if(agreePopup.has(g.target).length === 0){
		agreePopup.removeClass("show");
	}
});

$("#sizeButton").click(function(){
	$("#confirm")
		.attr("disabled",false)
});
</script>
</body>
</html>
<%@include file="../../bottom.jsp" %>















