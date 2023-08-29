<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
	function delCartList(user_num,prod_num){
		$.ajax({
			url : './delCart.user',
			type : 'post',
			data : {
				user_num : user_num,
				prod_num : prod_num
			},
			cache : false,
			success : function(res) {
				var id = user_num+"_"+prod_num;
				var parent = document.getElementById('cartListDiv');
				var child = document.getElementById(id);
				parent.removeChild(child);
			}
		});
	}
	
	var isStart = true;
	var isEnd = false; 
	var count = 18;
	window.onscroll = function(e) {
		var boxHeight = document.getElementById('cartListDiv').clientHeight;
		var user_num = document.getElementById('user_num').value;
		var listSize = Number(document.getElementById('listSize').value);
		if(listSize <= 9){
			isEnd = true;
		}
		if(window.pageYOffset >= boxHeight/2 && !isEnd && isStart) { 
			var div = document.getElementById('cartListDiv');
		  	isStart = false;
		  	$.ajax({
		  		url : './cartListScroll.user',
		  		type : 'post',
		  		data : {
		  			user_num : user_num,
		  			count : count
		  		},
		  		cache : false,
		  		success : function(res) {
			  		while (div.firstChild) {
			  	    	div.removeChild(div.firstChild);
			  		}
			  		var html = jQuery('<div>').html(res);
			  		var contents = html.find("div#cartListDiv").html();
			  		$("#cartListDiv").html(contents);
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
<body>
<input type="hidden" id="user_num" value="${sessionUser_num}">
<input type="hidden" id="listSize" value="${listSize}">
<h3>관심 상품</h3>
<hr style="border:1px solid;">
<!-- 관심상품 -->
<div id="cartListDiv" class="basicFont">
	<c:set var="co" value="0"/>
	<c:forEach var="dto" items="${cartList}">
		<c:if test="${co <9}">
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
<%@include file="bottom.jsp" %>