<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ</title>
<script type="text/javascript">
	function faqList(qna_subCate){
		location.href = "faqList.user?qna_subCate="+ encodeURI(qna_subCate);
	}
	function faqPage(pageNum,qna_subCate){
		location.href = "faqList.user?pageNum="+pageNum+"&qna_subCate="+ encodeURI(qna_subCate);
	}
	function findPage(pageNum,searchString){
		location.href = "faqSearch.user?pageNum="+pageNum+"&searchString="+ encodeURI(searchString);
	}
	
	
	function search(event){
		var input = document.getElementById('searchString');
		if(event.keyCode == 13){
			alert('검색어:'+input.value)
			location.href='faqSearch.user?searchString='+encodeURI(input.value)
			return
		} 
	}
	
	function buttonX(){
		var count = document.getElementById('searchDiv').childElementCount;
		if(count == 2) return
		var x = document.createElement('input');
		x.type = 'button';
		x.value = 'X';
		x.onclick = function(){
			document.getElementById('searchDiv').removeChild(document.getElementById('searchDiv').lastElementChild)
			location.href = 'faq.user';
		}
		document.getElementById('searchDiv').appendChild(x);
	}
	
	function back(){
		location.href = 'faq.user';
	}
	
</script>
</head>
<body>
<div class="div3" id = "basicFont">
		<div align="center" id = "basicFont">
		<h5><b>자주 묻는 질문</b></h5>
		<br>
		<div id="searchDiv">
			<input type="text" class = "form-control" style = "width:30%;display:inline" id="searchString" onkeypress="search(event)" placeholder="제목,내용 검색">
			<c:if test="${not empty searchString}">
			<input type="button" value="X" onclick="back()">
			</c:if>
		</div>
		<br>
		<table>
		<tr>
		<td><input type="button" class="btn btn-outline-dark" id="all" name="all" value="전체" onclick="faqList('All')"></td>
		<c:forEach var="subCate" items="${subCateList}">
			<td><input class="btn btn-outline-dark" type="button" id="${subCate}" name="${subCate}" value="${subCate}" onclick="faqList('${subCate}')"></td>
		</c:forEach>
		</tr>
		</table>
		
		<br>
		
		<div id="faq-list">
		<table id="faq-table" class = "table table-hover" style = "width:70%">

		 <c:if test="${not empty QnABoardList}">
			<b>${qna_subCate}</b>
			<c:forEach var="dto" items="${QnABoardList}">
			<tr align = "center">
				<th><a href="qnaView.user?qna_num=${dto.qna_num}">[${dto.qna_subCate}]${dto.qna_subject}</a></th>
			</tr>
			</c:forEach> 
		</c:if> 
		
		<c:set var="co" value="0"/>
		<c:if test="${not empty searchList}">
			<c:forEach var="dto" items="${searchList}">
			<tr align = "center">
				<th><a href="qnaView.user?qna_num=${dto.qna_num}">[${dto.qna_subCate}]${dto.qna_subject}</a></th>
			</tr>
			<c:set var="co" value="${co+1}"/>
			</c:forEach>
			<caption><b>검색어 결과 ${co}개</b></caption>
		</c:if>
		<c:if test="${empty QnABoardList && empty searchList }">
		<h5><b>검색어 결과 ${co}개</b></h5>
		</c:if>
		</table>
	
		<c:if test="${count >0}">
			<c:if test="${empty mode}">
				<c:if test="${startPage > pageBlock}">
					[<a href="faq.user?pageNum=${startPage-1}">이전</a>]	
				</c:if>
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					[<a href="faq.user?pageNum=${i}">${i}</a>]		
				</c:forEach>
				<c:if test="${endPage < pageCount}">
					[<a href="faq.user?pageNum=${endPage+1}">다음</a>]
				</c:if>
			</c:if>
		</c:if>
		
		<c:if test="${count >0}">
			<c:if test="${mode == 'list'}">
				<c:if test="${startPage > pageBlock}">
					[<a href="javascript:faqPage('${startPage-1}','${qna_subCate}')">이전</a>]	
				</c:if>
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					[<a href="javascript:faqPage('${i}','${qna_subCate}')">${i}</a>]		
				</c:forEach>
				<c:if test="${endPage < pageCount}">
					[<a href="javascript:faqPage('${endPage+1}','${qna_subCate}')">다음</a>]
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
					[<a href="javascript:findPage('${endPage+1}','${searchString}')">다음</a>]
				</c:if>
			</c:if>
		</c:if>	
		
	
	</div>
		</div>
		</div>
</div>
</body>
</html>
<%@include file="../../bottom.jsp"%>