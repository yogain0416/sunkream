<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../top.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
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
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<body>
	<script type="text/javascript">
		function sendHashTag(hashTag) {
			location.href = 'styleBoardSearch.user?search='
					+ encodeURIComponent('#' + hashTag)

		}

		function addLike(styleNum) {
			$
					.ajax({
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
			$
					.ajax({
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
	</script>
<body>
<div align="center" class="basicFont">
	<div class="row">
		<div class="col">
			<table onclick="location.href='prodView.user?prod_num=${dto.prod_num}'"
				style="cursor:pointer;">
				<tr align="center">
					<td><img src="${upPath}/${dto.prod_img1}" width="80" height="80"></td>
				</tr>
				<tr align="center">
					<td>${dto.prod_subject}</td>
				</tr>
				<tr align="center">
					<td>${dto.prod_kr_subject}</td>
				</tr>
				<tr align="center">
					<th><fmt:formatNumber value="${dto.prod_price}"></fmt:formatNumber>원</th>
				</tr>
			</table>
		</div>
	</div>
	
	<div align="center">
		<table>
			<c:set var="count" value="0" />
			<tr align="center">
				<c:forEach var="dto" items="${List}">
					<c:if test="${dto.checkBan!=1}">
						<td align="center"><br> <a
							href="styleView.user?styleNum=${dto.style_num}&userNum=${dto.user_num}"><img
								src="${upPath}/${dto.style_img1}" height="150" width="150"></a>
							<br> <a href="myProfile.user?user_num=${dto.user_num}">
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

							<div id="likeSu"></div>
							<div class="wordtest">${dto.style_contents}</div></td>
						<c:set var="count" value="${count+1}" />
						<c:if test="${count%4==0}">
			</tr>
			<tr>
				</c:if>
				</c:if>
				</c:forEach>
		</table>
		</div>
	
	
	
</div>



</body>
</html>
<%@ include file="../../bottom.jsp"%>