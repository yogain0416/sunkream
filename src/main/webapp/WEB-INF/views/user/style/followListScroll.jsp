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
<div align="center" id="followDiv" class="basicFont">
	<c:if test="${empty list}">
	<h4>표시할 회원이 없습니다.</h4>
	</c:if>
	<c:if test="${not empty list}">
		<c:set var="co" value="0"/>
		<c:forEach var="dto" items="${list}">
			<c:if test="${co < count}">
			<table width="300" height="100">
				<tr>
				<td rowspan="2" width="100" height="100">
				<img src="${upPath}/${dto.profile_img}" height="100" width="100"
				class="rounded-circle"
				onerror="this.src='https://blog.kakaocdn.net/dn/c3vWTf/btqUuNfnDsf/VQMbJlQW4ywjeI8cUE91OK/img.jpg'">
				</td>
				<td align="center">
				<a href="javascript:goProfile('${dto.user_num}')"><font size="6px">${dto.profile_name}</font></a>
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
							class="btn btn-outline-dark" />
					</c:if>
					<c:if test="${dto.checkFollowing==2}">
						<input type="button" id="${dto.user_num}" name="${dto.user_num}"
							value="팔로우취소 " onclick="removeFollow('${dto.user_num}')"
							class="btn btn-outline-dark" />
					</c:if>
					<c:if test="${dto.checkFollowing==3}">
						<input type="button" id="${dto.user_num}" name="${dto.user_num}"
							value="맞팔로우 " onclick="addFollow('${dto.user_num}')"
							class="btn btn-outline-dark" />
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