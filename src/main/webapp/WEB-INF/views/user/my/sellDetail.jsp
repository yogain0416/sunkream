<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="top.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
	function prodView(){
		location.href = "prodView.user?prod_num="+$("#prod_group").val();
	}
	function selectBuy(){
		location.href = "selectBuy.user?sell_num="+${dto.sell_num}
	}
	$(document).ready(function(){
		if($("#auction").val() == 'Y'){
			var price = $("#buyAuctionPrice").val();
			var charge = price*0.1;
			$("#totalPrice").text(price - charge);
			$("#charge").text(charge);
		}
	});
</script>
<body>
<input type="hidden" id="prod_group" value="${dto.prod_group}">
<input type="hidden" id="prod_price" value="${dto.prod_price}">
<input type="hidden" id="auction" value="${dto.auction}">
<input type="hidden" id="buyAuctionPrice" value="${sellInfo.buy_price}">
<!-- 제목 -->
<div class="basicFont">
<div align="left">
	<div class="row">
		<div class="col">
			<font size="7px" face="돋움">판매 내역</font>
		</div>
	</div>
</div>
	
<!-- 상품 상세 -->	
<div align="left">
	<div class="row">
		<div class="col">
			<font size="5px">판매 번호</font> <font size="5px"><b>${dto.sell_num}</b></font>
			<hr style="border:1px solid;">
		</div>
	</div>
	<div class="row">
		<div class="col">
			<table>
				<tr>
					<td rowspan="2" width="20%"><img src="${upPath}/${dto.prod_img1}" width="100" height="100"></td>
					<td width="70%">${dto.prod_subject}</td>
					<td width="10%"><input type="button" value="상세보기" onclick="prodView()" class="btn btn-outline-dark"></td>
				</tr>
				<tr>
					<td>${dto.prod_size}</td>
				</tr>
			</table>
			<hr>
		</div>
	</div>
</div>	

<!-- 판매 금액 -->
<div align="left">
	<div class="row">
		<div class="col">
			<font size="5px"><b>판매 내역</b></font>
			<hr style="border:1px solid;">
		</div>
	</div>
	
	<!-- 판매 대기중 -->
	<c:if test="${dto.auction == 'W'}">
	<div class="row">
		<div class="col">
			<table width="100%">
				<tr>
					<th width="20%" bgcolor="#D3D3D3"><font size="3px">판매 희망가</font></th>
					<th width="80%" bgcolor="#D3D3D3"><font size="3px" color="red">${dto.prod_price}</font></th>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				<tr>
					<td width="20%"><font size="2px" color="gray">배송비</font></td>
					<td width="80%"><font size="2px">무료</font></td>
				</tr>
				<tr>
					<td width="20%"><font size="2px" color="gray">입찰 신청 가</font></td>
					<td width="80%"><font size="3px" color="green">
					<c:if test="${empty priceList}">
						입찰 신청이 없습니다.
					</c:if>
					<c:forEach var="list" items="${priceList}">
						${list.prod_price} &nbsp;
					</c:forEach>
					</font></td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				<tr>
					<td width="20%"><font size="2px">판매 기간</font></td>
					<td width="80%"><font size="2px">${dto.start_date} ~ ${dto.end_date}</font></td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
			</table>
		</div>
	</div>
	<div align="center">
		<c:if test="${not empty priceList}">
			<input type="button" value="낙찰하기" class="btn btn-outline-dark" onclick="selectBuy()">
		</c:if>
	</div>
	</c:if>
	
	<!-- 판매 종료 일때 -->
	<c:if test="${dto.auction == 'X'}">
	<div class="row">
		<div class="col">
			<table width="100%">
				<tr>
					<th width="20%" bgcolor="#D3D3D3"><font size="3px">판매 희망가</font></th>
					<th width="80%" bgcolor="#D3D3D3"><font size="3px" color="red">${dto.prod_price}</font></th>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				<tr>
					<td width="20%"><font size="2px" color="gray">배송비</font></td>
					<td width="80%"><font size="2px">무료</font></td>
				</tr>
				<tr>
					<td width="20%"><font size="2px" color="gray">입찰 신청 가</font></td>
					<td width="80%"><font size="2px">
					<c:if test="${empty priceList}">
						입찰 신청이 없습니다.
					</c:if>
					<c:forEach var="list" items="${priceList}">
						list.prod_price &nbsp;
					</c:forEach>
					</font></td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				<tr>
					<td width="20%"><font size="2px">판매 기간</font></td>
					<td width="80%"><font size="2px">${dto.start_date} ~ ${dto.end_date}</font></td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
			</table>
		</div>
	</div>
	</c:if>
	
	<!-- 판매 완료 일때 -->
	<c:if test="${dto.auction == 'Y'}">
	<div class="row">
		<div class="col">
			<table width="100%">
				<tr>
					<th width="20%" bgcolor="#D3D3D3"><font size="3px">구매 낙찰가</font></th>
					<th width="80%" bgcolor="#D3D3D3"><font size="3px" color="blue">${sellInfo.buy_price}</font></th>
				</tr>
				<tr>
					<th width="20%" bgcolor="#D3D3D3"><font size="3px">판매 희망가</font></th>
					<th width="80%" bgcolor="#D3D3D3"><font size="3px" color="red">${sellInfo.prod_price}</font></th>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				<tr>
					<td width="20%"><font size="2px" color="gray">배송비</font></td>
					<td width="80%"><font size="2px">무료</font></td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				<tr>
					<td width="20%"><font size="2px">판매일</font></td>
					<td width="80%"><font size="2px">${dto.sell_date}</font></td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
			</table>
		</div>
	</div>
	</c:if>
