<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../admin_top.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<script type="text/javascript">
$(function() {
	//input을 datepicker로 선언
    var date = $("#cal1").val();
	var date2 = date.split("/")[2];
	var today = new Date(); 
	if(date2 == today.getDate()){
		document.getElementById('day').innerText = "오늘 매입매출";
	}else{
		document.getElementById('day').innerText = date+" 매입매출";
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
				/*showButtonPanel: true // 캘린더 하단에 버튼 패널을 표시한다. 
				,
				stepMonths: 1 // next, prev 버튼을 클릭했을때 얼마나 많은 월을 이동하여 표시하는가.
				,
				nextText: '◀' // next 아이콘의 툴팁.
				,
			    prevText: '▶' // prev 아이콘의 툴팁.
			    ,
			    closeText: 'X'  // 닫기 버튼 패널
			    , */
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
		$('#datepicker').datepicker('setDate', date); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            
	});

	function changeDay(e){
		location.href = 'sales.admin?date='+e.value;
	}
	
	var isStart = true;
	var isEnd = false; 
	var count = 12;
	window.onscroll = function(e) {
		var boxHeight = document.getElementById('salesList').clientHeight;
		var cal1 = document.getElementById('cal1').value;
		var mode = document.getElementById('mode').value;
		var listSize = Number(document.getElementById('listSize').value);
		if(listSize <= 6){
			isEnd = true;
		}
		if(window.pageYOffset >= boxHeight && !isEnd && isStart) { 
			var div = document.getElementById('salesList');
		  	isStart = false;
		  	$.ajax({
		  		url : './salesScroll.admin',
		  		type : 'post',
		  		data : {
		  			cal1 : cal1,
		  			mode : mode,
		  			count : count
		  		},
		  		cache : false,
		  		success : function(res) {
			  		while (div.firstChild) {
			  	    	div.removeChild(div.firstChild);
			  		}
			  		var html = jQuery('<div>').html(res);
			  		var contents = html.find("div#salesList").html();
			  		$("#salesList").html(contents);
			  		if(listSize <= count){
			  			isEnd = true;
			  		}else{
			  			isEnd = false;
			  			count += 9;
			  		}
			  		window.scrollBy(0, -100);
			  		isStart = true;
		  		},
		 	});
		}
	}
</script>
<body>
<input type="hidden" id="cal1" value="${cal1}">
<input type="hidden" id="mode" value="${mode}">
<input type="hidden" id="listSize" value="${listSize}">

<div align="center" id = "basicFont">


<!-- 제목 -->
<b><font size="10px" id="day"></font></b>

<!-- 일,월,연 매출 -->
<div class="row">
	<div class="col">
		<input type="button" value="일 매입매출" id="daily" class="btn btn-outline-dark"
			onclick="location.href='sales.admin'">
		<input type="button" value="월 매입매출" id="monthly" class="btn btn-outline-dark"
			onclick="location.href='salesMonthly.admin'">
		<input type="button" value="연 매입매출" id="yearly" class="btn btn-outline-dark"
			onclick="location.href='salesYearly.admin'">
	</div>
</div>

<!-- 달력 -->
<div class="row" style="margin-top:10px;">
	<div class="col">
		<input type="text" id="datepicker" name="cal1" 
			class="btn btn-outline-dark" size="8" onchange="changeDay(this)" readOnly>
	</div>
</div>


<!-- 차트 -->
<div class="row">
	<div class="col" style="width:50%;">
		<canvas id="myChart" width="300px" height="300px"></canvas>
	</div>
	<div class="col" style="width:50%;">
		<canvas id="myChart2" width="300px" height="300px"></canvas>
	</div>
	
</div>

<!-- 목록 -->
<hr>
<div class="row">
	<div class="col">
		<c:set var="total" value="${income - outcome}"/>
		<c:if test="${total >= 0}">
			<font size="8px" color="blue">이익 :<c:out value="${total}원"/></font>
		</c:if>
		<c:if test="${total < 0}">
			<font size="8px" color="red">손해 :<c:out value="${total*(-1)}원"/></font>
		</c:if>
	</div>
	<div class="col">
		<font size="8px" color="orange">매입 :<c:out value="${outcome}원"/></font>
	</div>
	<div class="col">
		<font size="8px" color="green">매출 :<c:out value="${income}원"/></font>
	</div>
</div>
<hr style="border:1px solid;">

<div class="row">
	<div class="col">
		<div id="salesList">
			<table width="80%">
				<tr>
					<th width="70%">상품명</th>
					<th width="10%">갯수</th>
					<th width="20%">가격</th>
				</tr>
				<tr><td colspan="3"><hr></td></tr>
				<c:set var="co" value="0"/>
				<c:forEach var="dto" items="${list}">
					<c:if test="${co < 6}">
						<tr>
							<td>${dto.prod_subject}<br>${dto.prod_kr_subject}</td>
							<td>${dto.prod_qty}개</td>
							<c:if test="${dto.sales_type == 'in' && dto.money_type == 'direct'}">
								<td><font color="blue"><fmt:formatNumber value="${dto.money}" type="number"/>원</font></td>
							</c:if>
							<c:if test="${dto.sales_type == 'in' && dto.money_type == 'charge'}">
								<td><font color="blue"><fmt:formatNumber value="${dto.money}" type="number"/>원(charge)</font></td>
							</c:if>
							<c:if test="${dto.sales_type == 'out'}">
								<td><font color="red"><fmt:formatNumber value="${dto.money}" type="number"/>원</font>
								(<font size="2px" color="green"><fmt:formatNumber value="${dto.money/dto.prod_qty}" type="number"/>원</font>)</td>
							</c:if>
						</tr>
						<tr><td colspan="3"><hr></td></tr>
					</c:if>
				</c:forEach>
			</table>
		</div>
	</div>
</div>



</div>	





<script type="text/javascript">
var today = new Date(); 
var cal1 = '${cal1}';
var cal2 = cal1.split("/")[2];

var context = document.getElementById('myChart').getContext('2d');
var myChart = new Chart(context,{
	type : 'pie',
	data : {
		labels : ["All","Male","Female"],
		datasets : [{
			label : '성별매출',
			backgroundColor : ["#2ecc71","#3498db","#f1c40f"],
			hoverBackgroundColor : ["#A6A6A6","#D1B2FF","#B2EBF4"],
			data : [${allCount},${mCount},${fCount}]
		}]
	},
	options : {
		responsive : false
	}
});
var context2 = document.getElementById('myChart2').getContext('2d');
var myChart2 = new Chart(context2,{
	type : 'bar',
	data : {
		labels : [cal2],
		datasets : [{
			label : '매출',
			backgroundColor : "rgba(153,255,51,1)",
			hoverBackgroundColor : "rgba(189,37,113,0.41)",
			data : [${outcome}]
		},{
			label : '매입',
			backgroundColor : "rgba(255,153,0,1)",
			hoverBackgroundColor : "rgba(34,49,186,0.42)",
			data : [${income}]
		}]
	},
	options : {
		responsive : false,
		  scales: {
              yAxes: [
                  {
                      ticks: {
                          beginAtZero: true
                      }
                  }
              ]
          }
	}
}); 


</script>
</body>
</html>
<%@ include file="../../bottom.jsp"%>