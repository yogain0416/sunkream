<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="style_top.jsp"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/slide.css" type="text/css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function() {
   const time = document.getElementById('time').value;	
	const split=time.split(" ")
	const split1=split[0].split("/")
	const split2=split[1].split(":")
	    const today = new Date();
	 const timeValue = new Date(20+split1[0], split1[1]-1, split1[2], split2[0], split2[1], split2[2], 0);
	   const x=today.getTime() - timeValue.getTime();
	   const y= x/1000/60;
	    const betweenTime = Math.floor(y);
/* 	    if (betweenTime < 1){ 
	    	var result3 =betweenTime/60+"초 전"; 
	    	document.getElementById('time').value=result3   return } */
	    if (betweenTime < 60) {
	    	if(betweenTime<1){var result = "방금전";}
	    	else {var result = betweenTime + "분전";}
	    	document.getElementById('time').value= result
	    	return 
	    }
	    const betweenTimeHour = Math.floor(betweenTime/60);
	    if (betweenTimeHour < 24) {
	    	var result = betweenTimeHour + "시간전";
	    	document.getElementById('time').value= result
	    	return 
	    }
	    const betweenTimeDay = Math.floor(betweenTime/60/24);
	    if (betweenTimeDay < 7) {
	    	var result = betweenTimeDay + "일전";
	    	document.getElementById('time').value= result
	    	return 
	    }
var result2 = "20"+split1[0]+"년"+split1[1]+"월"+split1[2]+"일"
	    	document.getElementById('time').value= result2 

	    return 
});
	function likeList(style_num) {
		window.open("likeList.user?style_num=" + style_num, "",
				"width=640, height=400,scrollbars=yes, resizable=no, left=pixels")
	}

	function reply(styleNum) {
		window.open("styleReply.user?styleNum=" + styleNum, "",
				"width=640, height=600,scrollbars=yes, resizable=no,left=pixels")
	}
	function sendHashTag(hashTag) {
		location.href = 'styleBoardSearch.user?search='
				+ encodeURIComponent('#' + hashTag)

	}

	function goMyProfile(profile_name) {
		location.href = 'styleBoardSearch.user?search='
				+ encodeURIComponent('@' + profile_name)

	}
	function deleteBoard(styleNum) {
		var isDel = window.confirm("정말로 삭제하시겠습니까?")
		if (isDel) {
			location.href = 'styleBoardDelete.user?styleNum=' + styleNum;
		}
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
						document.getElementById('like' + styleNum).className = "bi bi-heart"
						document.getElementById('like' + styleNum).onclick = function() {
							addLike(styleNum);
						}
					}
				});

	};
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
	               document.getElementById('follow').value = "맞팔로우";
	            } else {
	               document.getElementById('follow').value = "팔로우";
	            }
	            document.getElementById('follow').onclick = function() {
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
	            
	            document.getElementById('follow').value = "팔로우취소";
	            document.getElementById('follow').onclick = function() {
	               removeFollow(userNum);
	            }
	         }
	      });

	   };
	   function showAlert(){
		   alert("현재 미판매 상품입니다.")
	   }

