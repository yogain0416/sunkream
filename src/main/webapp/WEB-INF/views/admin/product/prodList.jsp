<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../admin_top.jsp"%>
<%@include file="sideBar_top.jsp" %>
<script>
	function sendCate(str){
		alert(str)
	}
	function sendSize(str){
		var del = document.getElementById('del').value;
		location.href = "prodList.admin?del="+del+"&type=prod_size&subType="+str;
	}
	function sendGender(gender){
		var del = document.getElementById('del').value;
		location.href = "prodList.admin?del="+del+"&type=prod_gender&subType="+gender;
	}
	function sendSubCate(str) {
		var st = str;
		var del = document.getElementById('del').value;
		location.href = "prodList.admin?del="+del+"&type=cate_kr_subType&subType="+encodeURI(st);
	}
	function sendBrand(str) {
		var st = str;
		var del = document.getElementById('del').value;
		location.href = "prodList.admin?del="+del+"&type=cate_brand&subType="+encodeURI(st);
	}
	window.onload = function(){
		document.getElementById('search').value = '';
		var div = document.getElementById('searchResult');
		while (div.firstChild) {
	    	div.removeChild(div.firstChild);
	    }
	}
	/* $(document).ready(function(){
		alert('하이')
		$('#searchResult *').remove();
	});  */
	 function search(event){
		 var searchString = document.getElementById('search').value;
		 var del = document.getElementById('del').value;
	      if(event.keyCode == 13 && del == 'N'){
	         location.href('prodSearch.admin?mode=N&searchString='+encodeURI(searchString))
	        
	      }
	      if(event.keyCode == 13 && del =='Y'){
	    	  location.href('prodSearch.admin?mode=Y&searchString='+encodeURI(searchString))
	      }	      
	      return
	   }
	   function pickSearch(search){
	      var searchString = search;
	      location.href('shop.user?searchString='+encodeURI(searchString))
	   }
	   function searchList(upPath,num){
	         $('#searchResult *').remove();
	         $('#moreShow *').remove();
	         var searchString = document.getElementById('search').value;
	         var del = document.getElementById('del').value;
	         var co = Number(num);
	         if(searchString == ""){
	            return
	         }
	         $.ajax({
	            url : './searchList.user', 
	            type : 'post', 
	            data : {
	               searchString : searchString,
	               mode:del
	            },
	            cache : false,
	            success : function(list) {
	            	if (list.length > co) {
	 	               var bt = document.createElement('input');
	 	               bt.type = 'button';
	 	               bt.value = '더보기';
	 	               bt.onclick = function() {
	 	                  searchList(upPath,(co + 5))
	 	               }
	 	               bt.className = 'btn btn-outline-info';
	 	               document.getElementById('moreShow')
	 	                     .appendChild(bt);
	 	            }
	               var count = 0;
	               if (list.length == 0) {
	                  $('#searchResult').append(
	                        '<p>' + "검색 결과 값이 없습니다." + '</p>');
	               }
	               for ( var i in list) {
	                  ++count;
	                  var obj = list[i];
	                  var prod_subject = '<font size="3">'+obj.subject+'</font><br>';
	                  var img = '<img src="'+upPath+'/'+obj.prod_img1+'" width="50",height="50">'
	                  var str =  '<a href="prodEdit.admin?prod_num='+obj.prod_num+'">'+img+prod_subject+'</a>'
	                  $('#searchResult').append(str);
	                  if(count == co){
	                     break
	                  }
	               }
	               
	            },
	         });
	      }
	   var isStart = true;
	   var isEnd = false; 
	   var count = 18;
	   window.onscroll = function(e) {
	   	var boxHeight = document.getElementById('product').clientHeight;
	   	var searchString = document.getElementById('searchString').value;
	   	var type = document.getElementById('type').value;
	   	var subType = document.getElementById('subType').value;
	   	var del = document.getElementById('del').value;
	   	var listSize = Number(document.getElementById('listSize').value);
	   	if(listSize <= 9){
	   		isEnd = true;
	   	}
	   	if(window.pageYOffset >= boxHeight/2 && !isEnd && isStart) { 
	   		var div = document.getElementById('product');
	   	  	isStart = false;
	   	  	$.ajax({
	   	  		url : './prodListScroll.admin',
	   	  		type : 'post',
	   	  		data : {
	   	  			searchString : searchString,
	   	  			type : type,
	   	  			subType : subType,
	   	  			del : del,
	   	  			count : count
	   	  		},
	   	  		cache : false,
	   	  		success : function(res) {
	   		  		while (div.firstChild) {
	   		  	    	div.removeChild(div.firstChild);
	   		  		}
	   		  		var html = jQuery('<div>').html(res);
	   		  		var contents = html.find("div#product").html();
	   		  		$("#product").html(contents);
	   		  		if(listSize <= count){
	   		  			isEnd = true;
	   		  		}else{
	   		  			isEnd = false;
	   		  			count += 9;
	   		  		}
	   		  		window.scrollBy(0, -200);
	   		  		isStart = true;
	   	  		},
	   	 	});
	   	}
	   }
</script>
	<input type = "hidden" id = "searchString" value = "${searchString}">
	<input type = "hidden" id = "upPath" value = "${upPath}">

	<input type = "hidden" id = "del" name = "del" value = "${del}">
	<input type = "hidden" id = "type" name = "type" value = "${type}">
	<input type = "hidden" id = "subType" name = "subType" value = "${subType}">
	<input type = "hidden" id = "listSize" value = "${listSize}">
	
		<div class="col-lg-9 col-md-9">
			<div class="row" id="product">
				<!-- 상품 없을때 -->
				<c:if test="${empty list}">
					<div>상품이 없습니다.</div>
				</c:if>
				
				<!-- 상품 -->
				<c:forEach var="dto" items="${list}">
					<div class="col-lg-4 col-md-6">
						<div class="product__item">
							<div class="product__item__text">
								<a href="prodEdit.admin?prod_num=${dto.prod_num }">
									<img src="${upPath}/${dto.prod_img1}" width="100px" height="100px">
									<h6>${dto.prod_subject}<br>${dto.prod_kr_subject}</h6>
									</a>
									<fmt:formatNumber value="${dto.prod_price}"></fmt:formatNumber>원
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
<%@ include file="sideBar_bottom.jsp" %>				
<%@ include file="../../bottom.jsp"%>