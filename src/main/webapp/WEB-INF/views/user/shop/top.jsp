<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../../top.jsp"%>
<style>
@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
.shopTop{
	font-family : 'GmarketSansMedium';
}
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
</style>
<script>
var isFirst = true;
$(document).ready(function(){
	document.getElementById('searchBar').value = '${searchString}';
});
function searchList(upPath,num){
	if(isFirst){
		isFirst = false;
		return
	}
    $('#searchResult *').remove();
    $('#moreShow *').remove(); 
    var searchString = document.getElementById('searchBar').value;
    if($("#searchBar").val() == ""){
    	var str = '<div>'+"검색 결과가 없습니다."+'</div>';
    	$('#searchResult').append(str);
    	return
    }
    var co = Number(num);
    $.ajax({
       url : './searchList.user', 
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
               bt.className = 'btn btn-outline-dark';
               bt.onclick = function() {
                  searchList(upPath,(co + 5));
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
                break;
             }
          }
          
       },
    });
 }
 
 function sendType(cate){
	 location.href = 'shop.user?cate_kr_type='+encodeURI(cate);
 }
 

 
 
 
</script>
<!-- 상단 카테고리(대분류) 부분 -->
<header class = "header">
	<div class ="shopTop" align = "center">
			<div class="container-fluid">
				<div class="col-xl-6 col-lg-7">
		<nav class="header__menu">
			<c:if test="${empty searchString}">
				<div class="col" align="center">
					<h3>
						<b>SHOP</b>
					</h3>
				</div>
			</c:if>
			<c:if test="${!empty searchString}">
				<div class="row justify-content-center" style="margin-bottom: 10pt;">
					<form class="search-model-form" method="post" action="shop.user">
						<input style="font-size: 25px; height: 45px;" type="text"
							id="searchBar" name="searchString" 
							oninput="searchList('${upPath}','5')"
							placeholder="상품명을 입력해주세요.">
					</form>
				</div>
				<div id="searchResult" class="basicFont"></div>
				<div id="moreShow"></div>
			</c:if>
			<div align="center">
				<ul>
					<li><a href="shop.user" style="font-size: 15px;">전체</a> 
					<c:forEach	var="dto" items="${cateList}">
						<li><a href="javascript:sendType('${dto}')" style="font-size: 15px;">${dto}</a>
					</c:forEach>
				</ul>
			</div>
		</nav>
		</div>
		</div>
	</div>
</header>