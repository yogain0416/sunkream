<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shopScroll</title>
</head>
<body>
<div class="col-lg-9 col-md-9" id="basicFont">
	<div class="row" id="product">
		<c:if test="${empty list}">
			<div>상품이 없습니다.</div>
		</c:if>
		<c:set value="0" var="co"/>
		<c:forEach var="dto" items="${list}">
			<c:if test="${co < count}">
				<div class="col-lg-4 col-md-6">
					<div class="product__item">
						<div class="product__item__text">
							<a href="prodView.user?prod_num=${dto.prod_num }">
							<img src="${upPath }/${dto.prod_img1}" width="100px" height="100px"></a>
							<h6>${dto.prod_subject}<br>${dto.prod_kr_subject}</h6>
							<div class="product__price">
							<fmt:formatNumber value="${dto.prod_price}"></fmt:formatNumber>원
							</div>
							<input type="button" id="cartBt${dto.prod_num}" value="관심:${dto.cartCount}" 
								class="btn btn-outline-dark" onclick="openSelectSize('${dto.prod_group}')">
							<input type="hidden"  id="cart${dto.prod_num}" value="${dto.cartCount}">
							<input type="button" value="태그:${dto.tagCount}" 
								class="btn btn-outline-dark" onclick="location.href='showTagStyle.user?prod_group=${dto.prod_group}'">
						</div>
					</div> 
				</div>
				<c:set value="${co+1}" var="co"/>
			</c:if>
		</c:forEach>
	</div>
</div>
</body>
</html>