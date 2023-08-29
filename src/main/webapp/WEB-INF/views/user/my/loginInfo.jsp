<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="top.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LoginInfo</title>
</head>
<style>
	.invalid-feedback{
    	display: none;
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
</style>
<script type="text/javascript">
	var regP = /^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
	var isCheckEx = false;
	var isCheckNew = false;
	
	function checkPasswd(e){
		var passwd_name = e.id;
		var passwd = e.value;
		if(passwd.trim() != ""){
			if(regP.test(passwd)){
				if(passwd_name == 'ex_passwd'){
					$("#ex_warning").hide();
					isCheckEx = true;
					if(isCheckEx && isCheckNew) $("#passwd_save").attr("disabled", false);
					else $("#passwd_save").attr("disabled", true);
				}
				else{
					isCheckNew = true;
					$("#new_warning").hide();
					if(isCheckEx && isCheckNew) $("#passwd_save").attr("disabled", false);
					else $("#passwd_save").attr("disabled", true);
				}
			}else{
				$("#passwd_save").attr("disabled", true);
				if(passwd_name == 'ex_passwd'){
					$("#ex_warning").show();
					isCheckEx = false;
				}else{
					$("#new_warning").show();
					isCheckNew = false;
				}
			}
		}else{
			$("#passwd_save").attr("disabled", true);
			if(passwd_name == 'ex_passwd'){
				$("#ex_warning").hide();
				isCheckEx = false;
			}else{
				$("#new_warning").hide();
				isCheckNew = false;
			}
		}
	}
	
	function passwdEdit(){
		//비밀번호 숨기기
		$("#passwd").hide();
		//비밀번호 변경버튼 숨기기
		$("#passwdEdit").hide();
		//비밀번호 아래 줄 숨기기
		$("#passwd_hr").hide();
		
		var subject = document.getElementById('passwd_subject');
		subject.value = '비밀번호 변경';
		subject.style.fontWeight = 'bold';
		
		var ex_subject = '<br><h6><b>'+"이전 비밀번호"+'</b></h6>';
		var new_subject = '<h6><b>'+"새 비밀번호"+'</b></h6>';
		var ex_passwd = document.createElement('input');
		var new_passwd = document.createElement('input');
		var ex_hr = '<hr id="ex_hr" style="text-align:left;margin-left:0; width:380px;">'
		var new_hr = '<hr id="new_hr" style="text-align:left;margin-left:0; width:380px;">'
		var ex_warning = '<div id="ex_warning" class="invalid-feedback">'+"영문,숫자,특수문자 조합하여 입력해주세요.(8-16자)"+'</div>'
		var new_warning = '<div id="new_warning" class="invalid-feedback">'+"영문,숫자,특수문자 조합하여 입력해주세요.(8-16자)"+'</div>'
		ex_passwd.type = 'password';
		ex_passwd.id = 'ex_passwd';
		ex_passwd.style.border = 'none';
		ex_passwd.style.width = "400px";
		ex_passwd.maxlength = '16';
		ex_passwd.className = 'btn btn-outline-dark';
		ex_passwd.placeholder = '영문,숫자,특수문자 조합하여 입력해주세요.(8-16자)';
		ex_passwd.oninput = function(){
			var e = document.getElementById('ex_passwd')
			checkPasswd(e);
		}
		ex_passwd.onfocus = function(){
			$("#ex_hr").css("border","1px solid");
		}
		ex_passwd.onblur = function(){
			$("#ex_hr").css("border","");
		}
		ex_passwd.onkeypress = function(e){
			if(e.keyCode == 13){
				save.click()
			}
		}
		new_passwd.type = 'password';
		new_passwd.id = 'new_passwd';
		new_passwd.style.border = 'none';
		new_passwd.style.width = "400px";
		new_passwd.maxlength = '16';
		new_passwd.className = 'btn btn-outline-dark';
		new_passwd.placeholder = '영문,숫자,특수문자 조합하여 입력해주세요.(8-16자)';
		new_passwd.oninput = function(){
			var e = document.getElementById('new_passwd')
			checkPasswd(e);
		}
		new_passwd.onfocus = function(){
			$("#new_hr").css("border","1px solid");
		}
		new_passwd.onblur = function(){
			$("#new_hr").css("border","");
		}
		new_passwd.onkeypress = function(e){
			if(e.keyCode == 13){
				save.click()
			}
		}
		
		$("#passwdDiv").append(ex_subject);
		$("#passwdDiv").append(ex_passwd);
		$("#passwdDiv").append(ex_hr);
		$("#passwdDiv").append(ex_warning);
		$("#passwdDiv").append(new_subject);
		$("#passwdDiv").append(new_passwd);
		$("#passwdDiv").append(new_hr);
		$("#passwdDiv").append(new_warning);
		var div = document.getElementById('passwdDiv');
		var subDiv = document.createElement('div');
		subDiv.id = 'passwdSubDiv';
		subDiv.style.marginLeft = '20%';
		$("#passwdDiv").append(subDiv);
		var save = document.createElement('input');
		save.type = 'button';
		save.id = 'passwd_save'
		save.value = '저장';
		save.className = 'btn btn-outline-dark';
		save.disabled = true;
		save.onclick= function(){
			var original = $("#passwd").val();
			var ex_passwd = $("#ex_passwd").val();
			if(original != ex_passwd){
				alert("이전비밀번호가 틀렸습니다.")
				$("#ex_passwd").val('');
				$("#ex_passwd").focus();
				$("#passwd_save").attr("disabled", true);
				return
			}
			var new_passwd = $("#new_passwd").val();
 			$.ajax({
				url : './savePasswd.user',
				type : 'post',
				data : {passwd:new_passwd},
				cache:false,
				success:function(res){
					alert("비밀번호가 변경되었습니다.")
					while(div.hasChildNodes()){
						div.removeChild(div.firstChild);
					}
					$("#passwd_subject").val('비밀번호');
					$("#passwd_subject").css("fontWeight","normal");
					$("#passwd").val(new_passwd);
					$("#passwd").show();
					$("#passwdEdit").show();
					$("#passwd_hr").show();
					
				},
			})
		}
		var cancel = document.createElement('input');
		cancel.type = 'button';
		cancel.id = 'passwd_cancel'
		cancel.value = '취소';
		cancel.className = 'btn btn-outline-dark';
		cancel.onclick=function(){
			while(div.hasChildNodes()){
				div.removeChild(div.firstChild);
			}
			$("#passwd_subject").val('비밀번호');
			$("#passwd_subject").css("fontWeight","normal");
			$("#passwd").show();
			$("#passwdEdit").show();
			$("#passwd_hr").show();
		}
		subDiv.appendChild(save);
		subDiv.appendChild(cancel);
	}
	
	$(document).ready(function(){
		var phone = $("#phone").val();
		// 000-0000-0000
		phone = phone.replace(/[^0-9]/g, '')
		  .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
		$("#phone").val(phone);
		$("#new_phone").hide();
		$("#phoneChk").hide();
		$("#phoneSMS").hide();
		$("#phoneCancel").hide();
	});
	
	function phoneEdit(){
		$("#phone").hide();
		$("#phoneEdit").hide();
		$("#new_phone").show();
		$("#phoneChk").show();
		$("#phoneCancel").show();
	}
	function phoneCancel(){
		$("#phoneCancel").hide();
		$("#phone").show();
		$("#phoneEdit").show();
		$("#new_phone").hide();
		$("#new_phone").val('');
		$("#phoneChk").hide();
		$("#phoneChk").attr("disabled",true);
	}
	function checkPhoneNum(){
		var phone = document.getElementById('new_phone');
		phone.value = phone.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');
		var new_phone = phone.value;
		if(new_phone == ""){
			$("#phoneChk").attr("disabled",true);
			return
		}
 		if(new_phone.length != 11){
			$("#phoneChk").attr("disabled",true);
			return
		}
		$("#phoneChk").attr("disabled",false);
		$.ajax({
			url:'./checkPhoneNum',
			type:'post',
			data:{phoneNum:new_phone},
			cache:false,
			success:function(res){
				if(res == 0){
					$("#phone-already").hide();
					$("#phoneChk").attr("disabled",false);
				}else{
					$("#phone-already").show();
					$("#phoneChk").attr("disabled",true);
				}
			},
			error:function(){
				alert("에러");
			}
		});
	};
	function hrSolid(e){
		if(e.id == 'new_phone')$('#phone_hr').css('border','1px solid');
		else $('#sms_hr').css('border','1px solid');
	}
	function hrNormal(e){
		if(e.id == 'new_phone') $('#phone_hr').css('border','');
		else $('#sms_hr').css('border','');
	}
	
	var code = null;
	
	function sendSMS(){
		var phone = $("#new_phone").val();
		$.ajax({
			type:"post",
			url:"./sendSMS",
			data:{phone_num:phone},
			cache:false,
			success:function(data){
				alert("휴대폰 번호로 인증번호가 전송되었습니다. 인증번호를 입력해주세요.")
				$("#phoneSMS").show();
				$("#randNum").attr("disabled",false);
				$("#new_phone").attr("readonly",true);
				$("#phoneChk").attr("disabled",true);
				$("#phoneChk").val('전송완료');
				code = data;
			}
		});
	}
	function checkRandNum(){
		var num = document.getElementById('randNum');
		num.value = num.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');
		if($("#randNum").val().length == 6){
			$("#phoneChk2").attr("disabled",false);
		}else{
			$("#phoneChk2").attr("disabled",true);
		}
	}
	function phoneChk2(){
		var phone = $("#new_phone").val();
 		if($("#randNum").val() == code){
			alert("인증성공")
			$.ajax({
				type:"post",
				url:"./savePhone.user",
				data:{phone_num:phone},
				cache:false,
				success:function(data){
					alert("휴대폰 번호로 인증번호가 전송되었습니다. 인증번호를 입력해주세요.")
					$("#phoneSMS").show();
					$("#randNum").attr("disabled",false);
					$("#new_phone").attr("readonly",true);
					$("#new_phone").val('');
					$("#phoneChk").attr("disabled",true);
					$("#phoneChk").val('전송완료');
					phone = phone.replace(/[^0-9]/g, '')
					  .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
					$("#phone").val(phone);
					$("#phone").show();
					$("#phoneEdit").show();
		 			$("#new_phone").hide();
					$("#phoneChk").hide();
					$("#phoneSMS").hide(); 
					$("#new_phone").attr("readOnly",false);
					$("#phoneChk").val('인증번호 발송');
					code = data;
				}
			});
		}else{
			alert("인증실패")
		} 
	}
	
	
	function setConfirmSize(size){
		 document.getElementById("selectSize").value = size
		 $("#confirm").attr("disabled",false);
	 }
	function setParentSize(){
		document.getElementById("size").value = document.getElementById("selectSize").value
		var size = document.getElementById("size").value;
		$(".size-popup").removeClass("show");
		$.ajax({
			url : "./saveSize.user",
			type : "post",
			data : {size : size},
			cache : false,
			success : function(res){
				alert('사이즈 수정성공')
			}
		}); 
	}
	
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
	
	function delMember(e){
		var isDel = confirm('정말 탈퇴하시겠습니까?')
		if(isDel){
			var user_num = $("#user_num").val();
			location.href = "delMember.user?user_num="+user_num;
		}
	}
</script>
<body>
<div class="basicFont">
<h2>로그인 정보</h2>
<hr style="border: 1px solid;">

<h4>내 계 정</h4>
<br>
	<!-- 이메일 -->
	<h5>이메일 주소</h5>
	<input type="text" id="email" value="${memberDTO.email}"
	style="border:none; width:300px" maxlength="13" readOnly">
	<hr id="email_hr" style="text-align:left;margin-left:0; width:380px;">
	

<br>
	<!-- 비밀번호 -->
	<input type="text" id="passwd_subject" value="비밀번호" 
	style="font-size:5; border:none;" readOnly><br>
	<input type="password" id="passwd" value="${memberDTO.passwd}" 
	style="border:none; width:300px;" readOnly>
	<input type="button" id="passwdEdit" value="변경" onclick="passwdEdit()" class="btn btn-outline-dark">
	<hr id="passwd_hr" style="text-align:left;margin-left:0; width:380px;">
	<div id="passwd-blank" class="invalid-feedback">영문,숫자,특수문자 조합하여 입력해주세요.(8-16자)</div>
	<div id="passwdDiv"></div>
	

<br>
	<!-- 휴대폰 -->
	<h5>휴대폰</h5>
	<div id="phoneDiv">
		<input type="text" id="phone" value="${memberDTO.phone_num}" 
			style="border:none; width:300px;" readOnly>
		<input type="button" id="phoneEdit" value="변경" onclick="phoneEdit()" class="btn btn-outline-dark">
		<input  type="text" id="new_phone"  
			oninput="checkPhoneNum()" onfocus="hrSolid(this)" onblur="hrNormal(this)"
			maxlength="11" placeholder="휴대폰번호를 입력하세요."	style="border:none; width:300px;">
		<input  type="button" value="인증번호 발송" id="phoneChk" onclick="sendSMS()"disabled class="btn btn-outline-dark"/>
		<input type= "button" value="취소" id="phoneCancel" onclick="phoneCancel()" class="btn btn-outline-dark">
	</div>
	<hr id="phone_hr" style="text-align:left;margin-left:0; width:380px;">
	<div id="phone-already" class="invalid-feedback">이미 등록된 휴대폰번호입니다.</div>
	<div id="phoneSMS">
		<input type="text" name="randNum" id="randNum" maxlength="6" placeholder="인증번호 입력" 
			oninput="checkRandNum()" onfocus="hrSolid(this)" onblur="hrNormal(this)"
				class="btn btn-outline-dark"
			style="border:none; width:300px;" disabled/>
		<input type="button" value="확인" id="phoneChk2" onclick="phoneChk2()" disabled
		class="btn btn-outline-dark"/>
		<hr id="sms_hr" style="text-align:left;margin-left:0; width:380px;">
	</div>
	
	
<br>
	<!-- 신발 사이즈 -->
	<h5>신발 사이즈</h5>
	<input type="text" id="size" value="${memberDTO.user_size}"
	style="border:none; width:300px" maxlength="13" readOnly">
	<input type="button" id="sizeEdit" class="btn btn-open btn-outline-dark" value="변경" >
	<hr id="size_hr" style="text-align:left;margin-left:0; width:380px;">
 
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
<br> 
 	<!-- 회원 탈퇴 -->
 	<input type="button" id="delMember" value="회원탈퇴"  class="btn btn-outline-dark"
 	style="border:none; text-decoration: underline; font-size:15px;" onclick="delMember(this)">
 	<input type="hidden" id="user_num" value="${memberDTO.user_num}">
</div>	


</body>
</html>
<%@include file="bottom.jsp" %>