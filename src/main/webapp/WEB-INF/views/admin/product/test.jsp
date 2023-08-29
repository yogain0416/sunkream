<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="prod_top.jsp"%>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<div class="div_container">
		<div class="div1" align="left">
			<div id="slideShow">
				<ul class="slides">
					<c:forEach var="img" items="${test }">
						<li><img src="${upPath }/${img}" alt="" width="500px"
							height="500px"></li>
					</c:forEach>
				</ul>
				<p class="controller">
					<span class="prev">&lang;</span> <span class="next">&rang;</span>
				</p>
			</div>
		</div>
		<div class="div4">
			<table border="1" width = "600" height="700" >
				<tr align="center">
					<td width = "30%">브랜드</td>
					<td>${dto.cate_kr_brand }</td>
				<tr>
				<tr align="center">
					<td width = "30%">대분류</td>
					<td>${dto.cate_kr_type }</td>
				<tr>
				<tr align="center">
					<td width = "30%">소분류</td>
					<td>${dto.cate_kr_subType }</td>
				<tr>
				
				<tr align="center">
					<td width = "30%">상품명</td>
					<td>${dto.prod_kr_name }</td>
				<tr>
				<tr align="center">
					<td width = "30%">상품색상</td>
					<td>${dto.prod_kr_color }</td>
				<tr>
				<tr align="center">
					<td width = "30%">상품가격</td>
					<td><fmt:formatNumber value ="${dto.prod_price }"></fmt:formatNumber>원<br></td>
				<tr>
			</table>
		</div>
	</div>
	
</body>
</html>