<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="resources/css/bootstrap.min.css"
   type="text/css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<style>
@font-face {
    font-family: 'Dovemayo_gothic';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.1/Dovemayo_gothic.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
.basicFont{
	font-family: 'Dovemayo_gothic';
}
#basicFont{
	font-family: 'Dovemayo_gothic';
}
a{
  color : black;
}
a:link {
  color : black;
}
a:visited {
  color : black;
}
a:hover{
	color : red;
	text-decoration : none;
}
</style>   
   <script>
      function openerSend(url) {
         window.opener.location.href = url;
         self.close();
      }
      function removeFollow(userNum) {
         $
               .ajax({
                  url : './removeFollow.user', //Controller에서 요청 받을 주소
                  type : 'post', //POST 방식으로 전달
                  data : {
                     userNum : userNum
                  },
                  cache : false,
                  success : function(map) {//컨트롤러에서 넘어온 cnt값을 받는다      
                     if (map.checkFollowing == 3) {
                        var bt = document.getElementsByName(userNum
                              + 'follow');
                        for (i = 0; i < bt.length; ++i) {
                           bt[i].value = "맞팔로우";
                           bt[i].onclick = function() {
                              addFollow(userNum);
                           }
                        }
                     } else {
                        var bt = document.getElementsByName(userNum
                              + 'follow');
                        for (i = 0; i < bt.length; ++i) {
                           bt[i].value = "팔로우";
                           bt[i].onclick = function() {
                              addFollow(userNum);
                           }
                        }
                     }

                  }

               });

      };
      function addFollow(userNum) {
         $.ajax({
            url : './addFollow.user', //Controller에서 요청 받을 주소
            type : 'post', //POST 방식으로 전달
            data : {
               userNum : userNum
            },
            cache : false,
            success : function(followerSu) {//컨트롤러에서 넘어온 cnt값을 받는다  
               alert("팔로우 성공")
               var bt = document.getElementsByName(userNum + 'follow');
               for (i = 0; i < bt.length; ++i) {
                  bt[i].value = "팔로우취소";
                  bt[i].onclick = function() {
                     removeFollow(userNum);
                  }
               }
            }
         });

      };
   </script>
