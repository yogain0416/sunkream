<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="style_top.jsp"%>
<!DOCTYPE html>
<html>
<head>
<style>
.wordtest {
	boarder: 1px solidblack;
	width: 200px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	text-align: left;
	display: -webkit-box;
	-webkit-box-orient: vertical;
	-webkit-line-clamp: 2;
	/* 	    white-space: normal; */
	line-height: 1.2;
	height: 2.4em;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function likeAfterPage(styleNum, search) {
		location.href = 'likeStyle.user?styleNum=' + styleNum + '&search='
				+ encodeURIComponent(search)
	}

	function addLike(styleNum) {
		$.ajax({
					url : './likeStyle.user', //Controller에서 요청 받을 주소
					type : 'post', //POST 방식으로 전달
					data : {
						styleNum : styleNum
					},
					cache : false,
					success : function(likeSu) {//컨트롤러에서 넘어온 cnt값을 받는다  
						document.getElementById(styleNum).value = likeSu;
						document.getElementById('like' + styleNum).className = "bi bi-heart-fill";
						document.getElementById('like' + styleNum).onclick = function() {
							removeLike(styleNum);
						}
					}
				});

	};

	function removeLike(styleNum) {
		$.ajax({
					url : './removeLikeStyle.user', //Controller에서 요청 받을 주소
					type : 'post', //POST 방식으로 전달
					data : {
						styleNum : styleNum
					},
					cache : false,
					success : function(likeSu) {//컨트롤러에서 넘어온 cnt값을 받는다  
						document.getElementById(styleNum).value = likeSu;
						document.getElementById('like' + styleNum).className = "bi bi-heart";
						document.getElementById('like' + styleNum).onclick = function() {
							addLike(styleNum);
						}
					}
				});

	};
	
	var isStart = true;
	var isEnd = false; 
	var count = 16;
	window.onscroll = function(e) {
		var boxHeight = document.getElementById('styleBoard').clientHeight;
		var search = document.getElementById('searchTag').value;
		var listSize = Number(document.getElementById('listSize').value);
		if(listSize <= 8){
			isEnd = true;
		}
		if(window.pageYOffset >= boxHeight/3 && !isEnd && isStart) { 
			var div = document.getElementById('styleBoard');
		  	isStart = false;
		  	$.ajax({
		  		url : './styleBoardScroll.user',
		  		type : 'post',
		  		data : {
		  			search : search,
		  			count : count
		  		},
		  		cache : false,
		  		success : function(res) {
			  		while (div.firstChild) {
			  	    	div.removeChild(div.firstChild);
			  		}
			  		var html = jQuery('<div>').html(res);
			  		var contents = html.find("div#styleBoard").html();
			  		$("#styleBoard").html(contents);
			  		if(listSize <= count){
			  			isEnd = true;
			  		}else{
			  			isEnd = false;
			  			count += 8;
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
	<input type="hidden" id="searchTag" value="${search}">
	<input type="hidden" id="listSize" value="${listSize}">
	
	<div align="center">
	<div id="styleBoard" class="basicFont">
		<h1><font color="blue">${search}</font></h1>
		<c:if test="${empty styleBoardAllList}">
		<h3>표시할 게시글이 없습니다.</h3>
		</c:if>
		<c:if test="${not empty styleBoardAllList}">
		<table>
			<c:set var="co" value="0" />
			<tr>
				<c:forEach var="dto" items="${styleBoardAllList}">
					<c:if test="${co < 8}">
					<td><br> <a	href="styleView.user?styleNum=${dto.style_num}&userNum=${dto.user_num}">
							<img src="${upPath}/${dto.style_img1}" height="150" width="150">
					</a> <br> <a href="myProfile.user?user_num=${dto.user_num}"> 
						<img src="${upPath}/${dto.profile_img}" height="30" width="30"
							class="rounded-circle"
							onerror="this.src='https://blog.kakaocdn.net/dn/c3vWTf/btqUuNfnDsf/VQMbJlQW4ywjeI8cUE91OK/img.jpg'">
							${dto.profile_name}
					</a> <br> <c:if test="${not empty sessionUser_num}">
							<c:if test="${dto.checkLike==2}">
								<i onclick = "addLike('${dto.style_num }')" style = "color:red; cursor:pointer" id = "like${dto.style_num }" class="bi bi-heart"></i>
							</c:if>
							<c:if test="${dto.checkLike==1}">
								<i onclick = "javascript:removeLike('${dto.style_num }')" style= "color:Red; cursor : pointer;" id = "like${dto.style_num }" class="bi bi-heart-fill"></i>
							</c:if>
						</c:if> <c:if test="${empty sessionUser_num}">
							<i onclick = "location.href = 'main.login'" style = "color:red;cursor:pointer;" class="bi bi-balloon-heart"></i>
						</c:if> :<input type="text" id="${dto.style_num}"
						value="${dto.style_like}" size="1" style="border: 0 solid black"
						readOnly /> 
						<div class="wordtest">${dto.style_contents}</div></td>
						
					<c:set var="co" value="${co+1}" />
					<c:if test="${co%4==0}">
					</tr>
					<tr>
					</c:if>
				</c:if>
				</c:forEach>
		</table>
		</c:if>
	</div>
	</div>
</body>
</html>
<%@include file="../../bottom.jsp"%>