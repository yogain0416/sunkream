<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@include file = "../admin_top.jsp" %>

<html>
<head>
<meta charset="UTF-8">
<title>pickProdList</title>
</head>
<script type="text/javascript">
	function findPage(pageNum,searchString,search){
		location.href = 'pickProdList.admin?pageNum='+pageNum+'&search='+search+'&searchString='+encodeURI(searchString);
	}
	function onSubmit(){
		document.pickProd.submit();
	}
</script>
<body>
		<div align="center">
		<h3>추천상품목록</h3>
		<br>
				<table class = "table table-hover" style = "width:70%;">
				<thead>
				<tr align = "center">
				
					<th> 카테고리 탭  </th>
					<th> 추천명(영어)</th>
					<th> 추천명(한글) </th>
					<th>상품명</th>
					<th>상품 이미지 </th>
					<th> 삭제 </th>
				</tr>
				</thead>
					<c:if test="${empty list }">
						<tr>
							<td colspan="6" align="center">추천상품 카테고리가 없습니다 .</td>
						</tr>
					</c:if>
					<c:if test = "${not empty list }">
					<c:forEach var="dto" items="${list}">
						<tr align = "center">
							<td>${dto.tab_name}</td>
							<td>${dto.pick_name}</td>
							<td>${dto.pick_kr_name }</td>
							<td>${dto.prod_kr_subject }</td>
							<td><img src = "${upPath }/${dto.prod_img1 }" width = "50px" height = "50px"></td>
							<td>
							<i style = "cursor:pointer;" onclick = "location.href='pickProdDel.admin?cate_num=${dto.cate_num }&prod_num=${dto.prod_num}'" class="bi bi-trash3"></i>
							</td>
						</tr>
					</c:forEach>
					</c:if>
			</table>
			
			<c:if test="${count >0}">
			<c:if test="${empty mode}">
				<c:if test="${startPage > pageBlock}">
					[<a href="pickProdList.admin?pageNum=${startPage-1}">이전</a>]	
				</c:if>
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					[<a href="pickProdList.admin?pageNum=${i}">${i}</a>]		
				</c:forEach>
				<c:if test="${endPage < pageCount}">
					[<a href="pickProdList.admin?pageNum=${endPage+1}">다음</a>]
				</c:if>
			</c:if>
		</c:if>
		<c:if test="${count >0}">
			<c:if test="${mode == 'find'}">
				<c:if test="${startPage > pageBlock}">
					[<a href="javascript:findPage('${startPage-1}','${searchString}','${search}')">이전</a>]	
				</c:if>
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					[<a href="javascript:findPage('${i}','${searchString}','${search}')">${i}</a>]		
				</c:forEach>
				<c:if test="${endPage < pageCount}">
					[<a href="javascript:findPage('${endPage+1}','${searchString}','${search}')">다음</a>]
				</c:if>
			</c:if>
		</c:if>
		
		
		<!-- 검색창 -->
		<form name="pickProd" action="pickProdFind.admin" method="post">
			<select name="search">
				<option value="tab_name">카테고리탭</option>
				<option value="pick_name">추천명</option>
				<option value="prod_name">상품명</option>
			</select>
			<input type="text" name="searchString" id="searchString" class = "form-control" style = "width:30%;display:inline;">
			<i class="bi bi-search" onclick = "onSubmit()" style = "cursor:pointer;">찾기</i>
		</form>
		
		
		
		
		
		</div>
		</div>
</body>
</html>
<%@include file = "../../bottom.jsp" %>