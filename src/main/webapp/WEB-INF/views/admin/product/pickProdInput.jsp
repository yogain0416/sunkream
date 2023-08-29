<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@include file="../admin_top.jsp"%>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
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
   function addProdPick(prod_num,subject){
      alert(subject)
      $('#searchResult *').remove();
      document.getElementById("prod_num").value = prod_num;
      document.getElementById("search").value = subject;
   }
   function searchList(upPath,num){
         $('#searchResult *').remove();
         $('#moreShow *').remove();
         var co = Number(num);
         var searchString = document.getElementById('search').value;
         var gender = $('input[name=gender]:checked').val();
         if(searchString == ""){
            return
         }
         $.ajax({
            url : './searchList.user', 
            type : 'post', 
            data : {
               searchString : searchString,
                gender: gender
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
                  var str =  '<a href="javascript:addProdPick('+"'"+obj.prod_num+"','"+obj.subject+"'"+')">'+img+prod_subject+'</a>'
                  $('#searchResult').append(str);
                  if(count == co){
                      break
                   }
               }
               
            },
         });
      }
   function cateSelect(value) {
      if(value == 'tab_brand'){
         $("#pick_name > option").remove();
         $("#pick_kr_name > option").remove();
         $("#pick_name").append("<option value ='===선택==='>===선택===</option>");
         $("#pick_kr_name").append("<option value ='===선택==='>===선택===</option>");
      }
      if(value == 'pick_name'){
         $("#pick_kr_name > option").remove();
         $("#pick_kr_name").append("<option value ='===선택==='>===선택===</option>");
      }
      var cate_code = null;
      var id = '';
      var input_id ='';
      var result = '';
      var val = '';
      if (value == 'tab_name') {
         cate_code = document.getElementById('tab_name').value;
         val = document.getElementById('tab_name').value;
         id = 'tabName';
         result = 'pick_name';
      }
      ;
      if (value == 'pick_name') {
         cate_code = document.getElementById('pick_name').value;
         val = document.getElementById('pick_name').value;
         id = 'pickName';
         result = 'pick_kr_name';
      }
      ;
      if(value == 'pick_kr_name'){
         result = document.getElementById('tab_name').value;
         cate_code = document.getElementById('pick_name').value;
         val = document.getElementById('pick_kr_name').value;
      }
      var div = document.getElementById(id);
      alert("cate_code:"+cate_code)
      alert("val:"+val)
      $.ajax({
         url : './pickCate.admin',
         type : 'post',
         data : {
            str : value,
            cate_code : cate_code,
            val : val,
            result : result   
            },
         
         cache : false,
         success : function(list) {
            if(value == "tab_name"){
               alert("pick_name ="+list[0].pick_name)
               for(var i in list ){
                  $("#pick_name").append("<option value ='"+list[i].pick_name+"'>"+list[i].pick_name+ "</option>");
               }
            }
            if(value == "pick_name"){
               for(var i in list ){
                  $("#pick_kr_name").append("<option value ='"+list[i].pick_kr_name+"'>"+list[i].pick_kr_name +"</option>");
               }
               
            }
            if(value == "pick_kr_name"){
               document.getElementById("cate_num").value = list[0].cate_num;
            }
         },
         error : function() {
            alert("에러");
         }
      });
   };
   function check(){
      var tab = document.getElementById("tab_name").value;
      var pick = document.getElementById("pick_name").value;
      var pick_kr = document.getElementById("pick_kr_name").value;
      var search = document.getElementById("search").value;
      var prod_num = document.getElementById("prod_num").value;
      var cate_num    = document.getElementById("cate_num").value;
      if(tab == '===선택==='||pick == '===선택==='||pick_kr == '===선택===' || cate_num == ''){
         alert("카테고리를 선택해 주세요.")
         return false;
      }
      if(search == '' || search ==null || prod_num == '' ){
         alert("등록할 상품을 검색해주세요."+search)
         document.getElementById("search").focus();
         return false;
      }
      else {
         document.d.submit()
      }
   }
</script>

<html>
<head>
<meta charset="UTF-8">
<title>pickProdList</title>
</head>
<body>
   <div class="div3" id = "basicFont">
      <div align="center">
         <form name="d" method="POST" action="pickProdInput.admin">
            <table class = "table table-hover" style = "width:70%;">
               <tr align="center">
                  <th>카테고리 탭</th>
                  <td><div id="tabName">
                        <select name="tab_name" id="tab_name"
                           onchange="javascript:cateSelect('tab_name')">
                           <option value="선택" id="tab" selected>===선택===</option>
                           <c:forEach var="dto" items="${pickCateList}">
                              <option value="${dto}" id="tab">${dto}</option>
                           </c:forEach>
                        </select>
                     </div></td>
               </tr>
               <tr align="center">
                  <th>추천명(영어)</th>
                  <td><div id="pickName">
                        <select name="pick_name" id="pick_name"
                           onchange="javascript:cateSelect('pick_name')">
                           <option value="선택" id="pick_n" selected>===선택===</option>
                        </select>
                     </div></td>
               </tr>
               <tr align="center">
                  <th>추천명(한글)</th>
                  <td><div id="pickKrName">
                        <select name="pick_kr_name" id="pick_kr_name"
                           onchange="javascript:cateSelect('pick_kr_name')">
                           <option value="선택" id="pick_kr" selected>===선택===</option>
                        </select>
                     </div></td>
               </tr>
                  <c:if test="${empty pickCateList }">
                     <tr>
                        <td colspan="3" align="center">추천상품 카테고리가 없습니다 .</td>
                     </tr>
                  </c:if>
            </table>
            <input type="hidden" value="" name="cate_num" id="cate_num"><br>
            <input type="hidden" value="" name="prod_num" id="prod_num"><br>
            <div id="pickSearch">
               <input type="radio" id="gender" name="gender" value="All" checked>
               <label for="gender">전체</label> <input type="radio" id="gender"
                  name="gender" value="M"> <label for="gender">남성</label>

               <input type="radio" id="gender" name="gender" value="F">
               <label for="gender">여성</label><br> 상품 검색:<input type="text" id="search"
                  oninput="searchList('${upPath}','5')" class = "form-control" style = "display:inline;width:30%;" onkeypress="search(event)"
                  placeholder="추천상품명을 입력하세요." size="30"><br>
            </div>
            <div id="searchResult"></div>
            <div id="moreShow"></div>
            <input type="button" onclick="check()" value="추천상품 등록" class="btn btn-outline-dark">
         </form>
      </div>
   </div>
   </div>
</body>
</html>
<%@include file="../../bottom.jsp"%>