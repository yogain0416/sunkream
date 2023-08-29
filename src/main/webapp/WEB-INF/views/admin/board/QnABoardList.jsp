<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../admin_top.jsp" %>
<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">
<title>QnABoardList</title>
</head>
<body>
<script type="text/javascript">
	function check(qna_cate){
		location.href = 'QnABoardList.admin?qna_cate=' + encodeURI(qna_cate)
	}
	function checkSearch(){
		if(document.getElementById('searchString').value == "") {
			return false
		}
		return true
	}
	
	function findPage(qna_cate,process,pageNum,search,searchString){
		location.href = 'qnaFind.admin?qna_cate='+qna_cate+'&process='+process
				+'&pageNum='+pageNum+'&search='+search+'&searchString='+ encodeURI(searchString)
	}
	function onSubmit(){
		document.qnaFind.submit();
	}
</script>
<div class="div3" id = "basicFont">
	<div align="center" >
	<h3>[${qna_cate}] 목록</h3>
	<br>
	<hr width = "60%">
		<table class = "table table-hover" style="width:80%">
		<thead>
		<c:if test="${qna_cate != '1:1문의'}">
			<tr>
			
				<td colspan="3" align="center">
				
				<svg onclick="check('공지')" style = "cursor:pointer;" xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-megaphone-fill" viewBox="0 0 16 16">
  <path d="M13 2.5a1.5 1.5 0 0 1 3 0v11a1.5 1.5 0 0 1-3 0v-11zm-1 .724c-2.067.95-4.539 1.481-7 1.656v6.237a25.222 25.222 0 0 1 1.088.085c2.053.204 4.038.668 5.912 1.56V3.224zm-8 7.841V4.934c-.68.027-1.399.043-2.008.053A2.02 2.02 0 0 0 0 7v2c0 1.106.896 1.996 1.994 2.009a68.14 68.14 0 0 1 .496.008 64 64 0 0 1 1.51.048zm1.39 1.081c.285.021.569.047.85.078l.253 1.69a1 1 0 0 1-.983 1.187h-.548a1 1 0 0 1-.916-.599l-1.314-2.48a65.81 65.81 0 0 1 1.692.064c.327.017.65.037.966.06z"/>
</svg>
				&nbsp;&nbsp;&nbsp;
				<svg style = "cursor:pointer;" onclick = "check('FAQ')" xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-question-diamond-fill" viewBox="0 0 16 16">
  <path d="M9.05.435c-.58-.58-1.52-.58-2.1 0L.436 6.95c-.58.58-.58 1.519 0 2.098l6.516 6.516c.58.58 1.519.58 2.098 0l6.516-6.516c.58-.58.58-1.519 0-2.098L9.05.435zM5.495 6.033a.237.237 0 0 1-.24-.247C5.35 4.091 6.737 3.5 8.005 3.5c1.396 0 2.672.73 2.672 2.24 0 1.08-.635 1.594-1.244 2.057-.737.559-1.01.768-1.01 1.486v.105a.25.25 0 0 1-.25.25h-.81a.25.25 0 0 1-.25-.246l-.004-.217c-.038-.927.495-1.498 1.168-1.987.59-.444.965-.736.965-1.371 0-.825-.628-1.168-1.314-1.168-.803 0-1.253.478-1.342 1.134-.018.137-.128.25-.266.25h-.825zm2.325 6.443c-.584 0-1.009-.394-1.009-.927 0-.552.425-.94 1.01-.94.609 0 1.028.388 1.028.94 0 .533-.42.927-1.029.927z"/>
