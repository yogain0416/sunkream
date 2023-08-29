<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Address</title>
</head>
<script type="text/javascript">
	function addCard(co){
		if(co >= 3){
			alert('카드는 3개까지 등록 가능합니다.')
			return
		}
		window.open('addCard.user', '',"width=720, height=780,scrollbars=yes, resizable=no, left=pixels");
	}
	
	function changeBasicCard(myCard_num,user_num){
		location.href = "changeBasicCard.user?myCard_num="+myCard_num+"&user_num="+user_num;
	}
	
	function delCard(myCard_num,user_num,basic){
		if(basic == "Y"){
			alert('다른 카드를 기본카드로 변경 후, 삭제할 수 있습니다.')
		}else{
			location.href = "delCard.user?myCard_num="+myCard_num+"&user_num="+user_num;
		}
	}
	
	
</script>
<body>
<div class="basicFont">
<h2>카 드</h2>
<div align="right">
<input type="button" value="+새 카드 추가" onclick="addCard('${count}')" class="btn btn-outline-dark">
</div>
<br>
<div align="center">
<c:if test="${empty cardList}">
	<b>등록된 카드가 없습니다.</b>
</c:if>
</div>

<c:forEach var="dto" items="${cardList}">
<table>
	<tr width="500">
		<th width="50%">
			<c:if test="${dto.basic == 'Y'}">
			<input type="text" value="${dto.bank_name} [기본카드]" style="border:none;" readOnly>
			</c:if>
			<c:if test="${dto.basic == 'N'}">
			<input type="text" value="${dto.bank_name}" style="border:none;" readOnly>
			</c:if>
		</th>
		<th rowspan="3" align="right" width="50%">
			<c:if test="${dto.basic == 'N'}">
				<input type="button" value="기본카드" class="btn btn-outline-dark"
				onclick="changeBasicCard('${dto.myCard_num}','${dto.user_num}')">
			</c:if>
			<input type="button" value="삭제" class="btn btn-outline-dark"
			onclick="delCard('${dto.myCard_num}','${dto.user_num}','${dto.basic}')">
		</th>
	</tr>
	<tr>
		<th><input type="text" value="${dto.card_num}" style="border:none;" readOnly></th>
	</tr>
	<tr>
		<th><input type="text" value="${dto.card_date}" style="border:none; width:500px;" readOnly></th>
	</tr>	
</table>
<c:if test="${dto.basic == 'Y'}">
<hr style="border:1px solid;">
</c:if>
<c:if test="${dto.basic == 'N'}">
<hr>
</c:if>
</c:forEach>
</div>

</body>
</html>
<%@include file="bottom.jsp" %>