<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../admin_top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
	function findPage(process,pageNum,search,searchString){
		location.href = 'memberReportFind.admin?process='+process
			+'&pageNum='+pageNum+'&search='+search+'&searchString='+ encodeURI(searchString)
}
	function onSubmit(){
		document.memberReportFind.submit();
	}
</script>
<body>
<div class="div3">
<div align="center">
<c:if test="${param.process == 'wait'}">
			<h3>신고 처리 대기 목록</h3>
		</c:if>
		<c:if test="${param.process eq 'ok'}">
			<h3>신고 처리 완료 목록</h3>
		</c:if>
		<br>
		<hr width="80%">
		<br>
		<table class = "table table-hover" style= "width:80%">
		<thead>
			<tr>
				<th>번호</th>
				<th>카테</th>
				<th>제목</th>
				<th>작성자</th>
				<th>피신고자</th>
				<th>처리</th>
			</tr>
			</thead>
			<c:if test="${empty reportList}">
				<tr>
					<td colspan="6" align="center">등록된 글이 없습니다</td>
				</tr>	
			</c:if>
			<c:set var="rowNum" value="${rowNum}"/>
			<c:forEach var="dto" items="${reportList}">
				<tr>
				<td>${rowNum}</td>
				<c:set var="rowNum" value="${rowNum-1}"/>
				<td>${dto.qna_cate}[${dto.qna_subCate}]</td>
				<td><a href="memberReportView.admin?qna_num=${dto.qna_num}">${dto.qna_subject}</a></td>
				<td>
				<a href="memberDetail.admin?user_num=${dto.user_num}">
				<img src="${upPath}/${dto.profile_img}" width="30" height="30"
					class="rounded-circle"
					onerror="this.src='https://blog.kakaocdn.net/dn/c3vWTf/btqUuNfnDsf/VQMbJlQW4ywjeI8cUE91OK/img.jpg'">
				${dto.qna_writer}
				</a>
				</td>
				<td>
				<a href="memberDetail.admin?user_num=${dto.report_num}">${dto.qna_reporter}</a>
				</td>
				<td>${dto.qna_process}</td>
				</tr>
			</c:forEach>
		</table>
		
		<c:if test="${count >0}">
			<c:if test="${mode != 'find'}">
				<c:if test="${startPage > pageBlock}">
					[<a href="memberReport.admin?pageNum=${startPage-1}&process=${process}">이전</a>]	
				</c:if>
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					[<a href="memberReport.admin?pageNum=${i}&process=${process}">${i}</a>]		
				</c:forEach>
				<c:if test="${endPage < pageCount}">
					[<a href="memberReport.admin?pageNum=${endPage+1}&process=${process}">다음</a>]
				</c:if>
			</c:if>
		</c:if>
		
		<c:if test="${count >0}">
			<c:if test="${mode == 'find'}">
				<c:if test="${startPage > pageBlock}">
					[<a href="javascript:findPage('${process}','${startPage-1}','${search}','${searchString}')">이전</a>]	
				</c:if>
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					[<a href="javascript:findPage('${process}','${i}','${search}','${searchString}')">${i}</a>]		
				</c:forEach>
				<c:if test="${endPage < pageCount}">
					[<a href="javascript:findPage('${process}','${endPage+1}','${search}','${searchString}')">다음</a>]
				</c:if>
			</c:if>
		</c:if>		
		
		<form name="memberReportFind" action="memberReportFind.admin" method="post">
			<select name="search">
				<option value="qna_subject">제목</option>
				<option value="user_num">작성자</option>
				<option value="report_num">피신고자</option>
			</select>
			<input type="text" name="searchString">
			<i class="bi bi-search" onclick = "onSubmit()" style = "cursor:pointer;" >검색</i>
			<input type="hidden" name="process" value="${process}">
		</form>
		
		
		
	</div>
	</div>
	</div>
</body>
</html>
<%@include file="../../bottom.jsp"%>