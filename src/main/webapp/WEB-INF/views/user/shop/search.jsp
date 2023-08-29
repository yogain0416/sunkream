<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search</title>
</head>
<link rel="stylesheet" href="resources/css/bootstrap.min.css"
   type="text/css">
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
  color : blue;
  font-weight:bold;
}
a:link {
  color : blue;
  font-weight:bold;
}
a:visited {
  color : blue;
  font-weight:bold;
}
a:hover{
	color : red;
	font-weight:bold;
	text-decoration : none;
}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script type="text/javascript">
   function search(event){
      if(event.keyCode == 13){
         var searchString = document.getElementById('search').value;
         location.href('shop.user?searchString='+encodeURI(searchString))
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
      if(searchString == ""){
         return
      }
      var co=Number(num);

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
                  searchList(upPath,(co + 5))
               }
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
               var str = '<a href="javascript:pickSearch('+"'"+obj.subject+"'"+')">'+img+prod_subject+'</a>'
               $('#searchResult').append(str);
              if (count == co)
            break
            }
            
         },
      });
   }
   
   function clearAllCookie(){
      var isClear = confirm("검색 기록을 모두 삭제하시겠습니까?")
      if(isClear){
         $.ajax({
            url : './clearAllCookie.user', 
            type : 'post', 
            cache : false,
            success : function(){
               var div = document.getElementById('recentSearch')
               while (div.hasChildNodes()) {
                      div.removeChild(div.firstChild);
                  }
            }
         });
      }
   }
   function recentSearch(searchString){
      location.href('shop.user?searchString='+encodeURI(searchString))
   }
   function removeCookie(searchString){
      $.ajax({
         url : './removeCookie.user', 
         type : 'post', 
         data:{searchString:searchString},
         cache : false,
         success : function(){
            var div = document.getElementById(searchString);
            div.parentNode.removeChild(div);
         }
      });
   }
</script>
<body>
   <div align="left" class="basicFont">
      <!-- 검색창 -->
      <input type="text" id="search" oninput="searchList('${upPath}','5')"
      onkeypress="search(event)" placeholder="브랜드,모델명,모델번호 등" style="display:inline; width:95%; margin:10px;"
      class="form-control">
      <input type="button" value="X" style="border:none;" onclick="history.back()"
      class="btn btn-outline-dark">
      <div id="searchResult"></div>
      <div id="moreShow"></div>
      <hr>
      <!-- 최근검색어 -->
      <div id="recentSearch">
         <c:if test="${not empty ck}">
            <b>최근 검색어</b><font size="2px"><a href="javascript:clearAllCookie()">지우기</a></font><br>
            <table>
            <tr>
            <c:forEach var="ck" items="${ck}">
               <td>
                  <div id="${ck}">
                  <input type="button" value="${ck}" onclick="recentSearch('${ck}')" class="btn btn-outline-dark">
                  <input type="button" value="X" onclick="removeCookie('${ck}')" class="btn btn-outline-dark">
                  </div>
               </td>
            </c:forEach>
            </tr>
            </table>
         </c:if>
      </div>
      <!-- 추천 검색어 -->
      <h4><b>추천 검색어</b></h4>
      <table>
         <tr>
       <c:forEach var="pickSearch" items="${pickList}">
          <td>
          <input type="button" value="${pickSearch.search_name}" onclick="pickSearch('${pickSearch.search_name}')" class="btn btn-outline-dark">
          </td>
      </c:forEach> 
         </tr>
      </table>
      <h4><b>인기 검색어</b></h4>
      <table class="table table-hover">
      <c:set var="number" value="1"/>
       <c:forEach var="popSearch" items="${popList}">
          <c:if test="${number<=10}">
             <tr>
             <td width="5%"><h4>${number}</h4></td>
             <td><font size="4px"><a href="javascript:pickSearch('${popSearch.search_string}')">${popSearch.search_string}</a></font>
             </td>
             </tr>
             <c:set var="number" value="${number+1}"/>
          </c:if>
      </c:forEach> 
      </table>
   </div>
</body>
</html>