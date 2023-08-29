<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="top.jsp"%>
<link rel="stylesheet" href="resources/css/slide.css" type="text/css">
<html>
<head>
<meta charset="UTF-8">
<title>상품상세정보</title>
</head>
<style>
.tableBrand{
	text-decoration : underline;
	font-weight : bold;
}
</style>
<script type="text/javascript">
function openSelectSize(prod_group){
	var user_num = document.getElementById('user_num').value;
	if(user_num == ""){
		location.href = 'main.login'
		return
	}
	window.open('cartSelectSize.user?prod_group='+prod_group, ''
			, "width=600, height=300,scrollbars=yes, resizable=no, left=pixels");
}
	function checkPenalty(penalty){
		if(penalty >= 5){
			alert('패널티가 높습니다.관리자에게 문의하세요.')
			return
		}
		location.href='selectSizeSell.user?prod_num='+${dto.prod_num}
	}
$(document).ready(function(){
	if($("#user_num").val() == ''){
		$("#sell_bt").hide();
		//$("#buy_bt").css('padding','10px 220px');//하나일때
		$("#buy_bt").css('padding','10px 92.5px');
		$("#buyAuction_bt").css('padding','10px 92.5px');
	}
});
</script>
<body>
	<input type="hidden" value="${sessionUser_num}" id="user_num">
		<div class="prod_container">
			<div id="slideShow" align="left">
				<ul class="slides">
					<c:forEach var="img" items="${imgList}">
						<li>
						<img src="${upPath}/${img}" alt="" width="300px" height="300px"></li>
					</c:forEach>
				</ul>
				<p class="controller">
					<span class="prev">&lang;</span> <span class="next">&rang;</span>
				</p>
			</div>
		
		<div align="right" class="basicFont">
			<table class="prodViewTable" width="500px">
				<tr>
					<td colspan="4"><font class="tableBrand" size="5px"><a href="shop.user?searchString=${dto.cate_brand}">${dto.cate_brand}</a></font></td>
				</tr>
				<tr>
					<td colspan="4"><font size="5px">${dto.prod_subject}</font></td>
				</tr>
				<tr>
					<td colspan="4"><font color="gray" size="4px">${dto.prod_kr_subject}</font></td>
				</tr>
				<tr><td colspan="4" style="padding:0;"><hr></td></tr>
				<tr>
					<td colspan="2"><font color="gray" size="4px">상품가격</font></td>
					<th colspan="2" style="text-align:right;"><font size="5px"><fmt:formatNumber value="${dto.prod_price}"></fmt:formatNumber>원</font></th>
				</tr>
				<tr><td colspan="4" style="padding:0;"><hr></td></tr>
				<tr>
					<th colspan="4"><font size="5px">상품 정보</font></th>
				</tr>
				<tr><td colspan="4" style="padding:0;"><hr></td></tr>
				<tr>
					<td><font color="gray" size="3px">브랜드</font></td>
					<td><font color="gray" size="3px">대분류</font></td>
					<td><font color="gray" size="3px">소분류</font></td>
					<td><font color="gray" size="3px">색상</font></td>
				</tr>
				<tr>
					<th><font size="4px">${dto.cate_brand}</font></th>
					<th><font size="4px">${dto.cate_type}</font></th>
					<th><font size="4px">${dto.cate_subType}</font></th>
					<th><font size="4px">${dto.prod_color}</font></th>
				</tr>
				<tr><td colspan="4" style="padding:0;"><hr></td></tr>
			</table>
					
			<div class="row justify-content-center">
				<button type="button" id="cart_bt"
					class="btn btn-open btn-outline-primary" 
					style="margin: 5px; padding: 10px 220px;" 
					onclick="openSelectSize('${dto.prod_group}')">관심상품</button>
			</div>
			<div class="row justify-content-center">
				<!-- 즉시 구매 -->
				<button type="button" id="buy_bt"
					class="btn btn-open btn-outline-primary"
					style="margin: 2.5px; padding: 10px 50px;" 
					onclick = "location.href='selectSize.user?prod_num=${dto.prod_num}&mode=D'">즉시구매</button>
				
				<!-- 경매 구매 -->	
				<button type="button" id="buyAuction_bt"
					class="btn btn-open btn-outline-primary"
					style="margin: 2.5px; padding: 10px 50px;" 
					onclick = "location.href='selectSizeAuction.user?prod_num=${dto.prod_num}'">구매입찰</button>	
				
				<!-- 판매 등록 -->	
				<button type="button" id="sell_bt"
					class="btn btn-open btn-outline-primary"
					style="margin: 2.5px; padding: 10px 50px;" 
					onclick = "checkPenalty('${member.penalty}')">판매등록</button>
			</div>
		</div>
	</div>
</body>
</html>
<script src="resources/js/slides.js"></script>
<%@include file="../../bottom.jsp"%>