</script>
</head>
<body>
	<div align="center" class="basicFont">
	<a href="myProfile.user?user_num=${styleBoardAlldto.user_num}">
	<img src="${upPath}/${styleBoardAlldto.profile_img}" height="100" width="100"
		class="rounded-circle"
		onerror="this.src='https://blog.kakaocdn.net/dn/c3vWTf/btqUuNfnDsf/VQMbJlQW4ywjeI8cUE91OK/img.jpg'">
		<br>${styleBoardAlldto.profile_name}</a>
	<br>
	<c:if test="${empty sessionUser_num}">
		<input type="button" value="팔로우" onclick="location.href='main.login'" class="btn btn-outline-dark">
	</c:if>
	<c:if test="${not empty sessionUser_num}">
		<!--int 1이면 팔로우 2면 팔로우취소 3이면 맞팔 -->
		<c:if test="${checkFollowing==1}">
			<input type="button" id="follow" name="follow" value="팔로우 "
				onclick="addFollow('${styleBoardAlldto.user_num}')" 
				class="btn btn-outline-dark"/>
		</c:if>
		<c:if test="${checkFollowing==2}">
			<input type="button" id="follow" name="follow" value="팔로우취소 "
				onclick="removeFollow('${styleBoardAlldto.user_num}')" 
				class="btn btn-outline-dark"/>
		</c:if>
		<c:if test="${checkFollowing==3}">
			<input type="button" id="follow" name="follow" value="맞팔로우 "
				onclick="addFollow('${styleBoardAlldto.user_num}')" 
				class="btn btn-outline-dark"/>
		</c:if>
	</c:if>
	<br>
	<!-- 시간 -->
	<input type="text" id="time" name="time" class="basicFont"
		value="${styleBoardAlldto.reg_date}" style="border: 0 solid black; color:gray;"
		readOnly>
	<br>
	<!-- 수정|삭제 -->
	<c:if test="${styleBoardAlldto.user_num eq sessionUser_num}">
		<a href="updateBoard.user?style_num=${styleBoardAlldto.style_num}">수정</a>|
		<a href="javascript:deleteBoard('${styleBoardAlldto.style_num}')">삭제</a>
	</c:if>
	<br>
	<!-- 이미지 -->
	<div id="slideShow">
		<ul class="slides">
			<li><img src="${upPath}/${styleBoardAlldto.style_img1}" alt=""
				width="300px" height="300px"></li>
			<c:if test="${styleBoardAlldto.style_img2 ne null}">
				<li><img src="${upPath}/${styleBoardAlldto.style_img2}" alt=""
					width="300px" height="300px"></li>
			</c:if>
			<c:if test="${styleBoardAlldto.style_img3 ne null}">
				<li><img src="${upPath}/${styleBoardAlldto.style_img3}" alt=""
					width="300px" height="300px"></li>
			</c:if>
			<c:if test="${styleBoardAlldto.style_img4 ne null}">
				<li><img src="${upPath}/${styleBoardAlldto.style_img4}" alt=""
					width="300px" height="300px"></li>
			</c:if>
			<c:if test="${styleBoardAlldto.style_img5 ne null}">
				<li><img src="${upPath}/${styleBoardAlldto.style_img5}" alt=""
					width="300px" height="300px"></li>
			</c:if>
		</ul>
		<p class="controller">
			<span class="prev">&lang;</span> <span class="next">&rang;</span>
		</p>
	</div>
	<script src="resources/js/slides.js"></script>
	<c:if test="${prod_tag_su ne 0}">
	상품태그 ${prod_tag_su}개
	<table>
		<tr>
			<c:set var="count2" value="0" />
			<c:forEach var="dto" items="${prod_tag_list}">

				<c:if test="${count2==5}">
		</tr>
		<tr>
			</c:if>
			<td width="150">
			<c:if test="${dto.del eq 'Y'}"><a href="javascript:showAlert()"></c:if>
			<c:if test="${dto.del ne 'Y'}"><a href="prodView.user?prod_num=${dto.prod_num}"></c:if> <!-- 상품상세보기 페이지 넣기 -->
			<img src="${upPath}/${dto.prod_img1}" height="100"
				width="100"> <br>
				<h6>${dto.subject}</h6> </a><br>
				<h6>${dto.prod_price}원</h6></td>
			<c:set var="count2" value="${count2+1}" />
			</c:forEach>
		</tr>
	</table>
	</c:if>
	<c:if test="${not empty sessionUser_num}">
		<c:if test="${styleBoardAlldto.checkLike==2}">
			<i onclick = "addLike('${styleBoardAlldto.style_num}')" style = "color:red; cursor:pointer" id = "like${styleBoardAlldto.style_num }" class="bi bi-heart"></i>
		</c:if>
		<c:if test="${styleBoardAlldto.checkLike==1}">
		<i onclick = "javascript:removeLike('${styleBoardAlldto.style_num}')" style= "color:Red; cursor : pointer;" id = "like${styleBoardAlldto.style_num }" class="bi bi-heart-fill"></i>
		</c:if>
	</c:if>
	<c:if test="${empty sessionUser_num}">
		<i onclick = "location.href = 'main.login'" style = "color:red;cursor:pointer;" class="bi bi-balloon-heart"></i>
	</c:if>
	<c:if test="${empty sessionUser_num}">
		<a href="main.login"><font color="blue">댓글</font></a>
	</c:if>
	<c:if test="${not empty sessionUser_num}">
		<a href="javascript:reply('${styleBoardAlldto.style_num}')"><font color="blue">댓글</font></a>
	</c:if>
	<br>
	<a href="javascript:likeList('${styleBoardAlldto.style_num}')"><font color="red">좋아요</font>
		<input type="text" id="${styleBoardAlldto.style_num}"
		value="${styleBoardAlldto.style_like}" size="1"	style="border: 0 solid black" readOnly /><font color="red">개</font>
	</a>
	<br>
	<c:forEach var="content" items="${contentList }">
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
	${content}</font>
	</a>
	</c:forEach>
	</div>
</body>
</html>
<%@include file="../../bottom.jsp"%>