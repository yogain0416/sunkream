<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="home_top.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
.prodcontainer {
	display: flex;
	flex-wrap: wrap;
}
.imgContainer{
	padding : 1em;
	 font-family: 'Dovemayo_gothic';
}
@font-face {
    font-family: 'Dovemayo_gothic';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.1/Dovemayo_gothic.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
</style>
<script>
	function addList(num, pick_name,upPath,k) {
		var co = Number(num);
		var di = document.getElementById("prod"+k);
		while (di.firstChild) {
			di.removeChild(di.firstChild);
		}
		var di2 = document.getElementById("more"+k);
		while(di2.firstChild){
			di2.removeChild(di2.firstChild);
		}
		$.ajax({
			url : './shop_addList',
			data : {
				pick_name : pick_name
			},
			cache : false,
			success : function(list) {
				var count = 0;
				for(var i in list){
					count ++;
					var dt = list[i];
					var div1 = '<div class="imgContainer" align="center"> <a href = "prodView.user?prod_num='+dt.prod_num+'"> ';
					var img = '<img src = "'+upPath+'/'+dt.prod_img1+'" width = "250px" height = "250px"> </a> ';
					var div2 = '<h6> <a href = "prodView.user?prod_num='+dt.prod_num+'">'+dt.prod_subject+' </a> <br> ';
					var div3 = '<a href = "prodView.user?prod_num='+dt.prod_num+'">'+dt.prod_kr_subject+' </a> </h6> ';
				    var price = '<div class = "product__price"> '+dt.prod_price+'원</div> ';
					var cart = '<input type="button" name="cart" value="관심상품" class="btn btn-outline-dark" onclick="openSelectSize('+dt.prod_group+')">';
					var str = div1 + img + div2 + div3 + price + cart;
					$('#prod'+k).append(str);
					if(count == co){
						if (list.length > co) {
							var bt = document.createElement('input');
							bt.type = 'button';
							bt.className = 'btn btn-outline-dark';
							bt.value = '더보기';
							bt.onclick = function() {
								addList((co + 4), pick_name,upPath,k)
							}
							var div4='<div id = "append'+k+'" align = "center" > </div> </div>';
							$('#more'+k).append(div4);
							document.getElementById('append' + k).appendChild(bt);
						}
						break
					}
				}
				
			},
		});

	} 
	
	function openSelectSize(prod_group){
		var user_num = document.getElementById('user_num').value;
		if(user_num == ""){
			location.href = 'main.login'
			return
		}
		window.open('cartSelectSize.user?prod_group='+prod_group, ''
				, "width=600, height=300,scrollbars=yes, resizable=no, left=pixels");
	}
</script>
<html>
<head>
<meta charset="UTF-8">
<title>pickProdList</title>
</head>
<body>
	<input type="hidden" value="${sessionUser_num}" id="user_num">
	<c:if test="${not empty userMainList }">
		<section id="spad" class="shop spad">
			<div class="container">
				<div>
				<c:set var = "k" value = "0"/>
					<c:forEach var="tab" items="${tabList}">
						<c:set var = "k" value = "${k +1 }"/>
						<h5><b>${tab.pick_name }</b></h5>
						<h6>${tab.pick_kr_name }</h6>
						
						<!-- 상품 -->
						<div class="prodcontainer" id = "prod${k}">
							<c:set var="i" value="0"/>
							<c:forEach var="dto" items="${userMainList}">
								<c:if test="${tab.pick_name eq dto.pick_name}">
									<c:if test="${i < 4}">
										<div class="imgContainer" align="center">
											<a href="prodView.user?prod_num=${dto.prod_num }"> 
											<img src="${upPath }/${dto.prod_img1 }" width="250px" height="250px"></a>
											<h6>
												<a href="prodView.user?prod_num=${dto.prod_num }">${dto.prod_subject}</a>
												<br> <a href="prodView.user?prod_num=${dto.prod_num }">${dto.prod_kr_subject }</a>
											</h6>
											<div class="product__price">${dto.prod_price}원</div>
												<!-- 관심상품 -->
											<input type="button" name="cart" value="관심상품" class="btn btn-outline-dark"
												onclick="openSelectSize('${dto.prod_group}')">
									 	</div>
									</c:if>
									<c:set var="i" value="${i + 1}"/>
								</c:if>
								</c:forEach>
							</div>
							
							<!-- 더보기 -->
							<div id="more${k}">
							 	<c:if test="${i > 4}">
									<br>
									<div id="append${tab.pick_name}" align="center">
										<input type="button" value="더보기" class="btn btn-outline-dark"
											onclick="addList('8','${tab.pick_name}','${upPath }','${k }')">
									</div>
								</c:if> 
							</div>
						<hr>
					</c:forEach>
				</div>
			</div>
			</div>
		</section>
	</c:if>

</body>
</html>


<%@ include file="../../bottom.jsp"%>