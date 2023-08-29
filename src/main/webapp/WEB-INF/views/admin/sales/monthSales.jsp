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
<font size="10px"><b>${month}월 매입 매출</b></font>

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



<!-- 차트 -->
<div class="row">
	<div class="col" style="width:60%;">
		<canvas id="myChart"></canvas>
	</div>
	<!-- <div class="col" style="width:50%;">
		<canvas id="myChart2" width="300px" height="300px"></canvas>
	</div> -->
	
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
var last = new Date(today.getYear(),today.getMonth()+1,0);
var lastDay = last.getDate();
var days = new Array();

for(i=1;i<=lastDay;++i){
	j = String(i);
	if(i<10) days[i-1] = '0'+j;
	else days[i-1] = j;
}

var list = new Array();
<c:forEach items="${list}" var="dto">
	list.push({
		sales_type : '${dto.sales_type}',
		reg_date : '${dto.reg_date}',
		money : Number('${dto.money}')
	});
</c:forEach>

var outcome = new Array();
var income = new Array();
var total = new Array();
var check = ${income}-${outcome};
var backgroundColor = "";
var hoverBackgroundColor = "";
var borderColor = "";

if(check>=0){
	backgroundColor = "rgba(0,0,255,1)";
	hoverBackgroundColor = "rgba(100,100,255,0.42)";
	borderColor = "rgba(0,0,255,1)";
}else{
	backgroundColor = "rgba(255,0,0,1)";
	hoverBackgroundColor = "rgba(255,100,100,0.42)";
	borderColor = "rgba(255,0,0,1)";
}



for(i=1;i<=lastDay;++i){
	var j = String(i);
	if(i<10) j = '0'+j;
	outcome[i-1] = 0;
	income[i-1] = 0;
	total[i-1] = 0;
	for(k=0;k<list.length;++k){
		if(list[k].sales_type == 'out'){
			var reg_date = list[k].reg_date;
			var day = reg_date.split("/")[2].split(" ")[0];
			if(day == j) outcome[i-1] += list[k].money;
		}
		if(list[k].sales_type == 'in'){
			var reg_date = list[k].reg_date;
			var day = reg_date.split("/")[2].split(" ")[0];
			if(day == j) income[i-1] += list[k].money;
		}
		total[i-1] = income[i-1] - outcome[i-1];
	}
}
var context = document.getElementById('myChart').getContext('2d');
var myChart = new Chart(context, {
    type: 'line', // 차트의 형태
    data: { // 차트에 들어갈 데이터
        labels: days,
        datasets: [
            { //데이터
                label: '매출', //차트 제목
                fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
                data: outcome,
                backgroundColor : "rgba(153,255,51,1)",
    			hoverBackgroundColor : "rgba(189,37,113,0.41)",
    			borderColor : "rgba(153,255,51,1)",
                borderWidth: 1 //경계선 굵기
            },
            { //데이터
                label: '매입', //차트 제목
                fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
                data: income,
                backgroundColor : "rgba(255,153,0,1)",
    			hoverBackgroundColor : "rgba(34,49,186,0.42)",
    			borderColor : "rgba(255,153,0,1)",
                borderWidth: 1 //경계선 굵기
            },
            { //데이터
                label: '손익', //차트 제목
                fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
                data: total,
                backgroundColor : backgroundColor,
    			hoverBackgroundColor : hoverBackgroundColor,
    			borderColor : borderColor,
                borderWidth: 2 //경계선 굵기
            }
        ]
    },
    options: {
    	title: {
            display: true,
            text: '월 매입 매출 그래프',
            fontStyle : 'bold',
            position : 'bottom'
        },
        legend: {
            labels: {
                // 이 더 특정한 폰트 속성은 전역 속성을 덮어씁니다
                fontColor: 'black'
            }
        },
        scales: {
        	yAxes: [{
				ticks: {
					beginAtZero: true,
				}
			}]
        }
    }
});
</script>
</body>
</html>
<%@ include file="../../bottom.jsp"%>