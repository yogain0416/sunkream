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
<div id="cartListDiv" class="basicFont">
	<c:set var="co" value="0"/>
	<c:forEach var="dto" items="${cartList}">
		<c:if test="${co<count}">
		<div id="${dto.user_num}_${dto.prod_num}">
			<table>
				<tr>
					<td rowspan="4">
						<a href="prodView.user?prod_num=${dto.prod_group}"><img src="${upPath}/${dto.prod_img1}" width="100" height="100"></a></td>
					<th width="70%"><a href="shop.user?searchString=${dto.cate_brand}">${dto.cate_brand}</a></th>
					<td rowspan="3" align="right">
						<input type="button"  value="구매|${dto.prod_price}원" class="btn btn-outline-dark"
							onclick="location.href='buySellAgree.user?mode=D&prod_num=${dto.prod_num}&user_num=${sessionUser_num}'">
					</td>
				</tr>
				<tr>
					<td><a href="prodView.user?prod_num=${dto.prod_group}">${dto.prod_subject}</a></td>
				</tr>
				<tr></tr>
				<tr>
					<th>${dto.prod_size}</th>
					<td>
						<input type="button" value="삭제"  onclick="delCartList('${dto.user_num}','${dto.prod_num}')"
							class="btn btn-outline-dark" style="border:none; text-decoration: underline; font-size:15px;">
					</td>
				</tr>
			</table>
			<hr>
		</div>
		</c:if>
		<c:set var="co" value="${co+1}"/>	
	</c:forEach>
</div>
</body>
</html>