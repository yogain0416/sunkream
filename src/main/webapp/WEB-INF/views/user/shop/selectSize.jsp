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
<form name="f" action="buySellAgree.user" method="post">
	<div align="center" class="basicFont">
		<h3>구매상품</h3>
		<img src="${upPath }/${dto.prod_img1}" width="100px" height="100px">
		<br>${dto.prod_subject }<br>${dto.prod_kr_subject }
	</div>
	<div class="size-popup" id="size-popup">
		<div class="modal-dialog">
			<div class="modal-content">
				<div id="sizeButton" class="container">
					<div align="center" class="basicFont">
					<h3 style="color: #585858;">사이즈선택</h3>
				<hr color="Black" style="width: 200pt; height: 1px;">
					<c:if
						test="${dto.cate_kr_type eq '상의' || dto.cate_kr_type eq '하의' || dto.cate_kr_type eq '아우터' }">
						<c:forEach var="dto" items="${list }">
							<c:if test="${dto.prod_qty == 0 && dto.prod_size != '0' }">
								<input type="button" class="btn btn-outline-dark"
									id="${dto.prod_size }" value="${dto.prod_size }" disabled />
							</c:if>
							<c:if test="${dto.prod_qty != 0 && dto.prod_size != '0'}">
								<input type="button" class="btn btn-outline-dark" 
									onclick="setConfirmSize('${dto.prod_size}')"
									id="${dto.prod_size }" value="${dto.prod_size }" />
							</c:if>
						</c:forEach>
					</c:if>
					<c:if test="${dto.cate_kr_type eq '신발' }">
						<c:forEach var="i" begin="220" end="300" step="5">
							<c:forEach var="dto" items="${list }">
								<c:if test="${dto.prod_size == i && dto.prod_qty == 0 }">
									<input type="button" class="btn btn-outline-dark" id="${i}"
										value="${i}" disabled />
								</c:if>
								<c:if test="${dto.prod_size == i && dto.prod_qty != 0 }">
									<input type="button" class="btn btn-outline-dark" id="${i}"
										value="${i}" onclick="setConfirmSize('${i}')" />
								</c:if>
							</c:forEach>
						</c:forEach>
					</c:if>
					<c:if
						test="${dto.cate_kr_type != '상의' && dto.cate_kr_type != '하의' && dto.cate_kr_type != '아우터' && dto.cate_kr_type != '신발'  }">
						<c:forEach var="dto" items="${list }">
							<c:if test="${dto.prod_size != '0' && dto.prod_qty ==0 }">
								<input type="button" class="btn btn-outline-dark"
									id="${dto.prod_size }" value="${dto.prod_size }" disabled />
							</c:if>
							<c:if test="${dto.prod_size != '0' && dto.prod_qty != 0 }">
								<input type="button" class="btn btn-outline-dark" onclick="setConfirmSize('${dto.prod_size}')" 
									 id="${dto.prod_size }" value="${dto.prod_size }" />
							</c:if>
						</c:forEach>
					</c:if>
				<h4 style="color: #585858;">선택된사이즈</h4>
					<input type="hidden" value="${mode}" name="mode">
					<input type="hidden" value="${dto.prod_num}" name="prod_num">
					<br>
					<input style="font-size: 18pt; text-align: center; width: 100pt; height: 50pt;"
						type="text" id="selectSize" name="selectSize" class="form-control"
						readonly />
					<br>
					<button type="button" id="confirm" class="btn btn-outline-dark"
						onclick="checkSize()" disabled>확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>
</div>
</html>
<%@include file="../../bottom.jsp"%>