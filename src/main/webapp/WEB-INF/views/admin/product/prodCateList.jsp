<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../admin_top.jsp"%>
<html>
<head>
<meta charset="UTF-8">
<title>cateInput</title>
</head>
<script type="text/javascript">
	function findPage(pageNum,search,searchString){
		location.href = 'prodCateListFind.admin?pageNum='+pageNum+'&search='+search+'&searchString='+encodeURI(searchString)
	}
	function onSubmit(){
		document.cateFind.submit();
	}
</script>
<body>
<div class = "div3" align = "left" id = "basicFont">
<div align="center">
<h3>카테고리 목록</h3>
<br>
<hr width = "80%">
<br>
	<table class = "table table-hover" style= "width:80%;">
	<thead>
		<tr>
			<th>번호</th>
			<th>브랜드명 (영문)</th>
			<th>브랜드명 (한글)</th>
			<th>카테고리 대분류(영문)</th>
			<th>카테고리 대분류(한글)</th>
			<th>카테고리 소분류(영문)</th>
			<th>카테고리 소분류(한글)</th>
			<th>삭제</th>
		</tr>
		</thead>
		<c:if test="${empty prodCateList }">
			<tr>
				<td colspan = "7">등록된 카테고리가 없습니다.</td>
			</tr>
		</c:if>
		<c:forEach var = "dto" items = "${prodCateList }">
		<tr>
		<td align = "center">${dto.cate_num }</td>
		<td align = "center">${dto.cate_brand }</td>
		<td align = "center">${dto.cate_kr_brand }</td>
		<td align = "center">${dto.cate_type }</td>
		<td align = "center">${dto.cate_kr_type }</td>
		<td align = "center">${dto.cate_subType }</td>
		<td align = "center">${dto.cate_kr_subType }</td>
		<td align = "center">
		<i onclick ="location.href = 'prodCateDelete.admin?cate_num=${dto.cate_num}'" style = "cursor:pointer;"   class="bi bi-trash3"></i>
		</td>
		</c:forEach>
	</table>
</div>
</div>
		<div align="center">
		<c:if test="${count >0}">
			<c:if test="${mode != 'find'}">
				<c:if test="${startPage > pageBlock}">
					[<a href="prodCateList.admin?pageNum=${startPage - 1}">이전</a>]	
				</c:if>
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					[<a href="prodCateList.admin?pageNum=${i}">${i}</a>]		
				</c:forEach>
				<c:if test="${endPage < pageCount}">
					[<a href="prodCateList.admin?pageNum=${endPage+1}">다음</a>]
				</c:if>
			</c:if>	
		</c:if>
		
		<c:if test="${count >0}">
			<c:if test="${mode == 'find'}">
				<c:if test="${startPage > pageBlock}">
					[<a href="javascript:findPage('${startPage-1}','${search}','${searchString}')">이전</a>]	
				</c:if>
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					[<a href="javascript:findPage('${i}','${search}','${searchString}')">${i}</a>]		
				</c:forEach>
				<c:if test="${endPage < pageCount}">
					[<a href="javascript:findPage(${endPage+1}','${search}','${searchString}')">다음</a>]
				</c:if>
			</c:if>
		</c:if>	
		
		
		<!-- 검색창 -->
		<form name="cateFind" action="prodCateListFind.admin" method="post">
			<select name="search">
				<option value="brand">브랜드</option>
				<option value="type">대분류</option>
				<option value="subType">소분류</option>
			</select>
			<input type="text" name="searchString" id="searchString">
			<svg style = "cursor:pointer;" onclick="onSubmit()" xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
</svg>
		</form>
		</div>


</div>
</body>
</html>

<%@include file="../../bottom.jsp"%>