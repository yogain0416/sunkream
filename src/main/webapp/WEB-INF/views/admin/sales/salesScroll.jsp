<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

		<div id="salesList" class = "basicFont">
			<table width="80%">
				<tr>
					<th width="70%">상품명</th>
					<th width="10%">갯수</th>
					<th width="20%">가격</th>
				</tr>
				<tr><td colspan="3"><hr></td></tr>
				<c:forEach var="dto" items="${list}">
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
				</c:forEach>
			</table>
		</div>



</body>
</html>