<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="top.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myProfileManage</title>
</head>
<style>
	.invalid-feedback{
    	display: none;
     }
</style>
<body>
<div class="basicFont">
<h2>프로필 관리</h2>
<hr style="border: 1px solid;">
<table>
	<tr>
		<td rowspan="2">
		<div id="profile_img">
			<img src="${upPath}/${memberDTO.profile_img}" width="100" height="100"
			class="rounded-circle"
			onerror="this.src='https://blog.kakaocdn.net/dn/c3vWTf/btqUuNfnDsf/VQMbJlQW4ywjeI8cUE91OK/img.jpg'">
		</div>
		</td>
		<td colspan="2"><font id="topProfile_name">${memberDTO.profile_name}</font></td>
	</tr>
	<tr>
		<input type="file" id="profile_imgEdit" style="visibility: hidden;">
		<td><input type="button" value="이미지변경" onclick="imgEdit('${upPath}')" class="btn btn-outline-dark"></td>
		<td><input type="button" value="삭제" onclick="imgDel('${upPath}')" class="btn btn-outline-dark"></td>
	</tr>
</table>
<hr>
<h4>프로필 정보</h4>
<br>
	<!-- 프로필이름 -->
	<h5>프로필 이름</h5>
	<input type="text" id="profile_name" value="${memberDTO.profile_name}" oninput="checkProfileName(this)"
	style="border:none; width:300px" maxlength="13" readOnly>
	<!-- 프로필이름변경버튼 -->
	<input type="button" id="profile_nameEdit" value="변경" onclick="profile_nameEdit()" class="btn btn-outline-dark">
	<hr id="profile_name_hr" style="text-align:left;margin-left:0; width:380px;">
	<div id="profileName-already" class="invalid-feedback">이미 사용 중인 프로필 이름입니다.</div>
	<div id="profileName-blank" class="invalid-feedback">영문,숫자,특수기호(_)만 사용 가능합니다.(2~13자이내)</div>
	<div id="profile_nameDiv" style="margin-left:20%;"></div>
	


<br>
	<!-- 이름 -->
	<h5>이름</h5>
	<input type="text" id="name" value="${memberDTO.name}" oninput="checkName(this)"
	style="border:none; width:300px;" readOnly>
	<input type="button" id="nameEdit" value="변경" onclick="nameEdit()" class="btn btn-outline-dark">
	<hr id="name_hr" style="text-align:left;margin-left:0; width:380px;">
	<div id="name-blank" class="invalid-feedback">이름을 입력해주세요.</div>
	<div id="nameDiv" style="margin-left:20%;"></div>
	

<br>
	<!-- 소개 -->
	<h5>소개</h5>
	<input type="text" id="info" value="${memberDTO.info}" 
	style="border:none; width:300px;" readOnly>
	<input type="button" id="infoEdit" value="변경" onclick="infoEdit()" class="btn btn-outline-dark">
	<hr id="info_hr" style="text-align:left;margin-left:0; width:380px;">
	<div id="infoDiv" style="margin-left:20%;"></div>
	
<br>
<br>
<h4>프로필 차단/해제</h4>
<br>
<input type="button" value="차단한 프로필" onclick="banList('${memberDTO.user_num}')" style="border:none;" class="btn btn-outline-dark">
<hr style="text-align:left;margin-left:0; width:380px;">




<script src="resources/js/user/my/myProfileManage.js"></script>
</div>
</body>
</html>
<%@include file="bottom.jsp" %>