<body>
<div class="basicFont">
   <c:if test="${empty allList}">
      <font size="10px" color="black">알림이 없습니다.</font>
   </c:if>
   <c:if test="${not empty allList}">
      <c:forEach var="dto" items="${allList}">
         <!-- 좋아요 알림 -->
         <c:if test="${dto.alarm_kind eq 'like' }">
            <table width="100%" align="center">
               <tr>
                  <td align="left" rowspan="4" width="20%"><a href="javascript:openerSend('myProfile.user?user_num=${dto.sendUser_num}')"><img
                        src="${upPath}/${dto.profile_img}" height="100" width="100"
                        class="rounded-circle"
                        onerror="this.src='https://blog.kakaocdn.net/dn/c3vWTf/btqUuNfnDsf/VQMbJlQW4ywjeI8cUE91OK/img.jpg'"></a>
                  </td>
                  <td><a
                     href="javascript:openerSend('myProfile.user?user_num=${dto.sendUser_num}')">${dto.profile_name }님이
                        회원님의 게시글을 좋아합니다.</a></td>
                  <td></td>
                  <td align="right"><a
                     href="javascript:openerSend('styleView.user?styleNum=${dto.alarm_kind_num}&userNum=${dto.getUser_num }')"><img
                        src="${upPath}/${dto.style_img1 }" width="100" height="100"></a>
               </tr>
               <tr>
                  <td rowspan="2"><font size="2px" color="gray">
                        <input type="text" name="cal" value="${dto.reg_date}"
                        style="size: 2px; color: gray; border: none;"
                        onshow="javascript:test()" readOnly>
                  </font></td>
               </tr>
            </table>
         </c:if>
         <!--팔로우 알림  -->
         <c:if test="${dto.alarm_kind eq 'follow' }">
            <table width="100%" align="center">
               <tr>
                  <td align="left" rowspan="4" width="20%"><a href="javascript:openerSend('myProfile.user?user_num=${dto.sendUser_num}')"><img
                        src="${upPath}/${dto.profile_img}" height="100" width="100"
                        class="rounded-circle"
                        onerror="this.src='https://blog.kakaocdn.net/dn/c3vWTf/btqUuNfnDsf/VQMbJlQW4ywjeI8cUE91OK/img.jpg'"></a>
                  </td>
                  <td><a
                     href="javascript:openerSend('myProfile.user?user_num=${dto.sendUser_num}')">${dto.profile_name }님이
                        회원님을 팔로우 하기 시작했습니다.</a></td>
                  <td align="right"><c:if test="${dto.followCheck == 1 }">
                        <input type="button" id="${dto.sendUser_num}follow" class="btn btn-outline-dark"
                           name="${dto.sendUser_num}follow" value="팔로우 "
                           onclick="addFollow('${dto.sendUser_num}')" />
                     </c:if> <c:if test="${dto.followCheck == 2 }">
                        <input type="button" id="${dto.sendUser_num}follow" class="btn btn-outline-dark"
                           name="${dto.sendUser_num}follow" value="팔로우취소 "
                           onclick="removeFollow('${dto.sendUser_num}')" />
                     </c:if> <c:if test="${dto.followCheck == 3 }">
                        <input type="button" id="${dto.sendUser_num}follow" class="btn btn-outline-dark"
                           name="${dto.sendUser_num}follow" value="맞팔로우 "
                           onclick="addFollow('${dto.sendUser_num}')" />
                     </c:if></td>
               </tr>
               <tr>
                  <td rowspan="2"><font size="2px" color="gray">
                        <input type="text" name="cal" value="${dto.reg_date}"
                        style="size: 2px; color: gray; border: none;" readOnly>
                  </font></td>
               </tr>
            </table>
         </c:if>
         <!-- 댓글 알림  -->
         <c:if test="${dto.alarm_kind eq 'style_reply' }">
            <table width="100%" align="center">
               <tr>
                  <td align="left" rowspan="4" width="20%"><a
                     href="javascript:openerSend('myProfile.user?user_num=${dto.sendUser_num}')"><img
                        src="${upPath}/${dto.profile_img}" height="100" width="100"
                        class="rounded-circle"
                        onerror="this.src='https://blog.kakaocdn.net/dn/c3vWTf/btqUuNfnDsf/VQMbJlQW4ywjeI8cUE91OK/img.jpg'"></a>
                  </td>
                  <td><a
                     href="javascript:openerSend('myProfile.user?user_num=${dto.sendUser_num}')">${dto.profile_name }님이
                        회원님의 게시물에 댓글을 남겼습니다.</a></td>
                  <td align="right"><a
                     href="javascript:openerSend('styleView.user?styleNum=${dto.alarm_kind_num}&userNum=${dto.getUser_num }')"><img
                        src="${upPath }/${dto.style_img1 }" height="100" width="100"></a></td>
               </tr>
               <tr>
                  <td rowspan="2"><font size="2px" color="gray">
                        <input type="text" name="cal" value="${dto.reg_date}"
                        style="size: 2px; color: gray; border: none;" readOnly>
                  </font></td>
               </tr>
            </table>
         </c:if>
         <c:if test="${dto.alarm_kind eq 'style_reReply' }">
            <table width="100%" align="center">
               <tr>
                  <td align="left" rowspan="4" width="20%"><a
                     href="javascript:openerSend('myProfile.user?user_num=${dto.sendUser_num}')"><img
                        src="${upPath}/${dto.profile_img}" height="100" width="100"
                        class="rounded-circle"
                        onerror="this.src='https://blog.kakaocdn.net/dn/c3vWTf/btqUuNfnDsf/VQMbJlQW4ywjeI8cUE91OK/img.jpg'"></a>
                  </td>
                  <td><a
                     href="javascript:openerSend('myProfile.user?user_num=${dto.sendUser_num}')">${dto.profile_name }님이
                        회원님의 댓글에 답글을 남겼습니다.</a></td>
                  <td align="right"><a
                     href="javascript:openerSend('styleView.user?styleNum=${dto.alarm_kind_num}&userNum=${dto.getUser_num }')"><img
                        src="${upPath }/${dto.style_img1 }" height="100" width="100"></a></td>
               </tr>
               <tr>
                  <td rowspan="2"><font size="2px" color="gray">
                        <input type="text" name="cal" value="${dto.reg_date}"
                        style="size: 2px; color: gray; border: none;" readOnly>
                  </font></td>
               </tr>
            </table>
         </c:if>
         <c:if test="${dto.alarm_kind eq 'tag_reply' }">
            <table width="100%" align="center">
               <tr>
                  <td align="left" rowspan="4" width="20%"><a
                     href="javascript:openerSend('myProfile.user?user_num=${dto.sendUser_num}')"><img
                        src="${upPath}/${dto.profile_img}" height="100" width="100"
                        class="rounded-circle"
                        onerror="this.src='https://blog.kakaocdn.net/dn/c3vWTf/btqUuNfnDsf/VQMbJlQW4ywjeI8cUE91OK/img.jpg'"></a>
                  </td>
                  <td><a
                     href="javascript:openerSend('myProfile.user?user_num=${dto.sendUser_num}')">${dto.profile_name }님이
                        댓글에서 회원님을 언급 하였습니다.</a></td>
                  <td align="right"><a
                     href="javascript:openerSend('styleView.user?styleNum=${dto.alarm_kind_num}&userNum=${dto.getUser_num }')"><img
                        src="${upPath }/${dto.style_img1 }" width="100" height="100"></a></td>
               </tr>
               <tr>
                  <td rowspan="2"><font size="2px" color="gray">
                        <input type="text" name="cal" value="${dto.reg_date}"
                        style="size: 2px; color: gray; border: none;" readOnly>
                  </font></td>
               </tr>
            </table>
         </c:if>
         <c:if test="${dto.alarm_kind eq 'tag_reReply' }">
            <table width="100%" align="center">
               <tr>
                  <td align="left" rowspan="4" width="20%"><a
                     href="javascript:openerSend('myProfile.user?user_num=${dto.sendUser_num}')"><img
                        src="${upPath}/${dto.profile_img}" height="100" width="100"
                        class="rounded-circle"
                        onerror="this.src='https://blog.kakaocdn.net/dn/c3vWTf/btqUuNfnDsf/VQMbJlQW4ywjeI8cUE91OK/img.jpg'"></a>
                  </td>
                  <td><a
                     href="javascript:openerSend('myProfile.user?user_num=${dto.sendUser_num}')">${dto.profile_name }님이
                        댓글의 답글에서 회원님을 언급 하였습니다.</a></td>
                  <td align="right"><a
                     href="javascript:openerSend('styleView.user?styleNum=${dto.alarm_kind_num}&userNum=${dto.getUser_num }')"><img
                        src="${upPath }/${dto.style_img1 }" width="100" height="100"></a></td>
               </tr>
               <tr>
                  <td rowspan="2"><font size="2px" color="gray">
                        <input type="text" name="cal" value="${dto.reg_date}"
                        style="size: 2px; color: gray; border: none;" readOnly>
                  </font></td>
               </tr>
            </table>
         </c:if>
         <!-- 게시물 아이디태그 알림 -->
         <c:if test="${dto.alarm_kind eq 'tag_id' }">
            <table width="100%" align="center">
               <tr>
                  <td align="left" rowspan="4" width="20%"><a href="javascript:openerSend('myProfile.user?user_num=${dto.sendUser_num}')"><img
                        src="${upPath}/${dto.profile_img}" height="100" width="100"
                        class="rounded-circle"
                        onerror="this.src='https://blog.kakaocdn.net/dn/c3vWTf/btqUuNfnDsf/VQMbJlQW4ywjeI8cUE91OK/img.jpg'"></a>
                  </td>
                  <td><a
                     href="javascript:openerSend('myProfile.user?user_num=${dto.sendUser_num}')">${dto.profile_name }님이
                        회원님을 언급 하였습니다.</a><a href="javascript:openerSend('myProfile.user?user_num=${dto.getUser_num}')">@${dto.myProfile_name }</a>
                  </td>
                  <td align="right"><a
                     href="javascript:openerSend('styleView.user?styleNum=${dto.alarm_kind_num}&userNum=${dto.getUser_num }')"><img
                        src="${upPath }/${dto.style_img1 }" width="100" height="100"></a></td>
               </tr>
               <tr>
                  <td rowspan="2"><font size="2px" color="gray">
                        <input type="text" name="cal" value="${dto.reg_date}"
                        style="size: 2px; color: gray; border: none;" readOnly>
                  </font></td>
               </tr>
            </table>
         </c:if>

         <c:if
            test="${dto.alarm_kind eq 'cart_price' && dto.sendUser_num != 0 }">
            <table width="100%" align="center">
               <tr>
                  <td align="left" rowspan="4" width="20%"><a
                     href="javascript:openerSend('prodView.user?prod_num=${dto.prod_price}')"><img
                        src="${upPath}/${dto.profile_img}" height="100" width="100"></a>
                  </td>
                  <td>
                  <a href="javascript:openerSend('prodView.user?prod_num=${dto.prod_price}')">${dto.prod_kr_subject }
                        	상품의 <font color="Red">가격</font>이 ${dto.sendUser_num }에서
                        ${dto.followCheck }으로 변경되었습니다.
                  </a></td>
               </tr>
               <tr>
                  <td rowspan="2" width="20%"><font size="2px" color="gray">
                        <input type="text" name="cal" value="${dto.reg_date}"
                        style="size: 2px; color: gray; border: none;" readOnly>
                  </font></td>
               </tr>
            </table>
         </c:if>
         <c:if test="${dto.alarm_kind eq 'cart_qty' }">
            <table width="100%" align="center">
               <tr>
                  <td align="left" rowspan="4" width="20%"><a
                     href="javascript:openerSend('prodView.user?prod_num=${dto.prod_price}')"><img
                        src="${upPath}/${dto.profile_img}" height="100" width="100"></a>
                  </td>
                  <td><a
                     href="javascript:openerSend('prodView.user?prod_num=${dto.prod_price}')">${dto.prod_kr_subject }
                        상품의 <font color="Red">수량</font>이 재입고되었습니다.
                  </a></td>
               </tr>
               <tr>
                  <td rowspan="2" width="20%"><font size="2px" color="gray">
                        <input type="text" name="cal" value="${dto.reg_date}"
                        style="size: 2px; color: gray; border: none;" readOnly>
                  </font></td>
               </tr>
            </table>
         </c:if>
         <c:if test="${dto.alarm_kind eq 'buy_auction' }">
            <table width="100%" align="center">
               <tr>
               <c:if test = "${dto.auction != 'X'  }">
                  <td align="left" rowspan="4" width="20%"><a
                     href="javascript:openerSend('sellDetail.user?sell_num=${dto.sell_num }&auction=${dto.auction }')"><img
                        src="${upPath}/${dto.profile_img}" height="100" width="100"></a>
                  </td>
                  <td>${dto.prod_kr_subject}</td>
                  <td width="20%"><a
                     href="javascript:openerSend('sellDetail.user?sell_num=${dto.sell_num }&auction=${dto.auction }')">${dto.prod_kr_subject }
                        ${dto.profile_name} 님께서 </a></td>
                        </c:if>
                        <c:if test = "${dto.auction eq 'X'}">
                  <td rowspan="4" width="20%"><a
                     href="javascript:openerSend('sellDetail.user?sell_num=${dto.sell_num }&auction=Y')"><img
                        src="${upPath}/${dto.profile_img}" height="100" width="100"></a>
                  </td>
                  <td>${dto.prod_kr_subject }</td>
                  <td width="20%"><a
                     href="javascript:openerSend('sellDetail.user?sell_num=${dto.sell_num }&auction=Y')">${dto.prod_kr_subject }
                        ${dto.profile_name} 님께서 </a></td>
                        </c:if>
               </tr>
               <tr>
                  <td>${dto.prod_size }</td>
                  <td>${dto.followCheck}원에구매입찰을 등록 하였습니다.</td>
               </tr>
               <tr>
                  <td>${dto.prod_price }</td>
                  <td rowspan="2" width="20%"><font size="2px" color="gray">
                        <input type="text" name="cal" value="${dto.reg_date}"
                        style="size: 2px; color: gray; border: none;" readOnly>
                  </font></td>
               </tr>
            </table>
         </c:if>
         <c:if test="${dto.alarm_kind eq 'sell_auction' }">
            <table width="100%" align="center">
               <tr>
                  <td rowspan="4" width="20%"><a
                     href="javascript:openerSend('buyDetail.user?buy_num=${dto.alarm_kind_num}&auction=${dto.auction }')"><img
                        src="${upPath}/${dto.profile_img}" height="100" width="100"></a>
                  </td>
                  <td>${dto.prod_kr_subject }</td>
                  <td width="20%"><a
                     href="javascript:openerSend('buyDetail.user?buy_num=${dto.alarm_kind_num }&auction=${dto.auction }')">${dto.prod_kr_subject }상품의
                        입찰이 종료되었습니다. </a></td>
               </tr>
               <tr>
                  <td>${dto.prod_size }</td>
                  <td><font color="Red">구매실패</font></td>
               </tr>
               <tr>
                  <td rowspan="2" width="20%"><font size="2px" color="gray">
                        <input type="text" name="cal" value="${dto.reg_date}"
                        style="size: 2px; color: gray; border: none;" readOnly>
                  </font></td>
               </tr>
            </table>
         </c:if>
         <c:if test="${dto.alarm_kind eq 'buyDead' }">
            <table width="100%" align="center">
               <tr>
                  <td rowspan="4" width="20%"><a
                     href="javascript:openerSend('buyDetail.user?buy_num=${dto.alarm_kind_num}&auction=X')"><img
                        src="${upPath}/${dto.profile_img}" height="100" width="100"></a>
                  </td>
                  <td>${dto.prod_kr_subject }</td>
                  <td width="20%"><a
                     href="javascript:openerSend('buyDetail.user?buy_num=${dto.alarm_kind_num }&auction=X')">${dto.prod_kr_subject }상품의
                        입찰기간 만료로 입찰이 종료되었습니다. </a></td>
               </tr>
               <tr>
                  <td>${dto.prod_size }</td>
                  <td><font color="Red">입찰실패</font></td>
               </tr>
               <tr>
                  <td rowspan="2" width="20%"><font size="2px" color="gray">
                        <input type="text" name="cal" value="${dto.reg_date}"
                        style="size: 2px; color: gray; border: none;" readOnly>
                  </font></td>
               </tr>
            </table>
         </c:if>
         <c:if test="${dto.alarm_kind eq 'sellDead' }">
            <table width="100%" align="center">
               <tr>
                  <td rowspan="4" width="20%"><a
                     href="javascript:openerSend('sellDetail.user?sell_num=${dto.alarm_kind_num}&auction=X')"><img
                        src="${upPath}/${dto.profile_img}" height="100" width="100"></a>
                  </td>
                  <td>${dto.prod_kr_subject }</td>
                  <td width="20%"><a
                     href="javascript:openerSend('sellDetail.user?sell_num=${dto.alarm_kind_num }&auction=X')">${dto.prod_kr_subject }상품의
                        입찰기간 만료로 판매가 종료되었습니다. </a></td>
               </tr>
               <tr>
                  <td>${dto.prod_size }</td>
                  <td><font color="Red">판매실패</font></td>
               </tr>
               <tr>
                  <td rowspan="2" width="20%"><font size="2px" color="gray">
                        <input type="text" name="cal" value="${dto.reg_date}"
                        style="size: 2px; color: gray; border: none;" readOnly>
                  </font></td>
               </tr>
            </table>
         </c:if>
         <c:if test="${dto.alarm_kind eq 'sell_success' }">
            <table width="100%" align="center">
               <tr>
                  <td rowspan="4" width="20%"><a
                     href="javascript:openerSend('buyDetail.user?buy_num=${dto.alarm_kind_num }&auction=${dto.auction }')"><img
                        src="${upPath}/${dto.profile_img}" height="100" width="100"></a>
                  </td>
                  <td>${dto.prod_kr_subject }</td>
                  <td width="20%"><a
                     href="javascript:openerSend('buyDetail.user?buy_num=${dto.alarm_kind_num }&auction=${dto.auction }')">${dto.prod_kr_subject }
                        상품을 낙찰 하셨습니다 . </a></td>
               </tr>
               <tr>
                  <td>${dto.prod_size }</td>
                  <td><font color="Blue">구매성공</font></td>
               </tr>
               <tr>
                  <td rowspan="2" width="20%"><font size="2px" color="gray">
                        <input type="text" name="cal" value="${dto.reg_date}"
                        style="size: 2px; color: gray; border: none;" readOnly>
                  </font></td>
               </tr>
            </table>
         </c:if>
         <c:if test="${dto.alarm_kind eq 'announce' }">
            <table width="100%" align="center">
               <tr>
                  <td rowspan="4" width="20%" align="center"><a
                     href="javascript:openerSend('qnaView.user?qna_num=${dto.alarm_kind_num }')">
                        <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50"
                           fill="currentColor" class="bi bi-megaphone-fill"
                           viewBox="0 0 16 16">
  <path
                              d="M13 2.5a1.5 1.5 0 0 1 3 0v11a1.5 1.5 0 0 1-3 0v-11zm-1 .724c-2.067.95-4.539 1.481-7 1.656v6.237a25.222 25.222 0 0 1 1.088.085c2.053.204 4.038.668 5.912 1.56V3.224zm-8 7.841V4.934c-.68.027-1.399.043-2.008.053A2.02 2.02 0 0 0 0 7v2c0 1.106.896 1.996 1.994 2.009a68.14 68.14 0 0 1 .496.008 64 64 0 0 1 1.51.048zm1.39 1.081c.285.021.569.047.85.078l.253 1.69a1 1 0 0 1-.983 1.187h-.548a1 1 0 0 1-.916-.599l-1.314-2.48a65.81 65.81 0 0 1 1.692.064c.327.017.65.037.966.06z" />
