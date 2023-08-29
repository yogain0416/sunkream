<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="user/home/main_top.jsp"%>
<div class="col-lg-9 col-md-9">
	<div class="row">
		<c:if test="${empty list }">
			<div>상품이 없습니다.</div>
		</c:if>
		<c:forEach var="dto" items="${list }">
			<div class="col-lg-4 col-md-6">
				<div class="product__item">
					<div class="product__item__text">
						<a href="prodEdit.admin?prod_num=${dto.prod_num }"><img
							src="${upPath }/${dto.prod_img1}" width="100px" height="100px"></a>
						<h6>
							<a href="#">${dto.prod_subject }</a>
						</h6>
						<div class="product__price">
							<fmt:formatNumber value="${dto.prod_price }"></fmt:formatNumber>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
<%@ include file="bottom.jsp"%>