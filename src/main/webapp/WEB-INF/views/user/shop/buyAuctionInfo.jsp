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
	   document.f.submit();  
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
   function openAccountAdd(user_num){
		window.open('sellAccount.user?user_num='+user_num, '', "width=720, height=780,scrollbars=yes, resizable=no, left=pixels");
   }
   function changeAddress(user_num){
	    window.open("changeAddress.user?user_num="+user_num+"&mode=D", '', "width=720, height=780,scrollbars=yes, resizable=no, left=pixels")
	}
	function addAddress() {
	    var p = document.getElementById('prod_num').value;
	    window.open("shop_addAddress.user?prod_num="+p+"&mode=D", '',"width=720, height=780,scrollbars=yes, resizable=no, left=pixels")
	}
	
	function inputFocus(e){
		e.value = '';
		$("#prod_price_hr").css('border','1px solid');
	}
	
	function inputBlur(e){
		var price = e.value;
		if(price == '' || price == 0) {
			e.value = 0;
			isPrice = false;
			$("#confirm").attr('disabled',true);
		}
		$("#prod_price_hr").css('border','');
	}
	function checkPrice(e){
		var price = Number(${max_price});
		e.value = e.value.replace(/[^0-9]/gi, '')
		var buy_price = Number(e.value);
		if(price > buy_price){
			$("#prod_price_hr").css('color','red');
			$("#prod_price_warn").show();
			isPrice = false;
			$("#confirm").attr('disabled',true);
		}else{
			isPrice = true;
			$("#prod_price_hr").css('color','black');
			$("#prod_price_warn").hide();
			if(isAccount && isAddress && isPrice){
				$("#confirm").attr('disabled',false);
			}
		}
		if(e.value == 0){
			isPrice = false;
			$("#confirm").attr('disabled',true);
		}
	}

	$(function() {
		if(document.getElementById('bank_name').value != '') isAccount = true;
		if(document.getElementById('name').value != '') isAddress = true;
		var cal = document.getElementsByName('cal');
		for(var i=0;i<cal.length;++i){
			cal[i].value = cal[i].value.split(' ')[0];
		}
	});
