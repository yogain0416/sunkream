<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ</title>
<script type="text/javascript">
	function findPage(pageNum,searchString,user_num){
		location.href='qnaSearch.user?pageNum='+pageNum+'&searchString='+encodeURI(searchString)+'&user_num='+user_num
	}
</script>  
</head>
<body>
<div class="div3" id = "basicFont">
	<div align="center">
		<table class= "table table-hover" style = "width:70%;">
		<thead>
			<tr align = "center">
			<td colspan = "2">
			<c:if test="${empty qnaList}">
			<h3>등록된 문의글이 없습니다.</h3>
			</c:if>
			<c:if test="${not empty qnaList}">
			<h5><b>1:1 문의</b></h5>
			</c:if>
			</td>
			</tr>
			</thead>
			<c:forEach var="dto" items="${qnaList}">
				<tr align="center">
					<th width="30%">
					<c:if test="${dto.qna_process == '답변'}">
					<i class="bi bi-arrow-return-right"></i>
					</c:if>
					<c:if test="${dto.qna_process != '답변'}">
					${dto.qna_cate}[${dto.qna_subCate}]
					</c:if>
					</th>
					<th>
					<a href="qnaView.user?qna_num=${dto.qna_num}">${dto.qna_subject}</a>
					</th>
				</tr>
			</c:forEach>
		</table>
		
		<c:if test="${count >0}">
			<c:if test="${empty mode}">
				<c:if test="${startPage > pageBlock}">
					[<a href="qna.user?pageNum=${startPage-1}&user_num=${sessionUser_num}">이전</a>]	
				</c:if>
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					[<a href="qna.user?pageNum=${i}&user_num=${sessionUser_num}">${i}</a>]		
				</c:forEach>
				<c:if test="${endPage < pageCount}">
					[<a href="qna.user?pageNum=${endPage+1}&user_num=${sessionUser_num}">다음</a>]
				</c:if>
			</c:if>
		</c:if>
		<c:if test="${count >0}">
			<c:if test="${mode == 'find'}">
				<c:if test="${startPage > pageBlock}">
					[<a href="javascript:findPage('${startPage-1}','${searchString}','${sessionUser_num}')">이전</a>]	
				</c:if>
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					[<a href="javascript:findPage('${i}','${searchString}','${sessionUser_num}')">${i}</a>]		
				</c:forEach>
				<c:if test="${endPage < pageCount}">
					[<a href="javascript:findPage('${endPage+1}','${searchString}','${sessionUser_num}')">다음</a>]
				</c:if>
			</c:if>
		</c:if>
		
		<br>
	<br>
		
		<form id="askSearch" method="post" action="qnaSearch.user">
			<input type="text" class = "form-control" style="width:30%;display:inline;" name="searchString" id="searchString" placeholder="제목,내용 검색" >
			&nbsp;&nbsp;<svg onclick="location.href='qnaWriteForm.user?user_num=${sessionUser_num}'" style = "cursor:pointer;" xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
  <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
  <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
</svg>
			<input type="hidden" name="user_num" value="${sessionUser_num}">
		</form>
		
	</div>
</div>
</div>
</body>
</html>
<%@include file="../../bottom.jsp"%>