<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="top.jsp"%>
<script>
	function setConfirmSize(i) {
		var input = document.getElementById('selectSize');
		input.value = i;
		document.getElementById('confirm').disabled = false;
	}
	function checkSize() {
		var input = document.getElementById('selectSize');
		if (input.value == null || input.value == '') {
			alert('사이즈를 선택해 주세요 !')
			return;
		} else {
			document.f.submit();
		}
	}
</script>
<html>
<head>
<title>상품구매하기</title>
</head>
<form name="f" action="sellAgree.user" method="post">
	<div align="center" class="basicFont">
		<h3>판매등록</h3>
		<img src="${upPath}/${dto.prod_img1}" width="100px" height="100px">
		<br>${dto.prod_subject}<br> ${dto.prod_kr_subject}
	</div>
	<div class="size-popup" id="size-popup">
		<div class="modal-dialog">
			<div class="modal-content">
				<div align="center" class="basicFont">
				<h3 style="color: #585858;">사이즈선택</h3>
				<hr color="Black" style="width: 200pt; height: 1px;">
				<div id="sizeButton" class="container">
					<c:forEach var="prod" items="${prodList}">
						<c:set var="co" value="0"/>
							<c:forEach var="size" items="${sizeList}">
								<c:if test="${size eq prod.prod_size}">
									<input type="button" value="${prod.prod_size}" id="${prod.prod_size}"
										class="btn btn-outline-dark" disabled>
									<c:set var="co" value="${co+1}"/>
								</c:if>
							</c:forEach>
						<c:if test="${co == 0}">
							<input type="button" value="${prod.prod_size}" id="${prod.prod_size}"
								class="btn btn-outline-dark"
								onclick="setConfirmSize('${prod.prod_size}')">
						</c:if>
					</c:forEach>	
				</div>
					<h4 style="color: #585858;">선택된사이즈</h4>
					<input type="hidden" value="${dto.prod_num}" name="prod_group">
					<br> 
						<input	style="font-size: 18pt; text-align: center; width: 100pt; height: 50pt;"
							type="text" id="selectSize" name="prod_size" class="form-control"
							readonly /><br>
					<button type="button" id="confirm" class="btn btn-outline-dark"
						onclick="checkSize()" disabled>확인</button>
				</div>
			</div>
		</div>
	</div>
</form>
</div>
</html>
<%@include file="../../bottom.jsp"%>