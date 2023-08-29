<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="top.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	$(function() {
		//input을 datepicker로 선언
		$("#datepicker,#datepicker2").datepicker(
				{
					dateFormat : 'y/mm/dd' //달력 날짜 형태
					,
					showOtherMonths : true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
					,
					showMonthAfterYear : true // 월- 년 순서가아닌 년도 - 월 순서
					,
					changeYear : true //option값 년 선택 가능
					,
					changeMonth : true //option값  월 선택 가능                
					,
					showOn : "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
					,
					buttonImage : ""//"http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
					,
					buttonImageOnly : true //버튼 이미지만 깔끔하게 보이게함
					,
					buttonText : "" //버튼 호버 텍스트              
					,
					yearSuffix : "년" //달력의 년도 부분 뒤 텍스트
					,
					monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ] //달력의 월 부분 텍스트
					,
					monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월',
							'8월', '9월', '10월', '11월', '12월' ] //달력의 월 부분 Tooltip
					,
					dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ] //달력의 요일 텍스트
					,
					dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일', '금요일',
							'토요일' ] //달력의 요일 Tooltip
					,
					minDate : "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
					,
					maxDate : "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
				});

		//초기값을 오늘 날짜로 설정해줘야 합니다.
		$('#datepicker,#datepicker2').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            

	});
</script>

</head>
<body>
	<c:if test="${mode eq 'buy'}">
		<h4>구매내역</h4>
	</c:if>
	<c:if test="${mode eq 'sell'}">
		<h4>판매내역</h4>
	</c:if>
	<br>
	<br>
	<table width="90%">
		<tr>
			<td width="33%"><h4 align="center">${allListSu}</h4></td>
			<td width="33%"><h4 align="center">${waitSu}</h4></td>
			<td width="33%"><h4 align="center">${allListSu-waitSu}</h4></td>
		</tr>
		<tr>
			<td width="33%"><h5 align="center">전체</h5></td>
			<td width="33%"><h5 align="center">대기중</h5></td>
			<td width="33%"><h5 align="center">종료</h5></td>
		</tr>
	</table>
	<br>
	<br>

	<c:if test="${mode eq 'buy'}">
		<form name="f" method="post" action="buyList.user">
	</c:if>
	<c:if test="${mode eq 'sell'}">
		<form name="f" method="post" action="sellList.user">
	</c:if>

	<table>
		<tr>
			<td><input type="text" id="datepicker" name="cal1" readOnly></td>
			<td>~ <input type="text" id="datepicker2" name="cal2" readOnly></td>
			<td>
				<button type="submit">조회</button>
			</td>
		</tr>
	</table>
	</form>
	<br>
	<br>
	<br>
	<c:if test="${empty allList }">
내역이 없습니다.</c:if>
	<c:if test="${not empty allList }">
		<c:forEach var="dto" items="${allList}">
			<table border="1">
				<c:if test="${dto.auction eq 'D'}">
					<tr>
						<td rowspan="2"><img src="${upPath}/${dto.prod_img1}"
							height="50" width="50"></td>
						<td>상품명:(영어)${dto.prod_subject} <br>(한글)${dto.prod_kr_subject}
						</td>
						<td>구매일: ${dto.buy_date}</td>
						<td rowspan="2">구매완료</td>
					</tr>
					<tr>
						<td>사이즈:${dto.prod_size }</td>
						<td>가격:${dto.prod_price}</td>
					</tr>
				</c:if>
				<c:if test="${dto.auction eq 'W'}">
					<tr>
						<td rowspan="2"><img src="${upPath}/${dto.prod_img1}"
							height="50" width="50"></td>
						<td>상품명:(영어)${dto.prod_subject} <br>(한글)${dto.prod_kr_subject}
						</td>
						<td>입찰일: ${dto.start_date}</td>
						<td rowspan="2">대기중</td>
					</tr>
					<tr>
						<td>사이즈:${dto.prod_size }</td>
						<td><div class="product__price">가격:${dto.prod_price}</div></td>
					</tr>
				</c:if>

				<c:if test="${dto.auction eq 'Y'}">
					<tr>
						<td rowspan="2"><img src="${upPath}/${dto.prod_img1}"
							height="50" width="50"></td>
						<td>상품명:(영어)${dto.prod_subject} <br>(한글)${dto.prod_kr_subject}
						</td>
						<td>입찰일: ${dto.start_date} <br>구매일: ${dto.buy_date}
						</td>
						<td rowspan="2">낙찰 구매완료</td>
					</tr>
					<tr>
						<td>사이즈:${dto.prod_size }</td>
						<td>가격:${dto.prod_price}</td>
					</tr>
				</c:if>

				<c:if test="${dto.auction eq 'X'}">
					<tr>
						<td rowspan="2"><img src="${upPath}/${dto.prod_img1}"
							height="50" width="50"></td>
						<td>상품명:(영어)${dto.prod_subject} <br>(한글)${dto.prod_kr_subject}
						</td>
						<td>입찰일: ${dto.start_date}</td>
						<td rowspan="2">낙찰 구매실패</td>
					</tr>
					<tr>
						<td>사이즈:${dto.prod_size }</td>
						<td>가격:${dto.prod_price}</td>
					</tr>
				</c:if>
			</table>


		</c:forEach>
	</c:if>
</body>
</html>
<%@ include file="bottom.jsp"%>