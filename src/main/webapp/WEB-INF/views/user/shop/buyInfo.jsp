<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@include file="top.jsp"%>
<style>
   input[type=text]::-ms-clear {
      display:none;
   }
</style>
<script>
var isAccount = false;
var isAddress = false;
var isPrice = false;
function openAccountAdd(user_num){
      window.open('sellAccount.user?user_num='+user_num, '', "width=720, height=780,scrollbars=yes, resizable=no, left=pixels");
}
function check(){
   var deliverDiv = document.getElementById("deliveryNeed");
   var choice = document.getElementById("delivery").value;
   if(choice == '1'){
      alert("배송요청사항을 선택해 주세요 ")
      return;
   }
   if(choice == '6'){
         if(document.getElementById("requestUser").value == null || document.getElementById("requestUser").value == ''){
            alert("배송 요구사항을 입력해주세요 !")
            document.getElemnetById("requestUser").focus();
            return;
      }
   }
   else{
      document.f.submit();  
   }
   
}
function changeCard(){
   window.open("shop_changeCard.user","","width=720, height=780,scrollbars=yes, resizable=no, left=pixels")
}
function changeAddress(user_num){
    window.open("changeAddress.user?user_num="+user_num+"&mode=D", '',"width=720, height=780,scrollbars=yes, resizable=no, left=pixels")
}
function addAddress() {
    var p = document.getElementById('prod_num').value;
    window.open("shop_addAddress.user?prod_num="+p+"&mode=D", '', "width=720, height=780,scrollbars=yes, resizable=no, left=pixels")
}
   function deliveryNeeds() {
       var val = document.getElementById('delivery');
      var id = document.getElementById('deliveryNeed');
      if (val.value == '6') {
         var add = document.createElement('input');
         add.type = "text";
         add.name = "requestUser";
         add.id = "requestUser";
         id.appendChild(add);
      }

      else {
         if (id.childElementCount > 1) {
            id.removeChild(id.lastChild);
         }
      } 
   }
   function addCard(){
      window.open("shop_addCard.user","","width=720, height=780,scrollbars=yes, resizable=no, left=pixels")
   }
   function payChange(style){
         if(style == 'acc'){
            document.getElementById('accountPay').style.display = 'block';
            document.getElementById('cardPay').style.display = 'none';
            document.getElementById('confirm').disabled = true;
            if(!document.getElementById('emptyAccount') && isAddress){
               document.getElementById('confirm').disabled = false;
            }
            if(isAddress  && document.getElementById('emptyAccount') && document.getElementById('bank_name').value != ''){
               document.getElementById('confirm').disabled = false;
            }
         }
         else if(style == 'card'){
            document.getElementById('accountPay').style.display = 'none'; 
            document.getElementById('cardPay').style.display = 'block';
            document.getElementById('confirm').disabled = true;
         if(!document.getElementById('emptyCard') && isAddress){
               document.getElementById('confirm').disabled = false;
            } 
          if(isAddress && document.getElementById('emptyAccount') && document.getElementById('first_bank_name').value != ''){
               document.getElementById('confirm').disabled = false;
           }
         }
      }
   $(function() {
      if(document.getElementById('bank_name').value != '') isAccount = true;
      if(document.getElementById('name').value != '') isAddress = true;
   });
   
   function checkPoint(e){
      if(${member.point} < e.value){
         $("#pointOver").show();
      }else{
         $("#pointOver").hide();
         $("#usingPoint").text(e.value);
         var total = ${dto.prod_price} - e.value;
         $("#totalPrice").text(total)
      }
   }
   function pointFocus(e){
      e.value = '';
      $("#usingPoint").text(e.value);
   }
   function pointBlur(e){
      if(e.value == ''){
         e.value = '0';
         $("#pointOver").hide();
         $("#usingPoint").text(e.value);
         var total = ${dto.prod_price} - e.value;
         $("#totalPrice").text(total)
      }
   }
   function usingPointAll(){
      $("#point").val(${member.point})
      $("#usingPoint").text(${member.point});
      var total = ${dto.prod_price} - ${member.point};
      $("#totalPrice").text(total)
   }
