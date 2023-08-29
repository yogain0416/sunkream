<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<div id="styleBoard" align ="center" class="basicFont">	
<c:if test="${empty list}">
표시할 게시글이 없습니다.
</c:if>
<c:if test="${not empty list}">
	<table width="30%" align="center">
		<c:set var="co" value="0" />
		<c:set var="number" value="1" />
		<tr>
			<c:forEach var="dto" items="${list}">
				<c:if test="${co < count}">
				<c:if test="${dto.checkBan!=1}">

					<td width="50%" align="center">
							<h2>${number}</h2> <c:set
							var="number" value="${number+1}"/>
					
					<table width="100%">
					<tr><td rowspan="2"><a
						href="myProfile.user?user_num=${dto.user_num}"> <img
							src="${upPath}/${dto.profile_img}" height="50" width="50"
							class="rounded-circle"
							onerror="this.src='https://blog.kakaocdn.net/dn/c3vWTf/btqUuNfnDsf/VQMbJlQW4ywjeI8cUE91OK/img.jpg'">
					</a></td><td><a
						href="myProfile.user?user_num=${dto.user_num}">${dto.profile_name}</a></td><td rowspan="2">
					<c:if test="${empty sessionUser_num}">
							<input type="button" value="팔로우" onclick="location.href='main.login'"
							class="btn btn-outline-dark">
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
						</c:if> 
					
					</td></tr>
					<tr><td width="200px">팔로워:
					<input type="text" value="${dto.followerSu}" style="border:none; width:30px;"
					name="followerSu${dto.user_num}" readOnly></td></tr>
					<tr><td colspan="3">
					 <a	href="styleView.user?styleNum=${dto.style_num}&userNum=${dto.user_num}"><img
							src="${upPath}/${dto.style_img1}" height="300" width="300"></a>
					</td></tr>
					<tr><td colspan="3"><i style = "color:red;cursor:pointer;" class="bi bi-balloon-heart"></i>:<input type="text" id="${dto.style_num}"
						value="${dto.style_like}" size="1" style="border: 0 solid black"
						readOnly /></td></tr>
					</table>
						</a> <br> </td>
					<c:set var="co" value="${co+1}" />
					<c:if test="${co%2==0}">
						</td>
					</tr>
					<tr>
			</c:if>
			</c:if>
			</c:if>
			</c:forEach>
	</table>
</c:if>
</div>

</body>
</html>