</svg>
                  </a></td>
                  <td colspan = "2">[공지]<a
                     href="javascript:openerSend('buyDetail.user?buy_num=${dto.buy_num }&auction=${dto.auction }')">
                        ${dto.prod_kr_subject } </a></td>
               </tr>
               <tr>
                  <td>공지사항이 등록 되었습니다.</td>
               </tr>
               <tr>
                  <td rowspan="2" width="20%"><font size="2px" color="gray">
                        <input type="text" name="cal" value="${dto.reg_date}"
                        style="size: 2px; color: gray; border: none;" readOnly>
                  </font></td>
               </tr>
            </table>
         </c:if>
         <c:if test="${dto.alarm_kind eq 'report' }">
            <table width="100%" align="center">
               <tr>
                  <td rowspan="4" width="20%" align = "center">
                        <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-exclamation-triangle" viewBox="0 0 16 16">
  <path d="M7.938 2.016A.13.13 0 0 1 8.002 2a.13.13 0 0 1 .063.016.146.146 0 0 1 .054.057l6.857 11.667c.036.06.035.124.002.183a.163.163 0 0 1-.054.06.116.116 0 0 1-.066.017H1.146a.115.115 0 0 1-.066-.017.163.163 0 0 1-.054-.06.176.176 0 0 1 .002-.183L7.884 2.073a.147.147 0 0 1 .054-.057zm1.044-.45a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566z"/>
  <path d="M7.002 12a1 1 0 1 1 2 0 1 1 0 0 1-2 0zM7.1 5.995a.905.905 0 1 1 1.8 0l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995z"/>
