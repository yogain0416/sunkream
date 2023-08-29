<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Announce</title>
</head>
<script type="text/javascript">
	function search(event){
		var input = document.getElementById('searchString');
		if(event.keyCode == 13){
			location.href='announceSearch.user?searchString='+encodeURI(input.value)
		}
	}
	function findPage(pageNum,searchString){
		location.href = "announceSearch.user?pageNum="+pageNum+"&searchString="+ encodeURI(searchString);
	}
</script>
<body>

<div class="div3" id = "basicFont">
	<div align="center">
		<table class = "table table-hover" style = "width:70%">
		<thead>
			<tr align = "center"><td><h5><b>공 지 사 항</b></h5></td></tr></thead>
			<c:forEach var="dto" items="${QnABoardList}">
			<tr align = "center">
				<th><a href="qnaView.user?qna_num=${dto.qna_num}">[${dto.qna_subCate}]${dto.qna_subject}</a></th>
			</tr>
			</c:forEach>
		</table>
		
		<c:if test="${count >0}">
			<c:if test="${mode != 'find'}">
				<c:if test="${startPage > pageBlock}">
					[<a href="announce.user?pageNum=${startPage-1}">이전</a>]	
				</c:if>
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					[<a href="announce.user?pageNum=${i}">${i}</a>]		
				</c:forEach>
				<c:if test="${endPage < pageCount}">
					[<a href="announce.user?pageNum=${endPage+1}">다음</a>]
				</c:if>
			</c:if>
		</c:if>
		
		<c:if test="${count >0}">
			<c:if test="${mode == 'find'}">
				<c:if test="${startPage > pageBlock}">
					[<a href="javascript:findPage('${startPage-1}','${searchString}')">이전</a>]	
				</c:if>
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					[<a href="javascript:findPage('${i}','${searchString}')">${i}</a>]		
				</c:forEach>
				<c:if test="${endPage < pageCount}">
					[<a href="javascript:findPage(''${endPage+1}','${searchString}')">다음</a>]
				</c:if>
			</c:if>
		</c:if>	
		<br>
		<input type="text" class = "form-control" style = "width:50%;" id="searchString" onkeypress="search(event)" placeholder="제목,내용 검색" >
	</div>
</div>
</div>
</body>
</html>
<%@include file="../../bottom.jsp" %>