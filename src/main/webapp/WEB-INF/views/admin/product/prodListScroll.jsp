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
<body>


			<div class="row" id="product">
				<!-- 상품 없을때 -->
				<c:if test="${empty list}">
					<div>상품이 없습니다.</div>
				</c:if>
				
				<!-- 상품 -->
				<c:set var="co" value="0"/>
				<c:forEach var="dto" items="${list}">
					<c:if test="${co < count}">
					<div class="col-lg-4 col-md-6">
						<div class="product__item">
							<div class="product__item__text">
								<a href="prodEdit.admin?prod_num=${dto.prod_num }">
									<img src="${upPath}/${dto.prod_img1}" width="100px" height="100px">
									<h6>${dto.prod_subject}<br>${dto.prod_kr_subject}</h6>
									</a>
									<fmt:formatNumber value="${dto.prod_price}"></fmt:formatNumber>원
							</div>
						</div>
					</div>
					</c:if>
					<c:set var="co" value="${co+1}"/>
				</c:forEach>
				
			</div>
			
</body>
</html>