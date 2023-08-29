<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/css/bootstrap.min.css"
   type="text/css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
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
a{
	text-decoration : none;
	color : blue;
}
a:hover{
	text-decoration : none;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	$(document).keypress(function(e) {
		if (e.keyCode == 13)
			e.preventDefault();
	});
	$(document).ready(function() {
		$("#submit").attr("disabled", true);
	});
	function checkNull() {
		if (document.getElementById('reply').value == ""
				|| document.getElementById('reply').value == null) {
			$("#submit").attr("disabled", true);
		}else{
			$("#submit").attr("disabled", false);
		}
	}
	
	function goMyProfile(profile_name) {
		self.close()
		window.opener.location.href = 'styleBoardSearch.user?search='
				+ encodeURIComponent('@' + profile_name)

	}
	function sendHashTag(hashTag) {
		self.close()
		window.opener.location.href = 'styleBoardSearch.user?search='
				+ encodeURIComponent('#' + hashTag)
	}

	function reReply(profileName, group) {
		$('#clearText *').remove();
		var reply_group = group;
		document.getElementById('reply').value = '@' + profileName + ' ';
		document.getElementById('group').value = reply_group;

		var btn = document.createElement('input');
		btn.type = "button";
		btn.id = "x";
		btn.onclick = function() {
			document.getElementById('group').value = "";
			document.getElementById('reply').value = "";
			del();
		}
		btn.value = "X";

		var showText = document.createElement('input');
		showText.type = "text";
		showText.id = "o";
		showText.disabled = true;
		showText.value = profileName + "님에게 답글 남기는 중";

		document.getElementById('clearText').appendChild(showText);
		document.getElementById('clearText').appendChild(btn);
	}
	function del() {
		document.getElementById('clearText').removeChild(
				document.getElementById('x'));
		document.getElementById('clearText').removeChild(
				document.getElementById('o'));
	}
	function checkNullEnter(event){
		if(event.keyCode == 13 && !document.getElementById('submit').disabled){
				document.getElementById('submit').click();
		}
	}
</script>
</head>
<body>
	<div class="basicFont">
	<img src="${upPath}/${styleBoardAllDTO.profile_img}" height="30" width="30"
	class="rounded-circle"
	onerror="this.src='https://blog.kakaocdn.net/dn/c3vWTf/btqUuNfnDsf/VQMbJlQW4ywjeI8cUE91OK/img.jpg'"> 
	${styleBoardAllDTO.profile_name}

	<table>
		<tr>
			<td><c:forEach var="content" items="${contentList }">
					<c:forEach var="hashTagBaseDTO" items="${hashTagList}">
						<c:if test="${content=='#' +=hashTagBaseDTO.hashTag_name}">
							<a href="javascript:sendHashTag('${hashTagBaseDTO.hashTag_name}')"><font color="blue">
						</c:if>
					</c:forEach>
					<c:forEach var="writerTag" items="${writerList}">
						<c:if test="${content=='@'+=writerTag}">
							<a href="javascript:goMyProfile('${writerTag}')"><font color="green">
						</c:if>
					</c:forEach>
${content}</font></a>
				</c:forEach> <br> ${styleBoardAllDTO.reg_date}</td>
		</tr>
	</table>

	<form id="replyOk" name="replyOk" action="styleReply.user" method="post">
		<div id="clearText"></div>
		<input type="hidden" name="styleNum"value="${styleBoardAllDTO.style_num}"> 
		<input type="hidden" name="group" id="group"> 
			<input type="text" name="reply"	id="reply" oninput="checkNull()" onkeypress="checkNullEnter(event)"> 
			<input type="submit" id="submit" name="submit" value="댓글등록" class="btn btn-outline-dark">
	</form>
	<table>
		<c:forEach var="replyDTO" items="${replyList}">
			<tr>
				<td>
				<c:if test="${replyDTO.reply_step!=0}">
			<div style="padding-left:10%">
			<img src="${upPath}/${replyDTO.profile_img}" height="30" width="30"
				class="rounded-circle"
				onerror="this.src='https://blog.kakaocdn.net/dn/c3vWTf/btqUuNfnDsf/VQMbJlQW4ywjeI8cUE91OK/img.jpg'">
				${replyDTO.profile_name}<font color="gray"> ${replyDTO.reg_date}</font>
				
				
					<table>
							<tr>
								<td><c:forEach var="content" items="${replyDTO.replyContentList }">
										<c:forEach var="hashTagBaseDTO"	items="${replyDTO.replyHashTagList}">
											<c:if test="${content=='#' +=hashTagBaseDTO.hashTag_name}">
												<a	href="javascript:sendHashTag('${hashTagBaseDTO.hashTag_name}')"><font color="blue">
											</c:if>
										</c:forEach>
										<c:forEach var="writerTag" items="${replyDTO.replyWriterList}">
											<c:if test="${content=='@'+=writerTag}">
												<a href="javascript:goMyProfile('${writerTag}')"><font color="green">
											</c:if>
										</c:forEach>
										${content}</font></a>
									</c:forEach></td>
							</tr>
					</table>
					
						<a href="javascript:reReply('${replyDTO.profile_name}','${replyDTO.reply_group}')">
							<font color="gray">답글달기</font></a>
						<c:if test="${sessionUser_num==replyDTO.user_num}">
							<a href="deleteReply.user?reply_num=${replyDTO.reply_num}&style_num=${replyDTO.style_num}&mode=reReply">
							<font color="gray">삭제</font></a>
						</c:if>
					</c:if> 
					</div>
					<c:if test="${replyDTO.reply_step==0}">
						<img src="${upPath}/${replyDTO.profile_img}" height="30"
							width="30" class="rounded-circle"
							onerror="this.src='https://blog.kakaocdn.net/dn/c3vWTf/btqUuNfnDsf/VQMbJlQW4ywjeI8cUE91OK/img.jpg'">
				${replyDTO.profile_name}<font color="gray"> ${replyDTO.reg_date}</font>
				
				<table>
							<tr>
								<td><c:forEach var="content"
										items="${replyDTO.replyContentList }">
										<c:forEach var="hashTagBaseDTO"
											items="${replyDTO.replyHashTagList}">
											<c:if test="${content=='#' +=hashTagBaseDTO.hashTag_name}">
												<a href="javascript:sendHashTag('${hashTagBaseDTO.hashTag_name}')">
											</c:if>
										</c:forEach>
										<c:forEach var="writerTag" items="${replyDTO.replyWriterList}">
											<c:if test="${content=='@'+=writerTag}">
												<a href="javascript:goMyProfile('${writerTag}')">
											</c:if>
										</c:forEach>
                                           ${content}</a>
									</c:forEach></td>
							</tr>
						</table>
						<a href="javascript:reReply('${replyDTO.profile_name}','${replyDTO.reply_group}')">
							<font color="gray">답글달기</font> </a>
						<c:if test="${sessionUser_num==replyDTO.user_num}">
							<a href="deleteReply.user?reply_num=${replyDTO.reply_num}&style_num=${replyDTO.style_num}&mode=reply">
							<font color="gray">삭제</font></a>
						</c:if>
					</c:if></td>
			</tr>
		</c:forEach>
	</table>
	</div>
</body>
</html>