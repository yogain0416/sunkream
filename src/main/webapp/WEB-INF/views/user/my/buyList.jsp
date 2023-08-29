<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="top.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>
	function changeSearch(check){
		var cal1 = document.getElementById('cal1').value;
		var cal2 = document.getElementById('cal2').value;
		location.href='buyList.user?auction='+check+'&cal1='+cal1+'&cal2='+cal2;
	}
	$(function() {
		//input을 datepicker로 선언
	    var start_date = $("#cal1").val();
		var end_date = $("#cal2").val();
		if(start_date == ''){
			start_date = 'today';
			end_date = 'today';
		} 
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
		$('#datepicker').datepicker('setDate', start_date); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            
		$('#datepicker2').datepicker('setDate', end_date); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            
		
		if($('#auction').val() == 'W'){
			$("#all_hr_subject").css('border','');
			$("#wait_hr_subject").css('border','1px solid');
			$("#end_hr_subject").css('border','');
		}else if($('#auction').val() == 'end'){
			$("#all_hr_subject").css('border','');
			$("#wait_hr_subject").css('border','');
			$("#end_hr_subject").css('border','1px solid');
		}else{
			$("#all_hr_subject").css('border','1px solid');
			$("#wait_hr_subject").css('border','');
			$("#end_hr_subject").css('border','');
		}
		var cal = document.getElementsByName('cal');
		for(var i=0;i<cal.length;++i){
			cal[i].value = cal[i].value.split(' ')[0];
		}
	});
</script>

</head>
<body>
<div align="center" class="basicFont">
<div class="row">
	<div class="col">
			<h4>구매내역</h4>
	</div>
</div>
	<br>
	<br>
	
	
	<table width="90%">
		<tr>
			<td width="33%"><h4 align="center">${allListSu}</h4></td>
			<td width="33%"><h4 align="center">${waitSu}</h4></td>
			<td width="33%"><h4 align="center">${endSu}</h4></td>
		</tr>
		<tr>
			<td width="33%"><h5 align="center"><a href="javascript:changeSearch('all')">전체</a></h5>
				<hr id="all_hr_subject" style="border:1px solid;"></td>
			<td width="33%"><h5 align="center"><a href="javascript:changeSearch('W')">대기중</a></h5>
				<hr id="wait_hr_subject"></td>
			<td width="33%"><h5 align="center"><a href="javascript:changeSearch('end')">종료</a></h5>
				<hr id="end_hr_subject"></td>
		</tr>
	</table>
	<br>
	<br>
	
	<input type="hidden" id="cal1" value="${cal1}">
	<input type="hidden" id="cal2" value="${cal2}">

	<form name="f" method="post" action="buyList.user">
		<input type="hidden" id="auction" name="auction" value="${auction}">
	
	<table>
		<tr>
			<td><input type="text" id="datepicker" name="cal1" readOnly class="btn btn-outline-dark"></td>
			<td>~&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="datepicker2" name="cal2" readOnly class="btn btn-outline-dark"></td>
			<td>
				<button type="submit" class="btn btn-outline-dark">조회</button>
			</td>
		</tr>
	</table>
	</form>
	
	
	
	
	<br>
	<br>
	<br>
	<hr>
	<c:if test="${empty allList}">
		<font size="10px" color="black">내역이 없습니다.</font>
	</c:if>
	<c:if test="${not empty allList}">
		<c:forEach var="dto" items="${allList}">
			<table width="100%">
				<tr>
					<td rowspan="2" width="20%">
						<a href="prodView.user?prod_num=${dto.prod_group}"><img src="${upPath}/${dto.prod_img1}" height="50" width="50"></a>
					</td>
					<td rowspan="2" width="60%">
						<a href="buyDetail.user?buy_num=${dto.buy_num}&auction=${dto.auction}">
						<font size="3px" color="black">${dto.prod_subject}</font><br>
						<font size="3px" color="gray">${dto.prod_size}</font>
						<c:if test="${dto.auction == 'D'}">
							<br><font size="3px" color="gray">즉시구매가:${dto.prod_price}</font>
						</c:if>
						<c:if test="${dto.auction == 'W' || dto.auction == 'X'}">
							<br><font size="3px" color="gray">판매희망가:${dto.sell_price}</font>
							<br><font size="3px" color="gray">구매희망가:${dto.prod_price}</font>
						</c:if>
						<c:if test="${dto.auction == 'Y'}">
							<br><font size="3px" color="gray">판매희망가:${dto.sell_price}</font>
							<br><font size="3px" color="gray">구매확정가:${dto.prod_price}</font>
						</c:if>
						</a>
					</td>
					<td rowspan="2" width="20%">
						<font size="2px" color="gray">
							<c:if test="${dto.auction == 'D'}">
								구매일 :<input type="text" name="cal" value="${dto.buy_date}" 
								style="size:2px; color:gray; border:none;" readOnly>
							</c:if>
							<c:if test="${dto.auction == 'W' || dto.auction == 'X'}">
								입찰일 :<input type="text" name="cal" value="${dto.start_date}" 
								style="size:2px; color:gray; border:none;" readOnly>
							</c:if>
							<c:if test="${dto.auction == 'Y'}">
								구매일 :<input type="text" name="cal" value="${dto.buy_date}" 
								style="size:2px; color:gray; border:none;" readOnly>
							</c:if>
						</font>
					</td>
					<td rowspan="2" width="20%">
						<c:if test="${dto.auction == 'D'}">
							<font size="3px" color="blue">구매완료</font>
						</c:if>
						<c:if test="${dto.auction == 'W'}">
							<font size="3px" color="black">대기중</font>
						</c:if>
						<c:if test="${dto.auction == 'X'}">
							<font size="3px" color="red">구매실패</font>
						</c:if>
						<c:if test="${dto.auction == 'Y'}">
							<font size="3px" color="blue">구매완료</font>
						</c:if>
					</td>
				</tr>
			</table>
			<hr>
		</c:forEach>
	</c:if>
	</div>
</body>
</html>
<%@ include file="bottom.jsp"%>