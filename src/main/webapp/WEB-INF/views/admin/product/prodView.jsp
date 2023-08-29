<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@include file="top.jsp"%>
<link rel="stylesheet" href="resources/css/slide.css" type="text/css">
<html>
<head>
<meta charset="UTF-8">
<title>cateInput</title>
</head>
<body>
   <div class="div_container">
      <div class="div1" align="center">
         <img src="${upPath }/${dto.prod_img1}" alt="" width="500px"
            height="500px">
      </div>
      <div class="div2" align="center">
         <table border="1" width="500" height="600">
            <tr align="center">
               <td width="30%">브랜드</td>
               <td>${dto.cate_kr_brand }</td>
            <tr>
            <tr align="center">
               <td width="30%">대분류</td>
               <td>${dto.cate_kr_type }</td>
            <tr>
            <tr align="center">
               <td width="30%">소분류</td>
               <td>${dto.cate_kr_subType }</td>
            <tr>
            <tr align="center">
               <td width="30%">상품제목</td>
               <td>${dto.prod_kr_subject }</td>
            <tr>
            <tr align="center">
               <td width="30%">상품색상</td>
               <td>${dto.prod_kr_color }</td>
            <tr>
            <tr align="center">
               <td width="30%">상품가격</td>
               <td><fmt:formatNumber value="${dto.prod_price }"></fmt:formatNumber>원<br></td>
            <tr>
            <tr align = "center">
               <td colspan = "2"><input type="button"
                  onclick="location.href = 'prodEdit.admin'" value="수정">
               <input type="button"
                  onclick="location.href = 'prodDelete.admin?prod_num=${dto.prod_num}'" value="삭제">
               <input type="button"
                  onclick="location.href = 'prodList.admin'" value="목록으로"></td>
            </tr>
         </table>
      </div>
   </div>
   </div>
   
   <script src="resources/js/slides.js"></script>
</body>
</html>
<%@ include file = "../../bottom.jsp"%>