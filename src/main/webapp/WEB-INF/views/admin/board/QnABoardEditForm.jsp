<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@include file="../admin_top.jsp" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<style>
#reportRow {
   display: none;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>QnABoardInputForm</title>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
   <script src="resources/js/admin/board/QnABoardEdit.js"></script>
</head>
<body>
   <script>
   </script>
   <div class="div3">
   <div align="center" class="basicFont">
      <form name="QnABoardEdit" method="post" action="QnABoardEdit.admin"
         onsubmit="return checkInput()" enctype="multipart/form-data">
         <input type="hidden" name="qna_num" value="${getBoard.qna_num}">
         <!-- <input type="hidden" name = "user_num" value="1"> -->

         <table class = "table" style = "width:70%;">
         <thead>
         <tr align = "center">
         <td colspan = "2"><h3>게시글 수정</h3>
         </td>
         </tr>
         </thead>
            <tr>
               <th>카테고리</th>
               <th><select id="qna_cate" name="qna_cate"
                  onchange="cateSelect()">
                     <c:forTokens items="---선택---,공지,FAQ,1:1문의" delims=","
                        var="qna_cate">
                        <c:if test="${getBoard.qna_cate == qna_cate}">
                           <option value="${qna_cate}" selected>${qna_cate}</option>
                        </c:if>
                        <c:if test="${getBoard.qna_cate != qna_cate}">
                           <option value="${qna_cate}">${qna_cate}</option>
                        </c:if>
                     </c:forTokens>
               </select> <select id="qna_subCate" name="qna_subCate">
                     <c:forEach var="dto" items="${subCateList}">
                        <c:if test="${dto.qna_subCate == getBoard.qna_subCate}">
                           <option value="${dto.qna_subCate}" selected>${dto.qna_subCate}</option>
                        </c:if>
                        <c:if test="${dto.qna_subCate != getBoard.qna_subCate}">
                           <option value="${dto.qna_subCate}">${dto.qna_subCate}</option>
                        </c:if>
                     </c:forEach>
               </select></th>
            </tr>
            <tr>
               <th>제목</th>
               <td><input class = "form-control" style = "width:40%;display:inline;" type="text" name="qna_subject"
                  value="${getBoard.qna_subject}"></td>
            </tr>
            <c:if test="${not empty imgList}">
               <tr>
                  <th>이미지</th>
                  <td>
                     <div class="form-group file-group" id="file-list">
                        <c:forEach items="${imgList}" var="file">
                           <div class="file-input">
                              <!-- <span class="glyphicon glyphicon-camera" aria-hidden="true"></span> -->
                              <img src="${upPath}/${file.qna_img}" width="50" height="50"><br>
                              ${file.qna_img} <a href='#this' name='file-delete'>삭제</a> 
                              <input type="hidden" name="file_img" value="${file.qna_img}">
                           </div>
                        </c:forEach>
                     </div>
                     <div id="attachFileDiv">
                        <div id="file0">
                           <input type="file" id="file_img0" name="file_img0" value=""
                              size="20" onchange="javascript:attachFile.add(0)">
                        </div>
                     </div>
                  </td>
               </tr>
            </c:if>
            <tr>
               <th>내용</th>
               <td><textarea class = "form-control" style= "width:60%;" name="qna_contents" cols="30" rows="15">${getBoard.qna_contents}</textarea>
               </td>
            </tr>
            <tr id="reportRow">
               <th>피신고인</th>
               <td>
                  <!-- <input type="hidden" value="2" name="report_num"> -->
               </td>
            </tr>
         </table>
         <i onclick = "javascript:window.document.QnABoardEdit.submit()" class="bi bi-pencil-square" style = "cursor:pointer;">수정</i>
             <i onclick= "location.href='QnABoardEdit.admin?qna_num=${getBoard.qna_num}'" style = "cursor:pointer;" class="bi bi-x-circle">다시작성</i>
      </form>
   </div>
   </div>
   </div>
</body>
</html>
<%@include file="../../bottom.jsp"%>