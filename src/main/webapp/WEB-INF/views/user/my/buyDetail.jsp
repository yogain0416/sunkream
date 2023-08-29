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
	$(document).ready(function(){
		var price = $("#prod_price").val();
		if($("#auction").val() == 'D'){
			var total = $("#prod_price").val() - $("#point").val();
			$("#totalPrice").text(total+'원');
			$("#finalTotalPrice").text(total+'원');
		}
		if($("#auction").val() == 'Y'){
			$("#finalTotalPrice").text(price+'원');
		}
		
	});
	function prodView(){
		location.href = "prodView.user?prod_num="+$("#prod_group").val();
	}
</script>
<body>
<input type="hidden" id="prod_group" value="${dto.prod_group}">
<input type="hidden" id="prod_price" value="${dto.prod_price}">
<input type="hidden" id="point" value="${dto.point}">
<input type="hidden" id="auction" value="${dto.auction}">
<!-- 제목 -->
<div class="basicFont">
<div align="left">
	<div class="row">
		<div class="col">
			<font size="7px" face="돋움">구매 내역</font>
		</div>
	</div>
</div>
	
<!-- 상품 상세 -->	
<div align="left">
	<div class="row">
		<div class="col">
			<font size="5px">주문번호</font> <font size="5px"><b>${dto.buy_num}</b></font>
			<hr style="border:1px solid;">
		</div>
	</div>
	<div class="row">
		<div class="col">
			<table width="100%">
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

<!-- 결제 금액 -->
<div align="left">
	<div class="row">
		<div class="col">
			<c:if test="${dto.auction == 'D'}">
				<font size="5px"><b>즉시 구매 내역</b></font>
				<hr style="border:1px solid;">
			</c:if>
			<c:if test="${dto.auction != 'D'}">
				<font size="5px"><b>구매 입찰 내역</b></font>
				<hr style="border:1px solid;">
			</c:if>
		</div>
	</div>
	
	<!-- 즉시 구매 일때 -->
	<c:if test="${dto.auction == 'D'}">
	<div class="row">
		<div class="col">
			<table width="100%">
				<tr>
					<th width="20%" bgcolor="#D3D3D3"><font size="3px">총 결제 금액</font></th>
					<th width="80%" bgcolor="#D3D3D3"><font size="3px" color="red" id="totalPrice"></font></th>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				<tr>
					<td width="20%"><font size="2px" color="gray">배송비</font></td>
					<td width="80%"><font size="2px">무료</font></td>
				</tr>
				<tr>
					<td width="20%"><font size="2px">상품 가격</font></td>
					<td width="80%"><font size="2px">${dto.prod_price}</font></td>
				</tr>
				<tr>
					<td width="20%"><font size="2px">포인트 사용</font></td>
					<td width="80%"><font size="2px">${dto.point}</font></td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				<tr>
					<td width="20%"><font size="2px">구매일</font></td>
					<td width="80%"><font size="2px">${dto.buy_date}</font></td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
			</table>
		</div>
	</div>
	</c:if>
	
	<!-- 구매입찰 대기중 일때 -->
	<c:if test="${dto.auction == 'W' || dto.auction == 'X'}">
	<div class="row">
		<div class="col">
			<table width="100%">
				<tr>
					<th width="20%" bgcolor="#D3D3D3"><font size="3px">구매 희망가</font></th>
					<th width="80%" bgcolor="#D3D3D3"><font size="3px" color="blue">${dto.prod_price}</font></th>
				</tr>
				<tr>
					<th width="20%" bgcolor="#D3D3D3"><font size="3px">판매 희망가</font></th>
					<th width="80%" bgcolor="#D3D3D3"><font size="3px" color="red">${dto.sell_price}</font></th>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				<tr>
					<td width="20%"><font size="2px" color="gray">배송비</font></td>
					<td width="80%"><font size="2px">무료</font></td>
				</tr>
				<tr>
					<td width="20%"><font size="2px">포인트 사용</font></td>
					<td width="80%"><font size="2px">X</font></td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				<tr>
					<td width="20%"><font size="2px">입찰일</font></td>
					<td width="80%"><font size="2px">${dto.start_date}</font></td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
			</table>
		</div>
	</div>
	</c:if>
	
	<!-- 구매입찰 완료 일때 -->
	<c:if test="${dto.auction == 'Y'}">
	<div class="row">
		<div class="col">
			<table width="100%">
				<tr>
					<th width="20%" bgcolor="#D3D3D3"><font size="3px">구매 낙찰가</font></th>
					<th width="80%" bgcolor="#D3D3D3"><font size="3px" color="blue">${dto.prod_price}</font></th>
				</tr>
				<tr>
					<th width="20%" bgcolor="#D3D3D3"><font size="3px">판매 희망가</font></th>
					<th width="80%" bgcolor="#D3D3D3"><font size="3px" color="red">${dto.sell_price}</font></th>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				<tr>
					<td width="20%"><font size="2px" color="gray">배송비</font></td>
					<td width="80%"><font size="2px">무료</font></td>
				</tr>
				<tr>
					<td width="20%"><font size="2px">포인트 사용</font></td>
					<td width="80%"><font size="2px">X</font></td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				<tr>
					<td width="20%"><font size="2px">구매일</font></td>
					<td width="80%"><font size="2px">${dto.buy_date}</font></td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
			</table>
		</div>
	</div>
	</c:if>
</div>

<!-- 배송 주소 -->
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
					<td width="20%"><font size="3px">받는 사람</font></td>
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
					<td width="20%"><font size="3px">주소</font></td>
					<td width="80%"><font size="3px">(${dto.address1})${dto.address2} ${dto.address3}</font></td>
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
				<c:if test="${dto.card_date == 'cash'}">
					<tr>
						<td width="20%"><font size="3px">결제 정보</font></td>
						<td width="80%"><font size="3px">${dto.bank_name} ${dto.card_num}</font></td>
					</tr>
				</c:if>
				<c:if test="${dto.card_date != 'cash'}">
					<tr>
						<td width="20%"><font size="3px">결제 정보</font></td>
						<td width="80%"><font size="3px">${dto.bank_name} ${dto.card_num} ${dto.card_date}</font></td>
					</tr>
				</c:if>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
			</table>
		</div>
	</div>	
</div>		
<!-- 최종 주문 -->
<c:if test="${dto.auction == 'D' || dto.auction == 'Y'}">
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
				<tr><th colspan="2" align="left">총 결제금액</th></tr>
				<tr><th colspan="2" align="right"><font size="7" color="Red" id="finalTotalPrice"></font></th></tr>
				<tr><td align="left">구매가</td><td align="right">${dto.prod_price}</td></tr>
				<tr><td align="left">포인트</td><td align="right" id="usingPoint">${dto.point}</td></tr>
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