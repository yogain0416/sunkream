<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../admin_top.jsp"%>
<script>
function utf(id){
	 var regexp = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
	    var value = $("#"+id).val();
	    if (regexp.test(value)) {
	        $("#"+id).val(value.replace(regexp, ''));
	    }
}
function check(){
	var tab = document.getElementById("tab_name").value;
	var pick = document.getElementById("pick_name").value;
	var pickKr = document.getElementById("pick_kr_name").value;
	if(tab == null || tab ==''){
		alert("카테고리탭을 입력해주세요.")
		document.getElementById("tab_name").focus()
		return;
	}
	if(pick == null || pick == ''){
		alert("추천명(영어)를 입력해주세요.")
		document.getElementById("pick_name").focus()
		return;
	}
	if(pickKr == null || pickKr ==''){
		alert("추천명(한글)을 입력해주세요.")
		document.getElementById("pick_kr_name").focus()
		return;
	}
	else {
		document.d.submit()
	}
}
</script>
<html>
<head>
<meta charset="UTF-8">
<title>ProdPickList</title>
</head>
<body>
	<div class="div3" id = "basicFont">
		<div align="center">
		<h3>추천상품 카테고리 목록</h3>
		<br>
			<table  class = "table table-hover" style = "width:70%;" >
			<thead>
				<tr align = "center">
					<th> 카테고리 탭  </th>
					<th> 추천명(영어) </th>
					<th> 추천명(한글) </th>
					<th> 삭제 </th>
				</tr>
				</thead>
				<div id="pickList">
					<c:if test="${empty pickCateList }">
						<tr>
							<td colspan="4" align="center">추천상품 카테고리가 없습니다 .</td>
						</tr>
					</c:if>
					<c:if test = "${not empty pickCateList }">
					<c:forEach var="dto" items="${pickCateList}">
						<tr align = "center">
							<td>${dto.tab_name}</td>
							<td>${dto.pick_name}</td>
							<td>${dto.pick_kr_name }</td>
							<td><a href="pickCateDelete.admin?cate_num=${dto.cate_num}">삭제</a></td>
						</tr>
					</c:forEach>
					</c:if>
				</div>
			</table>
			
			<!-- 게시물 갯수 제한 및 이동 -->
			<c:if test="${count>0}">
				<c:if test="${startPage > pageBlock}">
					[<a href="pickCateList.admin?pageNum=${startPage - 1}">이전</a>]	
				</c:if>
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					[<a href="pickCateList.admin?pageNum=${i}">${i}</a>]		
				</c:forEach>
				<c:if test="${endPage < pageCount}">
					[<a href="pickCateList.admin?pageNum=${endPage + 1}">다음</a>]
				</c:if>
			</c:if>
			
			<form name = "d" method = "POST" action = "pickCateInput.admin">
				카테고리탭:<input class = "form-control" style = "width:50%;display:inline;" type="text" placeholder="카테고리 탭을 입력해 주세요.(한글만입력)" name="tab_name" id = "tab_name" onkeyup="utf('tab_name')"size = "30"><br>
				추천명(영어):<input class = "form-control" style = "width:50%;display:inline;" type="text" placeholder="추천명(영어)를 입력해 주세요.(영문만입력) " name="pick_name" id = "pick_name" style="ime-mode: disabled;" size = "30"><br>
				추천명(한글):<input class = "form-control" style = "width:50%;display:inline;" type="text" placeholder="추천명(한글)을 입력해 주세요.(한글만입력) " name="pick_kr_name" id = "pick_kr_name" onkeyup="utf('pick_kr_name')" size = "30"><br>
				<input type="button" onclick = 'check()' value="추천상품 카테고리 등록" class="btn btn-outline-dark">
			</form>
		</div>
	</div>
	</div>
</body>
</html>
<%@include file="../../bottom.jsp"%>