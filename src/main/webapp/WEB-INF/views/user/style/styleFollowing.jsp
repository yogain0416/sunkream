<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="style_top.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>
$(document).ready(function() {
	var bt = document.getElementsByName('time');
	for (i = 0; i < bt.length; ++i) {
		 const time =bt[i].value;	
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
			    	bt[i].value= result
			    	continue;
			    }
			    const betweenTimeHour = Math.floor(betweenTime/60);
			    if (betweenTimeHour < 24) {
			    	var result = betweenTimeHour + "시간전";
			    	bt[i].value= result
			    	continue; 
			    }
			    const betweenTimeDay = Math.floor(betweenTime/60/24);
			    if (betweenTimeDay < 7) {
			    	var result = betweenTimeDay + "일전";
			    	bt[i].value= result
			    	continue; 
			    }
		var result2 = "20"+split1[0]+"년"+split1[1]+"월"+split1[2]+"일"
		bt[i].value= result2 
		continue;
	}
	return
});
function sendHashTag(hashTag) {
	location.href = 'styleBoardSearch.user?search='
			+ encodeURIComponent('#' + hashTag)

}

function goMyProfile(profile_name) {
	location.href = 'styleBoardSearch.user?search='
			+ encodeURIComponent('@' + profile_name)

}
function likeList(style_num) {
	window.open("likeList.user?style_num=" + style_num, "",
			"width=640, height=400,scrollbars=yes, resizable=no , left=pixels")
}

function reply(styleNum) {
	window.open("styleReply.user?styleNum=" + styleNum, "",
			"width=640, height=1000,scrollbars=yes, resizable=no, left=pixels")
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
				var bt = document.getElementsByName(userNum + 'follow');
				for (i = 0; i < bt.length; ++i) {
					bt[i].value = "맞팔로우";
					bt[i].onclick = function() {
						addFollow(userNum);
					}
				}
			} else {
				var bt = document.getElementsByName(userNum + 'follow');
				for (i = 0; i < bt.length; ++i) {
					bt[i].value = "팔로우";
					bt[i].onclick = function() {
						addFollow(userNum);
					}
				}
			}
		}
	});
};
function addFollow(userNum) {
	alert(userNum)
	$.ajax({
		url : './addFollow.user', //Controller에서 요청 받을 주소
		type : 'post', //POST 방식으로 전달
		data : {
			userNum : userNum
		},
		cache : false,
		success : function(followerSu) {//컨트롤러에서 넘어온 cnt값을 받는다  
			alert("팔로우 성공")
			var bt = document.getElementsByName(userNum + 'follow');
			for (i = 0; i < bt.length; ++i) {
				bt[i].value = "팔로우취소";
				bt[i].onclick = function() {
					removeFollow(userNum);
				}
			}
		}
	});

};
	