</script>
<html>
<head>
<title>Insert title here</title>
</head>
<body>

   <form name="f" action="buy_ok.user" method="post">
      <div align="center" class="basicFont">
         <input type="hidden" value="${dto.prod_num }" name="prod_num"
            id="prod_num"> <input type="hidden" value="${mode}"
            id="mode">
         <table>
            <tr align="center">
               <td colspan="2">구매상품 상세 정보</td>
            </tr>
            <tr>
               <td rowspan="5"><img src="${upPath }/${dto.prod_img1}"
                  width="100px" height="100px"></td>
            </tr>
            <tr>
               <th>${dto.prod_subject }</th>
            </tr>
            <tr>
               <td>${dto.prod_kr_subject }</td>
            </tr>
            <tr>
               <th>${dto.prod_price }</th>
            </tr>
            <tr>
               <th>${dto.prod_size }</th>
            </tr>
         </table>
         <hr align="center" width="70%">
         <div class="row" style="margin-top: 20px;">
            <div class="col">
               <font size="6px">배송받을주소</font>
            </div>
         </div>
         <div class="row">
            <div class="col">
               <table>
                  <c:if test="${empty addressList}">
                     <tr id="emptyAddress">
                        <th rowspan="3"><font size="5" color="black">등록된 주소가 없습니다.</font></th>
                     </tr>
                     <tr id="first_name" style="display: none;">
                        <th><font size="3px" color="gray">받는사람&nbsp;</font></th>
                        <th><input type="text" id="name" name="name"
                           style="border: none; size: 3px; color: gray; font-weight: bold;"
                           readOnly></th>
                     </tr>
                     <tr id="first_phone" style="display: none;">
                        <th><font size="3px" color="gray">연락처&nbsp;</font></th>
                        <th><input type="text" id="phone" name="phone_num"
                           style="border: none; size: 3px; color: gray; font-weight: bold;"
                           readOnly></th>
                     </tr>
                     <tr id="first_addr" style="display: none;">
                        <th><font size="3px" color="gray">배송주소&nbsp;</font></th>
                        <th><input type="text" id="addr"
                           style="border: none; size: 3px; color: gray; font-weight: bold;"
                           size="50" readOnly></th>
                     </tr>
                     <input type="hidden" id="address1" name="address1">
                     <input type="hidden" id="address2" name="address2">
                     <input type="hidden" id="address3" name="address3">
                  </c:if>
                  <c:forEach var="addressDTO" items="${addressList}">
                     <c:if test="${addressDTO.basic == 'Y'}">
                        <tr>
                           <th><font size="3px" color="gray">받는사람&nbsp;</font></th>
                           <th><input type="text" id="name" name="name"
                              style="border: none; size: 3px; color: gray; font-weight: bold;"
                              value="${addressDTO.name}" readOnly></th>
                        </tr>
                        <tr>
                           <th><font size="3px" color="gray">연락처&nbsp;</font></th>
                           <th><input type="text" id="phone" name="phone_num"
                              style="border: none; size: 3px; color: gray; font-weight: bold;"
                              value="${addressDTO.phone_num}" readOnly></th>
                        </tr>
                        <tr>
                           <th><font size="3px" color="gray">배송주소&nbsp;</font></th>
                           <th><input type="text" id="addr"
                              style="border: none; size: 3px; color: gray; font-weight: bold;"
                              size="50"
                              value="${addressDTO.address1}${addressDTO.address2}${addressDTO.address3}"
                              readOnly></th>

                        </tr>
                        <input type="hidden" id="address1" name="address1"
                           value="${addressDTO.address1 }">
                        <input type="hidden" id="address2" name="address2"
                           value="${addressDTO.address2 }">
                        <input type="hidden" id="address3" name="address3"
                           value="${addressDTO.address3 }">
                     </c:if>

                  </c:forEach>
               </table>
            </div>
         </div>
         <div class="col">
            <c:if test="${empty addressList}">
               <input type="button" value="배송지를 추가해 주세요."
                  class="btn btn-outline-dark" id="address_bt_subject"
                  onclick="addAddress()">
               <input type="button" id="address_chBt_subject"
                  style="display: none;" onclick="changeAddress(${sessionUser_num})"
                  class="btn btn-outline-dark" value="변경">
            </c:if>
            <c:if test="${not empty addressList}">
               <input type="button" value="+새 배송지" class="btn btn-outline-dark"
                  onclick="addAddress()">
               <input type="button" onclick="changeAddress(${sessionUser_num})"
                  class="btn btn-outline-dark" value="변경">
            </c:if>
         </div>
         <br>
         <div class="row">
            <div class="col">
               <div id="deliveryNeed">
                  <select id="delivery" name="needs" onchange="deliveryNeeds()">
                     <option value="1" selected>= = = 선택  = = =</option>
                     <option value="요청사항없음">요청사항없음</option>
                     <option value="문앞에놓아주세요">문앞에 놓아주세요.</option>
                     <option value="경비실에 맡겨 주세요.">경비실에 맡겨 주세요.</option>
                     <option value="파손위험 상품입니다.배송시 주의해주세요.">파손위험 상품입니다. 배송시 주의해주세요.</option>
                     <option value="6">직접입력</option>
                  </select> <br>
               </div>
               
               
               <!-- 포인트 -->
               <font size="5px" color="Black">포인트 : ${member.point}</font><br> 
               <input type="number" id="point" name="point" dir="rtl" value="0" 
                  oninput="checkPoint(this)" onfocus="pointFocus(this)" onblur="pointBlur(this)">
               <input type="button" id="pointAll" class="btn btn-outline-dark" 
                  value="모두사용" onclick="usingPointAll()"><br>
               <font id="pointOver" size="3px" color="red" style="display:none;">${member.point} 보다 큰 포인트는 사용 할 수 없습니다.</font>
               <br>
                              
               <!-- 최종주문 -->
               <font size="5" color="Black">최종 주문 정보</font><br> 
               <table>
                  <tr><th colspan="2" align="left">총 결제금액</th></tr>
                  <tr><th colspan="2" align="right"><font size="7" color="Red" id="totalPrice">${dto.prod_price}</font></th></tr>
                  <tr><td align="left">구매가</td><td align="right">${dto.prod_price}</td></tr>
                  <tr><td align="left">포인트</td><td align="right" id="usingPoint">0</td></tr>
               </table>
               <br>
               
               
