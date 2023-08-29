<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@include file="../top.jsp"%>

<header class="header">
   <div class="container-fluid">
      <div class="col-xl-6 col-lg-7">
         <nav class="header__menu">
            <ul>
            	<li><a href="sales.admin">매입매출</a>
               <li><a href="prodList.admin">상품</a>
                  <ul class="dropdown">
                     <li><a href="prodCateInput.admin">카테고리 등록</a></li>
                     <li><a href="prodCateList.admin">카테고리 목록</a></li>
                     <li><a href="prodInput.admin">상품 등록</a></li>
                     <li><a href="prodList.admin">상품 목록</a></li>
                     <li><a href="prodList.admin?del=Y">삭제상품목록</a></li>
                     <li><a href="prod_qty_list.admin">재고임박상품목록</a></li>
                  </ul></li>
               <li><a href="memberList.admin">회원</a>
                  <ul class="dropdown">
                     <li><a href="memberList.admin">회원 보기</a></li>
                     <li><a href="memberList.admin?del=Y">탈퇴 회원 보기</a></li>
                           <li><a href="memberReport.admin?process=wait">신고처리대기</a></li>
                           <li><a href="memberReport.admin?process=ok">신고처리완료</a></li>
                  </ul></li>
               <li><a href="QnABoardList.admin">게시글</a>
                  <ul class="dropdown">
                     <li><a href="QnACateList.admin">QnA카테고리</a></li>
                     <li><a href="QnABoardList.admin">공지사항</a></li>
                     <li><a href="QnABoardList.admin?qna_cate=ask">문의 내역 목록</a></li>
                     <li><a href="QnABoardList.admin?qna_cate=ask&process=wait">문의내역 처리대기</a></li>
                     <li><a href="QnABoardList.admin?qna_cate=ask&process=ok">문의내역 처리완료</a></li>
                  </ul></li>
                  <li><a href = "pickProdList.admin">추천</a>
                  <ul class = "dropdown">
                  					<li><a href="pickCateList.admin">추천상품카테고리목록</a></li>
                                    <li><a href="pickProdList.admin">추천상품목록</a></li>
                                    <li><a href="pickProdInput.admin">추천상품등록</a></li>
                                    <li><a href="pickHashTag.admin">해시태그 추천 목록</a></li>
                                    <li><a href="pickSearch.admin">추천 검색어 목록</a></li>
                  </ul>
                  </li>
            </ul>
         </nav>
      </div>
   </div>
</header>

