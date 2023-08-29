<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="top.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="basicFont">
<!-- 포인트 -->
<div class="row">
	<div class="col">
		<font size = "7px" face="돋움"><b>포인트</b></font>
	</div>
	<div class="col" align="right">
		<font size = "8px" color = "red"><b>${point}P</b></font>
	</div>
</div>
<hr style="border:1px solid;">

<!-- 포인트 내역 -->
<div class="row">
	<div class="col">
		<table width="100%">
			<tr>
				<th width="80%"><font size="4px">상세 내역</font></th>
				<th width="20%"><font size="4px">적립/사용</font></th>
			</tr>
			<tr><td colspan="2"><hr></td></tr>
			<c:forEach var="dto" items="${list}">
					<c:if test="${dto.pointCheck == 'plus'}">
						<tr>
						<td width="80%"><font size="3px">${dto.prod_subject} ${dto.buy_date}</font></td>					
						<td width="20%"><font size="3px" color="blue">+${dto.point}</font></td>
						</tr>
						<tr><td colspan="2"><hr></td></tr>
					</c:if>
					<c:if test="${dto.pointCheck == 'minus' && dto.point != 0}">
						<tr>
						<td width="80%"><font size="3px">${dto.prod_subject} ${dto.buy_date}</font></td>
						<td width="20%"><font size="3px" color="red">-${dto.point}</font></td>
						</tr>
						<tr><td colspan="2"><hr></td></tr>
					</c:if>
			</c:forEach>
		</table>
	</div>
</div>
</div>

</body>
</html>
<%@ include file="bottom.jsp"%>