var isStart = true;
var isEnd = false; 
var count = 6;
window.onscroll = function(e) {
	var boxHeight = document.getElementById('styleBoard').clientHeight;
	var listSize = Number(document.getElementById('listSize').value);
	if(listSize <= 3){
		isEnd = true;
	}
	if(window.pageYOffset >= boxHeight/3 && !isEnd && isStart) { 
		var div = document.getElementById('styleBoard');
	  	isStart = false;
	  	$.ajax({
	  		url : './styleFollowingScroll.user',
	  		type : 'post',
	  		data : {
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
	<input type="hidden" id="user_num" value="${sessionUser_num}">
	<input type="hidden" id="listSize" value="${listSize}">
	
<div id="styleBoard" align="center" class="basicFont">	
	<c:if test="${empty list}">
		팔로잉을 해주세요
	</c:if>
	
	
		<c:if test="${not empty list}">
			<c:set var="co" value="0"/>
			<c:forEach var="dto" items="${list}">
				<c:if test="${co < 3}">
				<table width="33%">
				<tr>
					<td rowspan="2">
						<a href="myProfile.user?user_num=${dto.user_num}">
						<img src="${upPath}/${dto.profile_img}" height="50" width="50"
						class="rounded-circle"
						onerror="this.src='https://blog.kakaocdn.net/dn/c3vWTf/btqUuNfnDsf/VQMbJlQW4ywjeI8cUE91OK/img.jpg'"></a></td>
					<td><a href="myProfile.user?user_num=${dto.user_num}">${dto.profile_name}</a></td>
					<td rowspan="2"><c:if test="${empty sessionUser_num}">
							<input type="button" value="팔로우" onclick="location.href='main.login'" class="btn btn-outline-dark">
						</c:if> <c:if test="${not empty sessionUser_num}">
							<!--int 1이면 팔로우 2면 팔로우취소 3이면 맞팔 -->
							<c:if test="${dto.checkFollowing==1}">
								<input type="button" id="${dto.user_num}follow"
									name="${dto.user_num}follow" value="팔로우 "
									onclick="addFollow('${dto.user_num}')" 
									class="btn btn-outline-dark"/>
							</c:if>
							<c:if test="${dto.checkFollowing==2}">
								<input type="button" id="${dto.user_num}follow"
									name="${dto.user_num}follow" value="팔로우취소 "
									onclick="removeFollow('${dto.user_num}')" 
									class="btn btn-outline-dark"/>
							</c:if>
							<c:if test="${dto.checkFollowing==3}">
								<input type="button" id="${dto.user_num}follow"
									name="${dto.user_num}follow" value="맞팔로우 "
									onclick="addFollow('${dto.user_num}')" 
									class="btn btn-outline-dark"/>
							</c:if>
						</c:if></td>
				</tr>
				<tr>
					<td><input type="text" id="time" name="time" class="basicFont"
						value="${dto.reg_date}" style="border: 0 solid black; color:grey" readOnly></td>
				<tr>
					<td colspan="3"><a
						href="styleView.user?styleNum=${dto.style_num}&userNum=${dto.user_num}"><img
							src="${upPath}/${dto.style_img1}" height="400" width="400"></a></td>
				</tr>

				<tr>
					<td colspan="3" align="center">
						<c:if test="${not empty sessionUser_num}">
							<c:if test="${dto.checkLike==2}">
								<i onclick = "addLike('${dto.style_num }')" style = "color:red; cursor:pointer" id = "like${dto.style_num }" class="bi bi-heart"></i>
							</c:if>
							<c:if test="${dto.checkLike==1}">
								<i onclick = "javascript:removeLike('${dto.style_num }')" style= "color:Red; cursor : pointer;" id = "like${dto.style_num }" class="bi bi-heart-fill"></i>
							</c:if>
						</c:if> 
						<c:if test="${empty sessionUser_num}">
							<i onclick = "location.href = main.login" style = "color:red; cursor:pointer" id = "like${dto.style_num }" class="bi bi-heart"></i>
						</c:if>
						<c:if test="${empty sessionUser_num}">
							<a href="main.login"><font color="blue">댓글</font></a>
						</c:if> <c:if test="${not empty sessionUser_num}">
							<a href="javascript:reply('${dto.style_num}')"><font color="blue">댓글</font></a>
						</c:if>
					</td>
				<tr>
					<td colspan="3" align="center">
					<a href="javascript:likeList('${dto.style_num}')"><font color="red">좋아요</font>
					<input type="text" id="${dto.style_num}" value="${dto.style_like}"
							size="1" style="border: 0 solid black" readOnly/><font color="red">개 </font>
					</a></td>
				</tr>
				<tr>
					<td colspan="3" align="center">
					<c:forEach var="content" items="${dto.contentList }">
							<c:forEach var="hashTagBaseDTO" items="${dto.hashTagList}">
								<c:if test="${content=='#' +=hashTagBaseDTO.hashTag_name}">
									<a href="javascript:sendHashTag('${hashTagBaseDTO.hashTag_name}')"><font color="blue">
								</c:if>
							</c:forEach>
							<c:forEach var="writerTag" items="${dto.writerList}">
								<c:if test="${content=='@'+=writerTag}">
									<a href="javascript:goMyProfile('${writerTag}')"><font color="green">
								</c:if>
							</c:forEach>
							${content}</font>
							</a>
						</c:forEach></td>
				</tr>
				<tr>
					<c:forEach var="dto" items="${dto.prod_tag_list}">
						<td align="center">
						<img src="${upPath}/${dto.prod_img1}" height="100" width="100"> <br>
							<h6>${dto.subject}</h6>
							<h6><fmt:formatNumber value="${dto.prod_price}"></fmt:formatNumber>원</h6></td>
					</c:forEach>

				</tr>
				</table>
				</c:if>
				<c:set var="co" value="${co+1}"/>
			</c:forEach>
			</c:if>
	
</div>
</body>
</html>
<%@include file="../../bottom.jsp"%>