</svg>
				</td>
			</tr>
		</c:if>
			<tr align = "center">
				<th width="10%">번호</th>
				<th width="20%">분류</th>
				<c:if test="${qna_cate == '1:1문의'}">
					<th width="40%">제목</th>
					<th width="15%">닉네임</th>
					<th width="15%">진행상황</th>
				</c:if>
				<c:if test="${qna_cate != '1:1문의'}">
					<th colspan="3" width = "70%">제목</th>
				</c:if>
			</tr>
			</thead>
			<c:if test="${empty QnABoardList}">
			<tr>
				<td colspan="5">등록된 게시글이 없습니다.</td>
			</tr>
			</c:if>
			<c:set var="rowNum" value="${rowNum}"/>
			<c:forEach var="dto" items="${QnABoardList}">
			<tr align = "center">
				<td>${rowNum}</td>
				<c:set var="rowNum" value="${rowNum-1}"/>
				<c:if test="${dto.qna_cate != '공지'}">
					<td>${dto.qna_cate}[${dto.qna_subCate}]</td>
				</c:if>
				<c:if test="${dto.qna_cate == '공지'}">
					<c:if test="${dto.qna_subCate == '이벤트'}">
						<td>${dto.qna_cate}[${dto.qna_subCate}]</td>
					</c:if>
					<c:if test="${dto.qna_subCate != '이벤트'}">
						<td>${dto.qna_cate}</td>
					</c:if>
				</c:if>
				<c:if test="${qna_cate != '1:1문의'}">
				<td colspan="2"><a href="QnAView.admin?qna_num=${dto.qna_num}">${dto.qna_subject}</a></td>
				</c:if>
				<c:if test="${qna_cate == '1:1문의'}">
				<td><a href="QnAView.admin?qna_num=${dto.qna_num}">${dto.qna_subject}</a></td>
				<td><a href="memberDetail.admin?user_num=${dto.user_num}">${dto.qna_writer}
					<c:if test="${dto.del == 'Y'}">[탈퇴회원]</c:if>
					</a></td>
				<td>${dto.qna_process}</td>
				</c:if>
			</tr>
			</c:forEach>
			<c:if test="${qna_cate != '1:1문의'}">
			<tr>
				<td colspan="4" align="right">
				
				<a href = "QnABoardInput.admin">글쓰기
				<svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
  <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
  <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
</svg></a>
				</td>
			</tr>
			</c:if>
		</table>
		
		<!-- 게시물 갯수 제한 및 이동 -->
		<c:if test="${count >0}">
			<c:if test="${mode != 'find'}">
			<c:if test="${qna_cate == '1:1문의'}">
				<c:set var="qna_cate" value="ask"/>
			</c:if>
			<c:if test="${qna_cate == '공지'}">
				<c:set var="qna_cate" value="qna"/>
			</c:if>		
				<c:if test="${startPage > pageBlock}">
					[<a href="QnABoardList.admin?qna_cate=${qna_cate}&process=${process}&pageNum=${startPage - 1}">이전</a>]	
				</c:if>
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					[<a href="QnABoardList.admin?qna_cate=${qna_cate}&process=${process}&pageNum=${i}">${i}</a>]		
				</c:forEach>
				<c:if test="${endPage < pageCount}">
					[<a href="QnABoardList.admin?qna_cate=${qna_cate}&process=${process}&pageNum=${endPage+1}">다음</a>]
				</c:if>
			</c:if>
		</c:if>
		
		<c:if test="${count >0}">
			<c:if test="${mode == 'find'}">
				<c:if test="${qna_cate == '1:1문의'}">
					<c:set var="qna_cate" value="ask"/>
				</c:if>	
				<c:if test="${qna_cate == '공지'}">
					<c:set var="qna_cate" value="qna"/>
				</c:if>
				<c:if test="${startPage > pageBlock}">
					[<a href="javascript:findPage('${qna_cate}','${process}','${startPage-1}','${search}','${searchString}')">이전</a>]	
				</c:if>
				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					[<a href="javascript:findPage('${qna_cate}','${process}','${i}','${search}','${searchString}')">${i}</a>]		
				</c:forEach>
				<c:if test="${endPage < pageCount}">
					[<a href="javascript:findPage('${qna_cate}','${process}','${endPage+1}','${search}','${searchString}')">다음</a>]
				</c:if>
			</c:if>
		</c:if>		
		
		<!-- 검색창 -->
		<form name="qnaFind" action="qnaFind.admin" method="post" onsubmit="return checkSearch()">
			<select name="search" >
				<option value="qna_subject">제목</option>
				<option value="qna_contents">내용</option>
				<c:if test="${qna_cate == 'ask' || qna_cate == '1:1문의'}">
				<option value="profile_name">닉네임</option>
				</c:if>
				<option value="qna_subCate">서브카테</option>
			</select>
			<input type="text" name="searchString" id="searchString">
			<svg style = "cursor:pointer;" onclick="onSubmit()" xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
</svg>
			<input type="hidden" name="qna_cate" value="${qna_cate}">
			<input type="hidden" name="process" value="${process}">
		</form>
		
	</div>
</div>
</div>
</body>
</html>
<%@include file="../../bottom.jsp" %>