<!-- 결제 방법 -->
<font size="5px" color="Black"><b>결제 방법</b></font><br> 
<input type="radio" id = "payChoice" name="payChoice" value="account" onclick="payChange('acc')">
계좌 간편 결제 
<input type="radio" name="payChoice" value="card" onclick="payChange('card')">
카드 간편 결제 
<input type="hidden" name="payStyle" value="">
               
<!-- 계좌결제 -->
<div id="accountPay" style="display: none;">
   <div class="row">
   	<div class="col">
      <c:if test="${empty accountDTO}">
       <input type="button" value="계좌 추가"
         class="btn btn-outline-dark" id="account_bt_subject"
         onclick="openAccountAdd('${sessionUser_num}')">
      </c:if>
      <c:if test="${not empty accountDTO}">
      <input type="button" value="정산계좌변경"
         class="btn btn-outline-dark"
         onclick="openAccountAdd('${sessionUser_num}')">
      </c:if>
         <table>
            <tr>
               <c:if test="${not empty accountDTO}">
                  <th><font size="3px" color="gray">은행명</font></th>
               </c:if>
               <th style="display: none;" id="bank_name_subject">
               <font size="3px" color="gray">은행명</font></th>
               <th><input type="text" id="bank_name" name="bank_name"
                  style="border: none; size: 3px; color: gray; font-weight: bold;"
                  value="${accountDTO.bank_name}" readOnly></th>
               <c:if test="${empty accountDTO}">
               <th rowspan="3" id="emptyAccount"><font size="5px"
                  color="black">등록된 계좌가 없습니다.</font></th>
               </c:if>
            </tr>
            <tr>
            <c:if test="${not empty accountDTO}">
               <th><font size="3px" color="gray">계좌번호</font></th>
                              </c:if>
                              <th style="display: none;" id="account_num_subject"><font
                                 size="3px" color="gray">계좌번호</font></th>
                              <th><input type="text" id="account_num"
                                 name="account_num"
                                 style="border: none; size: 3px; color: gray; font-weight: bold;"
                                 value="${accountDTO.account_num}" readOnly></th>
                           </tr>
                           <tr>
                              <c:if test="${not empty accountDTO}">
                                 <th><font size="3px" color="gray">예금주</font></th>
                              </c:if>
                              <th style="display: none;" id="account_owner_subject"><font
                                 size="3px" color="gray">예금주</font></th>
                              <th><input type="text" id="account_owner"
                                 name="account_owner"
                                 style="border: none; size: 3px; color: gray; font-weight: bold;"
                                 value="${accountDTO.account_owner}" readOnly></th>
                           </tr>
                        </table>
                     </div>
                  </div>
                  </div>
                  
                  <!-- 카드 결제 -->
                  <div id="cardPay" style="display:none;">
                     <div class="row">
                        <div class="col">
                           <c:if test="${empty card}">
                              <input type="button" onclick="addCard()" id="emptyCard"
                                 class="btn btn-outline-dark" value="카드 추가하기">
                              <br>
                              <table>
                                 <tr id="first_bank">
                                    <th><font size="3px" color="gray"
                                       style="font-weight: bold;">카드사</font>
                                    <th><input type="text" value="" id="first_bank_name"
                                       name="bank_name"
                                       style="border: none; size: 3px; color: gray; font-weight: bold;"
                                       readOnly></th>
                                    <th rowspan="3"><input type="button"
                                       style="display:none;"
                                       value="변경" class="btn btn-outline-dark" id = "firstCardBt"
                                       onclick="changeCard()"></th>
                                 </tr>
                                 <tr id="first_num">
                                    <th><font size="3px" color="gray"
                                       style="font-weight: bold;">카드번호</font></th>
                                    <th><input type="text" value="" id="first_card_num"
                                       name="card_num"
                                       style="border: none; size: 3px; color: gray; font-weight: bold;"
                                       readOnly></th>
                                 </tr>
                                 <tr id="first_date">
                                    <th><font size="3px" color="gray"
                                       style="font-weight: bold;">유효기간</font></th>
                                    <th><input type="text" value="" id="first_card_date"
                                       name="card_date"
                                       style="border: none; size: 3px; color: gray; font-weight: bold;"
                                       readOnly></th>
                                 </tr>
                              </table>
                           </c:if>
                           <!-- 카드 있으면 -->
                           <c:if test="${not empty card }">
                              <c:forEach var="card" items="${card}">
                                 <c:if test="${card.basic eq 'Y' }">
                                    <table>
                                       <tr>
                                          <th><font size="3px" color="gray"
                                             style="font-weight: bold;">카드사</font></th>
                                          <th><input type="text" value="${card.bank_name}"
                                             name="back_name" id="card_name"
                                             style="border: none; size: 3px; color: gray; font-weight: bold;"
                                             readOnly></th>
                                          <th rowspan="3"><input type="button" value="변경"
                                             class="btn btn-outline-dark" onclick="changeCard()">
                                          </th>
                                       </tr>
                                       <tr>
                                          <th><font size="3px" color="gray"
                                             style="font-weight: bold;">카드번호</font></th>
                                          <th><input type="text" value="${card.card_num}"
                                             name="card_num" id="card_num"
                                             style="border: none; size: 3px; color: gray; font-weight: bold;"
                                             readOnly></th>
                                       </tr>
                                       <tr>
                                          <th><font size="3px" color="gray"
                                             style="font-weight: bold;">유효기간</font></th>
                                          <th><input type="text" value="${card.card_date}"
                                             name="card_date" id="card_date"
                                             style="border: none; size: 3px; color: gray; font-weight: bold;"
                                             readOnly></th>
                                       </tr>
                                    </table>
                                 </c:if>
                              </c:forEach>
                           </c:if>
                        </div>
                     </div>
                  </div>
                  <input type="hidden" name="user_num" value="${sessionUser_num}">
                  <input type="hidden" name="prod_num" value="${dto.prod_num}">
                  <input type="hidden" name="prod_group" value="${dto.prod_group} ">
                  <input type="hidden" name="prod_size" value="${dto.prod_size}">
                  <input type="hidden" name="prod_price" value="${dto.prod_price}">
                  <input type="hidden" name="auction" value="${mode}"> <br>
                  <button type="button" onclick="check()" id="confirm"
                     class="btn btn-outline-dark" width="400" disabled>구매하기</button>
               
            </div>
         </div>
         </div>
   </form>

</body>
</html>
<%@include file="../../bottom.jsp"%>