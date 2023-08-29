<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="top.jsp"%>
<%@ include file="sideBar_top.jsp" %>
<script>
function openSelectSize(prod_group){
	var user_num = document.getElementById('user_num').value;
	if(user_num == ""){
		location.href = 'main.login'
		return
	}
	window.open('cartSelectSize.user?prod_group='+prod_group, ''
			, "width=600, height=300,scrollbars=yes, resizable=no, left=pixels");
}
var isStart = true;
var isEnd = false; 
var count = 18;
window.onscroll = function(e) {
	var boxHeight = document.getElementById('product').clientHeight;
	var searchString = document.getElementById('searchString').value;
	var cate_kr_type = document.getElementById('cate_kr_type').value;
	var cate_kr_subType = document.getElementById('cate_kr_subType').value;
	var cate_brand = document.getElementById('cate_brand').value;
	var prod_size = document.getElementById('prod_size').value;
	var prod_gender = document.getElementById('prod_gender').value;
	var listSize = Number(document.getElementById('listSize').value);
	if(listSize <= 9){
		isEnd = true;
	}
	if(window.pageYOffset >= boxHeight/2 && !isEnd && isStart) { 
		var div = document.getElementById('product');
	  	isStart = false;
	  	$.ajax({
	  		url : './shopScroll.user',
	  		type : 'post',
	  		data : {
	  			searchString : searchString,
	  			cate_kr_type : cate_kr_type,
	  			cate_kr_subType : cate_kr_subType,
	  			prod_gender : prod_gender,
	  			prod_size : prod_size,
	  			cate_brand : cate_brand,
	  			count : count
	  		},
	  		cache : false,
	  		success : function(res) {
		  		while (div.firstChild) {
		  	    	div.removeChild(div.firstChild);
		  		}
		  		var html = jQuery('<div>').html(res);
		  		var contents = html.find("div#product").html();
		  		$("#product").html(contents);
		  		if(listSize <= count){
		  			isEnd = true;
		  		}else{
		  			isEnd = false;
		  			count += 9;
		  		}
		  		window.scrollBy(0, -300);
		  		isStart = true;
	  		},
	 	});
	}
}
</script>
<input type="hidden" id="user_num" value="${sessionUser_num}">
<input type="hidden" id="searchString" value="${searchString}">
<input type="hidden" id="cate_kr_type" value="${cate_kr_type}">
<input type="hidden" id="cate_kr_subType" value="${cate_kr_subType}">
<input type="hidden" id="listSize" value="${listSize}">
<input type="hidden" id="cate_brand" value="${cate_brand}">
<input type="hidden" id="prod_size" value="${prod_size}">
<input type="hidden" id="prod_gender" value="${prod_gender}">
<!-- 상품 보여주는곳 -->
<div class="col-lg-9 col-md-9" id="basicFont">
	<div class="row" id="product">
		<c:if test="${empty list}">
			<div>상품이 없습니다.</div>
		</c:if>
		<c:set value="0" var="co"/>	<!--상품 보여지는거 9개로 갯수 제한하기 -->
		<c:forEach var="dto" items="${list}">
			<c:if test="${co < 9}">
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
					

<%@ include file="sideBar_bottom.jsp" %>
<%@ include file="../../bottom.jsp"%>
