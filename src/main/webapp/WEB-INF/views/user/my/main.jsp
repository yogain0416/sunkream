<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="top.jsp"%>
<script>
var check = 5;
function delCartList(user_num,prod_num,count){
		$.ajax({
			url : './delCart.user',
			type : 'post',
			data : {
				user_num : user_num,
				prod_num : prod_num
			},
			cache : false,
			success : function(res) {
				var parent = document.getElementById('cartListDiv');
				var div = document.getElementById(count);
				parent.removeChild(div);
				var div2 = document.getElementById(check);
				div2.style.display = 'block';
				++check;
			}
		});
	}
</script>
<div align="center" class="basicFont">
	<table>
		<tr>
			<td rowspan="2">
				<img src="${upPath}/${myProfile.profile_img}" width="100",height="100"
				class="rounded-circle"
				onerror="this.src='https://blog.kakaocdn.net/dn/c3vWTf/btqUuNfnDsf/VQMbJlQW4ywjeI8cUE91OK/img.jpg'">
			</td>
			<td>프로필 이름 : ${myProfile.profile_name}</td>
			<td rowspan="2">포인트 : ${myProfile.point}P</td>
		</tr>
		<tr>
			<td>이메일 주소 : ${myProfile.email}</td>
		</tr>
	</table>
	<br> <br> <br> 
	<table width="90%"><tr><td><h4 align="left">구매내역</h4></td><td><h6 align="right"><a href="buyList.user">더보기</a></h6></td></tr></table>
	<table border="1" width="90%">
		<tr>
			<th width="33%">전체</th>
			<th width="33%">대기중</th>
			<th width="33%">종료</th>
		</tr>
		<tr>
			<c:set value="0" var="coAll" />
			<c:set value="0" var="coWait" />
			<c:set value="0" var="coEnd" />
			<c:forEach var="buy" items="${buyList}">
				<c:set value="${coAll+1}" var="coAll" />
				<c:if test="${buy.auction == 'W'}">
					<c:set value="${coWait+1}" var="coWait" />
				</c:if>
				<c:if test="${buy.auction != 'W'}">
					<c:set value="${coEnd+1}" var="coEnd" />
				</c:if>
			</c:forEach>
			<td>${coAll}</td>
			<td>${coWait}</td>
			<td>${coEnd}</td>
		</tr>
	</table>
	<br> <br> <br> <table width="90%"><tr><td><h4 align="left">판매내역</h4></td><td><h6 align="right"><a href="sellList.user">더보기</a></h6></td></tr></table>
	<table border="1" width="90%">
		<tr>
			<th width="33%">전체</th>
			<th width="33%">대기중</th>
			<th width="33%">종료</th>
		</tr>
		<tr>
			<c:set value="0" var="coAll" />
			<c:set value="0" var="coWait" />
			<c:set value="0" var="coEnd" />
			<c:forEach var="sell" items="${sellList}">
				<c:set value="${coAll+1}" var="coAll" />
				<c:if test="${sell.auction == 'W'}">
					<c:set value="${coWait+1}" var="coWait" />
				</c:if>
				<c:if test="${sell.auction != 'W'}">
					<c:set value="${coEnd+1}" var="coEnd" />
				</c:if>
			</c:forEach>
			<td>${coAll}</td>
			<td>${coWait}</td>
			<td>${coEnd}</td>

		</tr>
	</table>
	<br> <br> <br>
	<table width="90%">
		<tr>
		<td><h4 align="left">관심상품</h4></td>
		<td><h6 align="right"><a href="cartList.user">더보기</a></h6></td>
		</tr>
	</table>
	</div>
	<div class="container" id="basicFont">
		<div class="row" id="cartListDiv">
			<c:set var="count" value="0"/>
			<c:forEach items="${cartList}" var="cart">
				<c:set var="count" value="${count+1}"/>
				<c:if test="${count>4}">
					<div class="col" id="${count}" style="display:none;">
				</c:if>
				<c:if test="${count<=4}">
					<div class="col" id="${count}" >
				</c:if>
					<table width="20%" align="center">
						<tr>
							<td><a href="prodView.user?prod_num=${cart.prod_group}">
							<img src="${upPath}/${cart.prod_img1}" width="100" height="100">
							</a></td>
						</tr>
						<tr>
							<td><input type="button" value="★관심상품" class="btn btn-outline-dark"
								onclick="delCartList('${cart.user_num}','${cart.prod_num}','${count}')">
							</td>
						</tr>
						<tr>
							<td>
							<a href="prodView.user?prod_num=${cart.prod_group}">
							<font style="font-size:12px; font-weight:bold;">${cart.cate_brand}</font><br>
							<font style="font-size:10px;">${cart.prod_subject}</font><br>
							<font style="font-size:12px;">${cart.prod_size}</font><br>
							<font style="font-size:12px; font-weight:bold;">${cart.prod_price}원</font><br>
							</a>
							</td>
						</tr>
					</table>
				</div>
			</c:forEach>
		</div>
	
</div>
<%@ include file="bottom.jsp"%>





