<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script>
$(document).ready(function() {
	var bt = document.getElementsByName('time');
	alert(bt.length)
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
</script>
<body>
<div id="styleBoard" align="center" class="basicFont">	
	<c:if test="${empty list}">
		팔로잉을 해주세요
	</c:if>
		<c:if test="${not empty list}">
			<c:set var="co" value="0"/>
			<c:forEach var="dto" items="${list}">
				<c:if test="${co < count}">
				<table width="33%">
				<tr>
					<td rowspan="2">
						<a href="myProfile.user?user_num=${dto.user_num}">
						<img src="${upPath}/${dto.profile_img}" height="50" width="50"
						class="rounded-circle"
						onerror="this.src='https://blog.kakaocdn.net/dn/c3vWTf/btqUuNfnDsf/VQMbJlQW4ywjeI8cUE91OK/img.jpg'"></a></td>
					<td><a href="myProfile.user?user_num=${dto.user_num}">${dto.profile_name}</a></td>
					<td rowspan="2"><c:if test="${empty sessionUser_num}">
							<input type="button" value="팔로우" onclick="location.href='main.login'">
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
						value="${dto.reg_date}" style="border: 0 solid black;color:gray;" readOnly></td>
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
							<input type="button" value="좋아요" onclick="location.href='main.login'">
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