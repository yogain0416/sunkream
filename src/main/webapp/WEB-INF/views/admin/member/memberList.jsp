<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../admin_top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberList</title>
</head>
<script type="text/javascript">
	function findPage(pageNum,search,searchString,del){
		location.href = 'memberFind.admin?pageNum='+pageNum+'&search='+search+'&searchString='+encodeURI(searchString)
				+'&del='+del
	}
	function onSubmit(){
		document.memberFind.submit();
	}
</script>
<body>
<div class="div3">
	<div align="center">
	<c:if test="${del == 'N'}">
			<h3>회원 목록</h3>

		</c:if>
		<c:if test="${del == 'Y'}">
			<h3>탈퇴 회원 목록</h3>
		</c:if>
		<hr width  = "80%">
		<br>
	
		<table class = "table table-hover" style = "width:80%;">
		
		<thead>
			<tr align = "center">
				<th>번호</th>
				<th>이메일</th>
				<th>프로필이름</th>
				<th>이름</th>
			</tr>
			</thead>
			<c:if test="${empty memberList}">
				<tr>
					<td colspan="4" align="center">등록된 회원이 없습니다.</td>
				</tr>
			</c:if>				
		<c:set var="rowNum" value="${rowNum}"/>
		<c:forEach var="dto" items="${memberList}">	
			<tr align="center">
				<td>${rowNum}</td>
				<c:set var="rowNum" value="${rowNum-1}"/>
				<td>
				<a href="memberDetail.admin?user_num=${dto.user_num}">${dto.email}</a>
				</td>
				<td>${dto.profile_name}</td>
				<td>${dto.name}</td>
			</tr>	
		</c:forEach>			
		</table>
		<c:if test="${count >0}">
			<c:if test="${mode != 'find'}">
				<c:if test="${startPage > pageBlock}">
					[<a href="memberList.admin?pageNum=${startPage - 1}&del=${del}">이전</a>]	
				</c:if>
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					[<a href="memberList.admin?pageNum=${i}&del=${del}">${i}</a>]		
				</c:forEach>
				<c:if test="${endPage < pageCount}">
					[<a href="memberList.admin?pageNum=${endPage+1}&del=${del}">다음</a>]
				</c:if>
			</c:if>
		</c:if>
		
		<c:if test="${count >0}">
			<c:if test="${mode == 'find'}">
				<c:if test="${startPage > pageBlock}">
					[<a href="javascript:findPage('${startPage-1}','${search}','${searchString}','${del}')">이전</a>]	
				</c:if>
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					[<a href="javascript:findPage('${i}','${search}','${searchString}','${del}')">${i}</a>]		
				</c:forEach>
				<c:if test="${endPage < pageCount}">
					[<a href="javascript:findPage('${endPage+1}','${search}','${searchString}','${del}')">다음</a>]
				</c:if>
			</c:if>
		</c:if>		
		
		<form name="memberFind" action="memberFind.admin" method="post">
			<select name="search">
				<option value="email">이메일</option>
				<option value="name">이름</option>
				<option value="profile_name">프로필이름</option>
			</select>
			<input type="text" name="searchString">
			<i class="bi bi-search" onclick = "onSubmit()" style = "cursor:pointer;" >검색</i>
			<input type="hidden" value="${del}" name="del">
		</form>
		
		
		
	</div>
	</div>
	</div>
</body>
</html>
<%@include file="../../bottom.jsp" %>