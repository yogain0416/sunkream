<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../admin_top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="div3" id = "basicFont">
   <div align="center">
      <h3>문의 게시글 보기</h3>
      <br>
      <form id="qnaAnswer" method="post" action="qnaAnswer.admin">
      <table class = "table" style = "width:70%;">
      
         <tr align = "center">
            <th>번호</th>
            <td>${qna.qna_num}</td>
            
            
         </tr>
         <tr align = "center">
         <th>작성자</th>
         <td>${qna.qna_writer}</td>
         </tr>
         <tr align = "center">
            <th>문의종류</th>
            <td>${qna.qna_cate}[${qna.qna_subCate}]</td>
         </tr>
         <tr align = "center">
            <th >제목</th>
            <td >${qna.qna_subject}</td>
         </tr>
         <c:if test="${not empty imgList}">
            <tr align = "center">
               <th>이미지</th>
               <td colspan="2">
               <c:forEach var="imgDTO" items="${imgList}">
               <img src="${upPath}/${imgDTO.qna_img}" width="100" height="100">
               </c:forEach>
               </td>
            </tr>
         </c:if>   
         <tr align = "center">
            <th >내용</th>
            <td >
            ${qna.qna_contents}
            </td>
         </tr>   
         <tr align ="center">
            <th>피신고자</th>
            <td>${qna.qna_reporter}</td>
         </tr>
         <tr align = "center">
         <th >진행상황</th>
            
            <td>${qna.qna_process}</td>
         </tr>
      </table>
      <i style="cursor:pointer;" onclick="window.history.back()" class="bi bi-card-list">목록으로</i>&nbsp;
      <c:if test="${qna.qna_process == '대기중'}">
      <i class="bi bi-arrow-return-right" onclick="location.href='askReply.admin?qna_num=${qna.qna_num}'" style = "cursor:pointer">답변하기</i>
      </c:if>
      </form>
   </div>
   </div>
   </div>
</body>
</html>
<%@include file="../../bottom.jsp" %>