</svg>
                  </td>
                  <td>[신고] 신고가 접수되어 페널티가 부과됩니다.</td>
               <td width = "20%"> 5점 이상시 경매 입찰 불가 등 불이익이 생기실수 있습니다. </td>
               </tr>
               <tr>
                  <td>현재 페널티: 
                  <c:if test= "${dto.penalty  >= 5 }">
                  <font color = "Red">${dto.penalty }</font>
                  </c:if>
                  <c:if test = "${dto.penalty <5 }">
                  ${dto.penalty }
                  </c:if>
                   </td>
                   <td>신고사유 : ${dto.info}</td>
               </tr>
               <tr>
                  <td rowspan="2" width="20%"><font size="2px" color="gray">
                        <input type="text" name="cal" value="${dto.reg_date}"
                        style="size: 2px; color: gray; border: none;" readOnly>
                  </font></td>
               </tr>
            </table>
         </c:if>
         <c:if test= "${dto.alarm_kind eq 'ask' }">
                     <table width="100%" align="center">
               <tr>
                  <td rowspan="4" width="20%" align = "center"><a
                     href="javascript:openerSend('qnaView.user?qna_num=${dto.alarm_kind_num }')">
                        <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-chat-right-text" viewBox="0 0 16 16">
  <path d="M2 1a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h9.586a2 2 0 0 1 1.414.586l2 2V2a1 1 0 0 0-1-1H2zm12-1a2 2 0 0 1 2 2v12.793a.5.5 0 0 1-.854.353l-2.853-2.853a1 1 0 0 0-.707-.293H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h12z"/>
  <path d="M3 3.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zM3 6a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9A.5.5 0 0 1 3 6zm0 2.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z"/>
</svg>
                  </a></td>
                  <td colspan = "2">[1:1문의]<a
                     href="javascript:openerSend('qnaView.user?qna_num=${dto.alarm_kind_num }')">
                        ${dto.prod_kr_subject } </a></td>
               </tr>
               <tr>
                  <td>문의하신사항에 답변이 등록 되었습니다.</td>
               </tr>
               <tr>
                  <td rowspan="2" width="20%"><font size="2px" color="gray">
                        <input type="text" name="cal" value="${dto.reg_date}"
                        style="size: 2px; color: gray; border: none;" readOnly>
                  </font></td>
               </tr>
            </table>
         
         </c:if>
         <hr>
      </c:forEach>
   </c:if>
   </div>
</body>
</html>