</div>

<!-- 반송 주소 -->
<div align="left">	
	<div class="row">
		<div class="col">
			<font size="5px"><b>반송 주소</b></font>
			<hr style="border:1px solid;">
		</div>
	</div>
	<div class="row">
		<div class="col">
			<table width="100%">
				<tr>
					<td width="20%"><font size="3px">반송인</font></td>
					<td width="80%"><font size="3px">${dto.name}</font></td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				<tr>
					<td width="20%"><font size="3px">휴대폰 번호</font></td>
					<td width="80%"><font size="3px">${dto.phone_num}</font></td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				<tr>
					<td width="20%"><font size="3px">반송주소</font></td>
					<td width="80%"><font size="3px">(${dto.address1})${dto.address2} ${dto.address3}</font></td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
			</table>
		</div>
	</div>
</div>	

<!-- 배송 주소 -->
<c:if test="${dto.auction == 'Y'}">
<div align="left">	
	<div class="row">
		<div class="col">
			<font size="5px"><b>배송 주소</b></font>
			<hr style="border:1px solid;">
		</div>
	</div>
	<div class="row">
		<div class="col">
			<table width="100%">
				<tr>
					<td width="20%"><font size="3px">받는사람</font></td>
					<td width="80%"><font size="3px">${sellInfo.name}</font></td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				<tr>
					<td width="20%"><font size="3px">휴대폰 번호</font></td>
					<td width="80%"><font size="3px">${sellInfo.phone_num}</font></td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				<tr>
					<td width="20%"><font size="3px">배송주소</font></td>
					<td width="80%"><font size="3px">(${sellInfo.address1})${sellInfo.address2} ${sellInfo.address3}</font></td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
			</table>
		</div>
	</div>
</div>	


<!-- 요청사항 -->	
<div align="left">	
	<div class="row">
		<div class="col">
			<font size="5px"><b>배송 요청 사항</b></font>
			<hr style="border:1px solid;">
		</div>
	</div>
	<div class="row">
		<div class="col">
			<table width="100%">
				<tr>
					<td width="20%"><font size="3px">요청 사항</font></td>
					<td width="80%"><font size="3px">${dto.needs}</font></td>
				</tr>
				<tr>
					<td colspan="2" width="100%"><hr></td>
				</tr>
			</table>
		</div>
	</div>	
</div>	
	
<!-- 결제정보 -->	
<div align="left">	
	<div class="row">
		<div class="col">
			<font size="5px"><b>결제 정보</b></font>
			<hr style="border:1px solid;">
		</div>
	</div>
	<div class="row">
		<div class="col">
			<table width="100%">
				<tr>
					<td width="20%"><font size="3px">결제 정보</font></td>
					<td width="80%"><font size="3px">${dto.bank_name} ${dto.card_num}</font></td>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
			</table>
		</div>
	</div>	
</div>		
</c:if>
<!-- 최종 주문 -->
<c:if test="${dto.auction == 'Y'}">
<div align="left">
	<div class="row">
		<div class="col">
			<font size="5px"><b>최종 주문 정보</b></font>
			<hr style="border:1px solid;">
		</div>
	</div>
	<div class="row">
		<div class="col">
			<table>
				<tr><th colspan="2" align="left">총 판매금액</th></tr>
				<tr><th colspan="2" align="right"><font size="7" color="Red" id="totalPrice"></font></th></tr>
				<tr><td align="left">구매가</td><td align="right">${sellInfo.buy_price}</td></tr>
				<tr><td align="left">수수료</td><td align="right"><font color="green" id="charge"></font></td></tr>
			</table>
		</div>
	</div>
	<hr>
</div>
</c:if>



<!-- 목록으로 -->	
<div align="center">
	<input type = "button" value="목록으로" onclick="history.back()" class="btn btn-outline-dark">
</div>	
</div>
</body>
</html>
<%@ include file="bottom.jsp"%>