<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
@font-face {
    font-family: 'Dovemayo_gothic';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.1/Dovemayo_gothic.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
.basicFont{
	font-family: 'Dovemayo_gothic';
}
#basicFont{
	font-family: 'Dovemayo_gothic';
}
</style>
<link rel="stylesheet" href="resources/css/bootstrap.min.css"
   type="text/css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script type="text/javascript">
	function addCartList(user_num,prod_num,size,prod_group){
		$.ajax({
			url : './addCart.user',
			type : 'post',
			data : {
				user_num : user_num,
				prod_group : prod_group,
				prod_num : prod_num
			},
			cache : false,
			success : function(res) {
				var bt = document.getElementById(size);
				bt.value = "★"+size;
				bt.onclick = function(){
					delCartList(user_num,prod_num,size,prod_group);
				}
				if(window.opener.document.getElementById('cart'+prod_group)){
					var cart = Number(window.opener.document.getElementById('cart'+prod_group).value);
					cart = cart + 1;
					window.opener.document.getElementById('cart'+prod_group).value = cart;
					window.opener.document.getElementById('cartBt'+prod_group).value = "관심:"+cart;
				}
			}
		});
	}

	function delCartList(user_num,prod_num,size,prod_group){
		$.ajax({
			url : './delCart.user',
			type : 'post',
			data : {
				user_num : user_num,
				prod_group : prod_group,
				prod_num : prod_num
			},
			cache : false,
			success : function(res) {
				var bt = document.getElementById(size);
				bt.value = "☆"+size;
				bt.onclick = function(){
					addCartList(user_num,prod_num,size,prod_group);
				}
				if(window.opener.document.getElementById('cart'+prod_group)){
					var cart = Number(window.opener.document.getElementById('cart'+prod_group).value);
					cart = cart - 1;
					window.opener.document.getElementById('cart'+prod_group).value = cart;
					window.opener.document.getElementById('cartBt'+prod_group).value = "관심:"+cart;
				}
			}
		});
	}
</script>
<body>
<div align="center" class="basicFont"><h2>관심 상품 추가</h2>
	<c:forEach var="prod" items="${productList}">
		<c:set var="co" value="0"/>
		<c:forEach var="cart" items="${cartList}">
			<c:if test="${cart.prod_num eq prod.prod_num}">
				<input type="button" value="★${prod.prod_size}" id="${prod.prod_size}"
					class="btn btn-outline-dark"
					onclick="delCartList('${cart.user_num}','${cart.prod_num}','${prod.prod_size}','${prod.prod_group}')">
				<c:set var="co" value="${co+1}"/>
			</c:if>
		</c:forEach>
		
		<c:if test="${co == 0}">
			<input type="button" value="☆${prod.prod_size}" id="${prod.prod_size}"
				class="btn btn-outline-dark"
				onclick="addCartList('${sessionUser_num}','${prod.prod_num}','${prod.prod_size}','${prod.prod_group}')">
		</c:if>
	</c:forEach>	
		<div align="center" class="basicFont">
			<button type="button" id="sizepop"
				class="btn btn-open btn-outline-primary"
				style="margin-bottom: 5px;" onclick="self.close()">확인</button>
		</div>
</div>		
</body>
</html>