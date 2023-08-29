<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../admin_top.jsp"%>
<script>
	function qty_edit(prod_num, pageNum) {
		window.open("qty_edit.admin?prod_num=" + prod_num + "&pageNum="
				+ pageNum, "", "width = 600,height = 300")
	}
	function send(str) {
		var st = str;
		location.href = "prodList.admin?mode=type&type=" + encodeURI(st);
	}
	   
	   function pickSearch(search){
	      var searchString = search;
	      location.href('shop.user?searchString='+encodeURI(searchString))
	   }
	   function searchList(upPath,num){
	      $('#searchResult *').remove();
	      $('#moreShow *').remove();
	      var co = Number(num);
	      var searchString = document.getElementById('search').value;
	      if(searchString == ""){
	         return
	      }
	      $.ajax({
	         url : './qty_list.admin', 
	         type : 'post', 
	         data : {
	            searchString : searchString
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
	 	               document.getElementById('moreShow').appendChild(bt);
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
	               var img = '<img src="'+upPath+'/'+obj.prod_img1+'" width="50",height="50">';
	               var str =  '<a href="prodEdit.admin?prod_num='+obj.prod_num+'">'+img+prod_subject+'</a>'
	               $('#searchResult').append(str);
	               if(count == co){
	                     break
	               }
	            }
	         },
	      });
	   }
</script>
<html>
<head>
<title>재고임박 목록</title>
</head>
<body>
	<div align="center" id = "basicFont">
	<h3>재고 임박 상품목록</h3>
	<br>
		<table class = "table table-hover" style = "width:60%">
			<tr align="center">
				<th>상품명</th>
				<th>사이즈</th>
				<th>이미지</th>
				<th>수량</th>
				<th>직접입력</th>
			</tr>
			<c:forEach var="dto" items="${list }">
				<tr align="center">
					<td><a href="size_qty_edit.admin?prod_num=${dto.prod_group}">${dto.prod_kr_subject}</a></td>
					<td>${dto.prod_size}</td>
					<td><img src="${upPath }/${dto.prod_img1}" width="100px"
						height="100px"></td>
					<td>${dto.prod_qty }</td>
					<td><input type="button" class="btn btn-outline-dark"
						onclick="qty_edit('${dto.prod_num}','${pageNum}')" value="수량입력"></td>
				</tr>
			</c:forEach>
		</table>
		<c:if test = "${count != 0 }">
		<c:if test="${startPage > pageBlock }">
		[<a href="prod_qty_list.admin?pageNum=${startPage - pageBlock }">이전</a>]
	</c:if>
		<c:forEach var="i" begin="${startPage }" end="${endPage }">
		[<a href="prod_qty_list.admin?pageNum=${i }">${i }</a>]
		</c:forEach>
		<c:if test="${endPage < pageCount }">
		[<a href="prod_qty_list.admin?pageNum=${endPage + 1 }">다음</a>]
		</c:if>
		</c:if>
	</div>
	<div align="center">
	<div class="row">
		<div class="col">
			상품 검색:
			<input type="text" class = "form-control" style="display:inline;width:50%" id="search" oninput="searchList('${upPath}','5')"
				onkeypress="search(event)" placeholder="상품명을 입력하세요."
				value="${searchString}" size="30">
			<div id="searchResult"></div>
			<div id="moreShow"></div>
		</div>
	</div>
	</div>
</body>
</div>
</html>
<%@include file="../../bottom.jsp"%>