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
   function changeAddress(user_num){
	    window.open("changeAddress.user?user_num="+user_num+"&mode=D", '', "width=720, height=780,scrollbars=yes, resizable=no, left=pixels")
	}
	function addAddress() {
	    var p = document.getElementById('prod_num').value;
	    window.open("shop_addAddress.user?prod_num="+p+"&mode=D", '',"width=720, height=780,scrollbars=yes, resizable=no, left=pixels")
	}
	
	function inputFocus(e){
		$("#prod_price_hr").css('border','1px solid');
	}
	
	function inputBlur(e){
		$("#prod_price_hr").css('border','');
	}
	function checkPrice(e){
		var price = Number(${dto.prod_price});
		e.value = e.value.replace(/[^0-9]/gi, '')
		var sell_price = Number(e.value);
		//가격 범위 0.9보다크게
		if(price*0.9 > sell_price){
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
	}

	$(function() {
		if(document.getElementById('bank_name').value != '') isAccount = true;
		if(document.getElementById('name').value != '') isAddress = true;
		//input을 datepicker로 선언
		$("#datepicker").datepicker(
				{
					dateFormat : 'y/mm/dd' //달력 날짜 형태
				});
		$("#datepicker2").datepicker(
				{
					dateFormat : 'y/mm/dd' //달력 날짜 형태
					,
					showOtherMonths : true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
					,
					showMonthAfterYear : true // 월- 년 순서가아닌 년도 - 월 순서
					,
					changeYear : true //option값 년 선택 가능
					,
					changeMonth : true //option값  월 선택 가능                
					,
					showOn : "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
					,
					buttonImage : ""//"http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
					,
					buttonImageOnly : true //버튼 이미지만 깔끔하게 보이게함
					,
					buttonText : "" //버튼 호버 텍스트              
					,
					yearSuffix : "년" //달력의 년도 부분 뒤 텍스트
					,
					monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ] //달력의 월 부분 텍스트
					,
					monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월',
							'8월', '9월', '10월', '11월', '12월' ] //달력의 월 부분 Tooltip
					,
					dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ] //달력의 요일 텍스트
					,
					dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일', '금요일',
							'토요일' ] //달력의 요일 Tooltip
					,
					minDate : "D+1" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
					,
					maxDate : "+5y" //최대 선택일자(+1D:하루후, +1M:한달후, +1Y:일년후)  
				});

		//초기값을 오늘 날짜로 설정해줘야 합니다.
		$('#datepicker').datepicker('setDate','today');
		$('#datepicker2').datepicker('setDate', 'today+1D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)            

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
            <td colspan="2"><font size="10px">판매상품 상세 정보</font></td>
         </tr>
         <tr>
            <td rowspan="4">
            	<img src="${upPath}/${dto.prod_img1}" width="100px" height="100px">
            </td>
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
      </table>
      <form name="f" action="addSellProd.user" method="post">
         <input type="hidden" name="user_num" value="${sessionUser_num}">
         <input type="hidden" name="prod_group" value="${dto.prod_group} ">
         <input type="hidden" name="prod_size" value="${dto.prod_size}">
         <input type="hidden" name="auction" value="W">
    
     
     <!-- 판매계좌 -->
      <hr align="center" width="70%">
     <div class="row" style="margin-top: 20px;">
     	<div class="col">
     		<font size="6px">판매계좌</font>
     	</div>
     </div>
     <div class="row">
     	<div class="col">
	     	<table>
	     		<tr>
	     			<c:if test="${not empty accountDTO}">
	     			<th><font size="3px" color="gray">은행명</font></th>
	     			</c:if>
	     			<th style="display:none;" id="bank_name_subject"><font size="3px" color="gray">은행명</font></th>
	     			<th><input type="text" id="bank_name" name="bank_name" 
	     				style="border:none;size:3px; color:gray;font-weight:bold;" 
	     				value="${accountDTO.bank_name}" readOnly></th>
	     			<c:if test="${empty accountDTO}">
	     			<th rowspan="3" id="emptyAccount"><font size="5px" color="black" >등록된 계좌가 없습니다.</font></th>
	     			</c:if>
	     		</tr>
	     		<tr>
	     			<c:if test="${not empty accountDTO}">
	     			<th><font size="3px" color="gray">계좌번호</font></th>
	     			</c:if>
	     			<th style="display:none;" id="account_num_subject"><font size="3px" color="gray">계좌번호</font></th>
	     			<th><input type="text" id="account_num" name="account_num" 
	     				style="border:none;size:3px; color:gray;font-weight:bold;" 
	     				value="${accountDTO.account_num}" readOnly></th>
	     		</tr>
	     		<tr>
	     			<c:if test="${not empty accountDTO}">
	     			<th><font size="3px" color="gray">예금주</font></th>
	     			</c:if>
	     			<th style="display:none;" id="account_owner_subject"><font size="3px" color="gray">예금주</font></th>
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
        
        
      <!-- 반송 주소 -->   
      <hr align="center" width="70%">
       <div class="row" style="margin-top: 20px;">
     	<div class="col" style="margin-left: 10%;">
     		<font size="6px">반송주소</font>
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
			     			<th><font size="3px" color="gray">반송주소&nbsp;</font></th>
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
         
     <!-- 입찰 기간 -->   
      <hr align="center" width="70%">
       <div class="row" style="margin-top: 20px;">
     	<div class="col">
     		<font size="6px">입찰 기간</font>
     	</div>
     </div>    
     <div class="row">
     	<div class="col">
     		<input type="text" id="datepicker" name="cal1"  size="6" disabled class="btn btn-outline-dark" >&nbsp;&nbsp;&nbsp;~ &nbsp;&nbsp;&nbsp;
		 	<input type="text" id="datepicker2" name="end_date" size="6"readOnly class="btn btn-outline-dark" >
     	</div>
     </div>    
         
      <!-- 판매 희망가 -->   
      <hr align="center" width="70%">
       <div class="row" style="margin-top: 20px;">
     	<div class="col">
     		<font size="6px">판매 희망가</font>
     	</div>
       </div>        
       <div class="row">
     	<div class="col">
     		<div align="center" style="width:50%;">
     			<div align="left"><b>판매 희망가</b></div>
     			<div align="right"><input type="text" id="prod_price" name="prod_price" style="border:none; width:50%;" dir="rtl" 
     								onfocus="inputFocus(this)" onblur="inputBlur(this)" oninput="checkPrice(this)">원</div>
     			<hr id="prod_price_hr">
     			<div align="right" id="prod_price_warn" style="display:none;"><font color="red">${dto.prod_price}의 90% 보다 큰 가격부터 작성 하실 수 있습니다.</font></div>
     		</div>
     	</div>
     </div>     
         
         <!-- 판매 등록 -->
         <hr align="center" width="70%">
         <div class="row" style="margin-top: 20px;">
         	<div class="col">
        		 <button type="submit" id="confirm" class="btn btn-outline-dark"
            		width="400" disabled>판매등록</button>
            </div>
         </div>   
      </form>
   </div>
   </div>
</body>
</html>
<%@include file="../../bottom.jsp"%>