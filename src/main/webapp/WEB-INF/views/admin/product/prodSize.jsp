<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@include file="../admin_top.jsp"%>
<script>
function size_qty(i,qty){
      window.open("size_qty.admin?i="+i+"&qty="+qty,"","width=600,height=250")
    
}
function cloths_qty(size,qty){
   window.open("another_size_qty.admin?i="+size+"&qty="+qty,"","width=600,height=250") 
}
</script>
<html>
<head>
<title>상품 수량수정</title>
</head>
<form name="f" action="size_qty_edit.admin" method="post">
   <div align="center" id = "basicFont">
      <h3>상품정보</h3>
      <img src="${upPath }/${dto.prod_img1}" width="50px" height="50px">
      ${dto.prod_subject }<br> ${dto.prod_kr_subject }
   </div>
   <div class="size-popup" id="size-popup">
      <div class="modal-dialog">
         <div class="modal-content" align = "center">
            <h3 style="color: #585858;">사이즈선택</h3>
            <hr color="Black" style="width: 100%; height: 1px;" align  = "center">
            <div id="sizeButton" class="container">
                  <c:if
                     test="${dto.cate_kr_type eq '상의' || dto.cate_kr_type eq '하의' || dto.cate_kr_type eq '아우터' }">
                     <c:forEach var="dto" items="${list }">
                        <input type="button" class="btn btn-outline-dark"
                           onclick="cloths_qty('${dto.prod_size}','${dto.prod_qty }')"
                           id="${dto.prod_size }" value="${dto.prod_size += ' : ' += dto.prod_qty }" />
                     </c:forEach>
                  </c:if>
               <c:if test="${dto.cate_kr_type eq '신발' }">
                  <c:forEach var="i" begin="220" end="300" step="5">
                     <c:forEach var="dto" items="${list }">
                        <c:if test="${dto.prod_size == i}">
                           <input type="button" class="btn btn-outline-dark" id="${i}"
                              name="${i}" value="${i += ' : ' += dto.prod_qty }"
                              onclick="size_qty('${i}','${dto.prod_qty }')" />
                        </c:if>
                     </c:forEach>
                  </c:forEach>
               </c:if>
               <c:if
                  test="${dto.cate_kr_type != '상의' && dto.cate_kr_type != '하의' && dto.cate_kr_type != '아우터' && dto.cate_kr_type != '신발'  }">
                  <c:forEach var="dto" items="${list }">
                     <input type="button" class="btn btn-outline-dark"
                        onclick="cloths_qty('${dto.prod_size}','${dto.prod_qty}')"
                        id="${dto.prod_size }" value="${dto.prod_size += ' : ' += dto.prod_qty }" />
                  </c:forEach>
               </c:if>
            </div>
            <div align="center">
               <input type="hidden" value="${dto.prod_num }" name="prod_num">
               <button type="submit" id="confirm" class="btn btn-outline-dark">확인</button>
            </div>
         </div>
      </div>
   </div>
   <div id="selectAdd"></div>
</form>
</div>
</html>
<%@include file="../../bottom.jsp"%>