<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/bootstrap.min.css" type="text/css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<style>
input[type=text]::-ms-clear {
	display:none;
}
a{
 	text-decoration : none;
 	color : green;
}
a:hover{
	text-decoration : none;
}

@font-face {
    font-family: 'Dovemayo_gothic';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.1/Dovemayo_gothic.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
.basicFont{
	font-family: 'Dovemayo_gothic';
}
</style>
<script type="text/javascript">
function removeBan(user_num,mode) {
	var isDel = window.confirm("차단 해제하시겠습니까?")
	if (isDel) {
		location.href = 'ban.user?user_num=' + user_num + '&mode=' + mode;
	}
}
	function goLogin() {
		self.close()
		window.opener.location.href = 'main.login'
	}
	
	function goProfile(user_num){
		self.close()
		window.opener.location.href = 'myProfile.user?user_num='+user_num
	}

	function removeFollow(userNum) {
		$.ajax({
			url : './removeFollow.user', //Controller에서 요청 받을 주소
			type : 'post', //POST 방식으로 전달
			data : {
				userNum : userNum
			},
			cache : false,
			success : function(map) {//컨트롤러에서 넘어온 cnt값을 받는다  
				if (map.checkFollowing == 3) {
					document.getElementById(userNum).value = "맞팔로우";
				} else {
					document.getElementById(userNum).value = "팔로우";
				}
				document.getElementById(userNum).onclick = function() {
					addFollow(userNum);
				}
			}
		});

	};
	function addFollow(userNum) {
		$.ajax({
			url : './addFollow.user', //Controller에서 요청 받을 주소
			type : 'post', //POST 방식으로 전달
			data : {
				userNum : userNum
			},
			cache : false,
			success : function(followerSu) {//컨트롤러에서 넘어온 cnt값을 받는다  
				alert("팔로우 성공")
				document.getElementById(userNum).value = "팔로우취소";
				document.getElementById(userNum).onclick = function() {
					removeFollow(userNum);

				}
			}
		});

	};
	
	
	var isStart = true;
	var isEnd = false; 
	var count = 6;
	window.onscroll = function(e) {
		var boxHeight = document.getElementById('followDiv').clientHeight;
		var mode = document.getElementById('follow').value;
		var style_num = document.getElementById('style_num').value;
		var user_num = document.getElementById('profileUser_num').value;
		var listSize = Number(document.getElementById('listSize').value);
		if(listSize <= 3){
			isEnd = true;
		}
		if(window.pageYOffset >= boxHeight/4 && !isEnd && isStart) { 
			var div = document.getElementById('followDiv');
		  	isStart = false;
		  	$.ajax({
		  		url : './followListScroll.user',
		  		type : 'post',
		  		data : {
		  			mode : mode,
		  			user_num : user_num,
		  			style_num : style_num,
		  			count : count
		  		},
		  		cache : false,
		  		success : function(res) {
			  		while (div.firstChild) {
			  	    	div.removeChild(div.firstChild);
			  		}
			  		var html = jQuery('<div>').html(res);
			  		var contents = html.find("div#followDiv").html();
			  		$("#followDiv").html(contents);
			  		if(listSize <= count){
			  			isEnd = true;
			  		}else{
			  			isEnd = false;
			  			count += 3;
			  		}
			  		window.scrollBy(0, -100);
			  		isStart = true;
		  		},
		 	});
		}
	} 
</script>
</head>
<body>
	<input type="hidden" id="follow" value="${mode}">
	<input type="hidden" id="profileUser_num"  value="${profileUser_num}">
	<input type="hidden" id="listSize" value="${listSize}">
	<input type="hidden" id="style_num" value="${style_num}">
	
	<div align="center" id="followDiv" class="basicFont">
	<c:if test="${empty list}">
	<h4>표시할 회원이 없습니다.</h4>
	</c:if>
	<c:if test="${not empty list}">
	
		<c:set var="co" value="0"/>
		<c:forEach var="dto" items="${list}">
			<c:if test="${co < 3}">
			<table width="300" height="100">
				<tr>
				<td rowspan="2" width="100" height="100">
				<img src="${upPath}/${dto.profile_img}" height="100" width="100"
				class="rounded-circle"
				onerror="this.src='https://blog.kakaocdn.net/dn/c3vWTf/btqUuNfnDsf/VQMbJlQW4ywjeI8cUE91OK/img.jpg'">
				</td>
				<td align="center">
				<a href="javascript:goProfile('${dto.user_num}')"><font size="6px" color="green">${dto.profile_name}</font></a>
				</td>
				<td rowspan="2" align="right">
				<c:if test="${empty sessionUser_num}">
					<input type="button" value="팔로우 " onclick="goLogin()" 
					class="btn btn-outline-dark"/>
				</c:if>
				<c:if test="${not empty sessionUser_num}">
				<c:if test="${dto.checkFollowing==0}">
						<input type="button" id="${dto.user_num}" name="${dto.user_num}"
							value="차단해제 " onclick="removeBan('${dto.user_num}','removeBan')" 
							class="btn btn-outline-dark"/>
					</c:if>
					<c:if test="${dto.checkFollowing==1}">
						<input type="button" id="${dto.user_num}" name="${dto.user_num}"
							value="팔로우 " onclick="addFollow('${dto.user_num}')" 
							class="btn btn-outline-dark"/>
					</c:if>
					<c:if test="${dto.checkFollowing==2}">
						<input type="button" id="${dto.user_num}" name="${dto.user_num}"
							value="팔로우취소 " onclick="removeFollow('${dto.user_num}')" 
							class="btn btn-outline-dark"/>
					</c:if>
					<c:if test="${dto.checkFollowing==3}">
						<input type="button" id="${dto.user_num}" name="${dto.user_num}"
							value="맞팔로우 " onclick="addFollow('${dto.user_num}')" 
							class="btn btn-outline-dark"/>
					</c:if>
					<c:if test="${dto.checkFollowing==4}">
					</c:if>
				</c:if>
				</td>
				</tr>
				<tr>
				<td align="center">					
				${dto.name}
				</td></tr>
				<tr><td colspan="3"><hr></td></tr>
			</table>
			<c:set var="co" value="${co+1}"/>
			</c:if>
		</c:forEach>


</c:if>
	</div>
</body>
</html>