</script>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
   <div align="center" class="basicFont">
      <input type="hidden" value="${dto.prod_num}" name="prod_num" id = "prod_num">
      <input type="hidden" value="W"  id = "auction">
      <table>
         <tr align="center">
            <td colspan="2"><font size="10px">구매입찰 상세 정보</font></td>
         </tr>
         <tr>
            <td rowspan="6"><img src="${upPath}/${dto.prod_img1}" width="100px" height="100px"></td>
         </tr>
         <tr>
            <td>판매 희망가 : ${dto.prod_price}</td>
         </tr>
         <tr>
            <th>${dto.prod_subject}</th>
         </tr>
         <tr>
            <td>${dto.prod_kr_subject}</td>
         </tr>
         <tr>
            <th>${dto.prod_size}</th>
         </tr>
         <tr>
         	<td>${dto.start_date} ~ ${dto.end_date}</td>
         </tr>
      </table>
      <form name="f" action="addBuyAuctionProd.user" method="post">
         <input type="hidden" name="user_num" value="${sessionUser_num}">
         <input type="hidden" name="prod_group" value="${dto.prod_group} ">
         <input type="hidden" name="prod_size" value="${dto.prod_size}">
         <input type="hidden" name="auction" value="W">
    	 <input type="hidden" name="prod_num" value="${dto.sell_num}">
     
     <!-- 판매계좌 -->
      <hr align="center" width="70%">
     <div class="row" style="margin-top: 20px;">
     	<div class="col">
     		<font size="6px">정산계좌</font>
     	</div>
     </div>
     <div class="row">
     	<div class="col">
	     	<table>
	     		<tr>
	     			<c:if test="${not empty accountDTO}">
	     			<th><font size="3px" color="gray">은행명&nbsp;</font></th>
	     			</c:if>
	     			<th style="display:none;" id="bank_name_subject"><font size="3px" color="gray">은행명&nbsp;</font></th>
	     			<th><input type="text" id="bank_name" name="bank_name" 
	     				style="border:none;size:3px; color:gray;font-weight:bold;" 
	     				value="${accountDTO.bank_name}" readOnly></th>
	     			<c:if test="${empty accountDTO}">
	     			<th rowspan="3" id="emptyAccount"><font size="5px" color="black" >등록된 계좌가 없습니다.</font></th>
	     			</c:if>
	     		</tr>
	     		<tr>
	     			<c:if test="${not empty accountDTO}">
	     			<th><font size="3px" color="gray">계좌번호&nbsp;</font></th>
	     			</c:if>
	     			<th style="display:none;" id="account_num_subject"><font size="3px" color="gray">계좌번호&nbsp;</font></th>
	     			<th><input type="text" id="account_num" name="account_num" 
	     				style="border:none;size:3px; color:gray;font-weight:bold;" 
	     				value="${accountDTO.account_num}" readOnly></th>
	     		</tr>
	     		<tr>
	     			<c:if test="${not empty accountDTO}">
	     			<th><font size="3px" color="gray">예금주&nbsp;</font></th>
	     			</c:if>
	     			<th style="display:none;" id="account_owner_subject"><font size="3px" color="gray">예금주&nbsp;</font></th>
	     			<th><input type="text" id="account_owner" name="account_owner" 
	     			 style="border:none;size:3px; color:gray;font-weight:bold;" 
	     			 value="${accountDTO.account_owner}" readOnly></th>
	     		</tr>
	     	</table>
     	</div>
     	<div class="col">
     		<c:if test="${empty accountDTO}">
     			<input type="button" value="계좌추가" class="btn btn-outline-dark" id="account_bt_subject"
     				onclick="openAccountAdd('${sessionUser_num}')">
     		</c:if>
     		<c:if test="${not empty accountDTO}">
     			<input type="button" value="정산계좌변경" class="btn btn-outline-dark" 
     				onclick="openAccountAdd('${sessionUser_num}')">
     		</c:if>
     	</div>
     </div>
        
        
      <!-- 배송 주소 -->   
      <hr align="center" width="70%">
       <div class="row" style="margin-top: 20px;">
     	<div class="col">
     		<font size="6px">배송주소</font>
     	</div>
     </div>
      <div class="row">
     	<div class="col" style="margin-left: 10%;">
	     	<table>
	     		<c:if test="${empty addressList}">
	     			<tr id="emptyAddress"><th rowspan="3"><font size="5" color="black">등록된 주소가 없습니다.</font></th></tr>
	     			<tr id="first_name" style="display:none;">
			     		<th><font size="3px" color="gray">받는사람&nbsp;</font></th>
			     		<th><input type="text" id="name" name="name" style="border:none;size:3px; color:gray;font-weight:bold;" readOnly></th>
			     	</tr>
			     	<tr id="first_phone" style="display:none;">
			     		<th><font size="3px" color="gray">연락처&nbsp;</font></th>
			     		<th><input type="text" id="phone" name="phone_num" style="border:none;size:3px; color:gray;font-weight:bold;" readOnly></th>
			     	</tr>
			     	<tr id="first_addr" style="display:none;">
			     		<th><font size="3px" color="gray">반송주소&nbsp;</font></th>
			     		<th><input type="text" id="addr" style="border:none;size:3px; color:gray;font-weight:bold;" size="50" readOnly></th>
			     	</tr>
			     	<input type="hidden" id="address1" name="address1">
     				<input type="hidden" id="address2" name="address2">
     				<input type="hidden" id="address3" name="address3">
	     		</c:if>
	     		<c:forEach var="addressDTO" items="${addressList}">
	     			<c:if test="${addressDTO.basic == 'Y'}">
			     		<tr>
			     			<th><font size="3px" color="gray">받는사람&nbsp;</font></th>
			     			<th><input type="text" id="name" name="name" style="border:none;size:3px; color:gray;font-weight:bold;" value="${addressDTO.name}" readOnly></th>
			     		</tr>
			     		<tr>
			     			<th><font size="3px" color="gray">연락처&nbsp;</font></th>
			     			<th><input type="text" id="phone" name="phone_num" style="border:none;size:3px; color:gray;font-weight:bold;" value="${addressDTO.phone_num}" readOnly></th>
			     		</tr>
			     		<tr>
			     			<th><font size="3px" color="gray">배송주소&nbsp;</font></th>
			     			<th><input type="text" id="addr"  
			     				style="border:none;size:3px; color:gray;font-weight:bold;" size="50"
			     				value="${addressDTO.address1}${addressDTO.address2}${addressDTO.address3}" readOnly></th>
			     		</tr>
			     		<input type="hidden" id="address1" name="address1" value="${addressDTO.address1}">
     	 				<input type="hidden" id="address2" name="address2" value="${addressDTO.address2}">
     	 				<input type="hidden" id="address3" name="address3" value="${addressDTO.address3}">
		     		</c:if>
	     		</c:forEach>
	     	</table>
     	</div>
     	<div class="col">
     			<c:if test="${empty addressList}">
               		<input type="button" value="배송지를 추가해 주세요." class="btn btn-outline-dark"
                  	    id="address_bt_subject" onclick="addAddress()">
                  	<input type="button" id="address_chBt_subject" style="display:none;"
                        onclick="changeAddress(${sessionUser_num})"
                        class="btn btn-outline-dark" value="변경">
        		 </c:if>
        		 <c:if test="${not empty addressList}">
        		 	<input type="button" value="+새 배송지" class="btn btn-outline-dark"
                           onclick="addAddress()">
     				<input type="button"
                        onclick="changeAddress(${sessionUser_num})"
                        class="btn btn-outline-dark" value="변경">
                </c:if>
     	</div>
     </div>    
     <!-- 요청 사항 -->
     <div class="row" align="left" style="margin-left: 13%;">
     	<div class="col">
     		<div id="deliveryNeed">
				<select id="delivery" name="needs" onchange="deliveryNeeds()">
					<option value="1">= = = 선택 = = =</option>
					<option value="요청사항없음">요청사항없음</option>
					<option value="문앞에놓아주세요">문앞에 놓아주세요.</option>
					<option value="경비실에 맡겨 주세요.">경비실에 맡겨 주세요.</option>
					<option value="파손위험 상품입니다.배송시 주의해주세요.">파손위험 상품입니다. 배송시 주의해주세요.</option>
					<option value="6">직접입력</option>
				</select> <br>
			</div>
     	</div>
     </div>    
     <!-- 입찰 기간 -->   
      <hr align="center" width="70%">
       <div class="row" style="margin-top: 20px;">
     	<div class="col">
     		<font size="6px">입찰 기간</font>
     	</div>
     </div>    
     <div class="row">
     	<div class="col">
     		<input type="text" name="cal" value="${dto.start_date}" size="6" readOnly style="border:none;">~ &nbsp;&nbsp;&nbsp;
		 	<input type="text" name="cal" value="${dto.end_date}" size="6" readOnly style="border:none;">
     	</div>
     </div>    
         
      <!-- 구매 희망가 -->   
      <hr align="center" width="70%">
       <div class="row" style="margin-top: 20px;">
     	<div class="col">
     		<font size="6px">구매 희망가</font>
     	</div>
       </div>        
       <div class="row">
     	<div class="col">
     		<div align="center" style="width:50%;">
     			<div align="left"><b>구매 희망가</b></div>
     			<div align="right"><input type="text" id="prod_price" name="prod_price" value="0" style="border:none; width:50%;" dir="rtl" 
     								onfocus="inputFocus(this)" onblur="inputBlur(this)" oninput="checkPrice(this)">원</div>
     			<hr id="prod_price_hr">
     			<div align="right" id="prod_price_warn" style="display:none;"><font color="red">${max_price}보다 큰 값부터 입력가능합니다.</font></div>
     		</div>
     	</div>
     </div>     
         
         <!-- 구매 입찰 버튼 -->
         <hr align="center" width="70%">
         <div class="row" style="margin-top: 20px;">
         	<div class="col">
        		 <button type="button" id="confirm" class="btn btn-outline-dark" onclick="check()"
            		width="400" disabled>구매입찰</button>
            </div>
         </div>   
      </form>
   </div>
   </div>
</body>
</html>
<%@include file="../../bottom.jsp"%>