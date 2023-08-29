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


	<div id="styleBoard" class="basicFont">
		<table>
			<c:set var="co" value="0" />
				<tr>
				<c:forEach var="dto" items="${List}">
					<c:if test="${co < count}">
					<c:if test="${dto.checkBan!=1}">
						<td><br> <a
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
						<c:set var="co" value="${co+1}" />
						<c:if test="${co%4==0}">
							</tr>
							<tr>
						</c:if>
					</c:if>
					</c:if>
				</c:forEach>
		</table>
	</div>


</body>
</html>