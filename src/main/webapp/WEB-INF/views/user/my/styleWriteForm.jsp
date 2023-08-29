<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@include file="top.jsp"%>
<!DOCTYPE html>
<html>
<head>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script>
/* $(document).keypress(function(e) {
   if (e.keyCode == 13)
      e.preventDefault();
}); */
attachFile = {
      add : function(asd) { // 파일필드 추가
         var idx = asd;
         var div = document.createElement('div');
         div.style.marginTop = '3px';
         div.id = 'file' + (idx+1);
         
         var check = document.getElementById('file'+idx).childElementCount;
         
         if(idx == 0){
            if(check == 2){
               document.getElementById('img0').src = document.getElementById('file_img0').value;
               return
            }else{
               var img = document.createElement('img');
               img.setAttribute("id",'img'+idx);
               img.setAttribute("src", document.getElementById('file_img'+idx).value);
               img.setAttribute("width", "50");
               img.setAttribute("height", "50");   
               document.getElementById('file'+idx).appendChild(img);
            }   
         }
         if(idx != 0){
            if(check == 2){
               var img = document.createElement('img');
               img.setAttribute("id",'img'+idx);
               img.setAttribute("src", document.getElementById('file_img'+idx).value);
               img.setAttribute("width", "50");
               img.setAttribute("height", "50");   
               document.getElementById('file'+idx).appendChild(img);
            }else if(check == 3){
               document.getElementById('img'+idx).src = document.getElementById('file_img'+idx).value;
               return
            }   
         }
         var file = document.all ? document
               .createElement('<input name="files">') : document
               .createElement('input');
         file.type = 'file';
         file.name = 'file_img'+(idx+1);
         file.size = '20';
         file.id = 'file_img' + (idx+1);
         file.onchange = function(){
            attachFile.add((idx+1));
         }
         file.multiple = 'multiple';
         
         var btn = document.createElement('input');
         btn.type = 'button';
         btn.value = '삭제';
         btn.onclick = function() {
            var isDel = confirm('삭제 하시겠습니까?')
            if(isDel && document.getElementById('file_img'+(idx+1)).value != ''){
               attachFile.del((idx+1));
            }
         }
         btn.style.marginLeft = '5px';
         var fileCount = document.getElementById('attachFileDiv').childElementCount;
         if(fileCount >= 5){
            return
         }
         document.getElementById('attachFileDiv').appendChild(div);   
         div.appendChild(file);
         div.appendChild(btn);
      },
      del : function(idx) { // 파일필드 삭제
         var fileCount = document.getElementById('attachFileDiv').childElementCount;
         if(fileCount == 5 && document.getElementById('file_img4').value != ''){
            document.getElementById('attachFileDiv').removeChild(document.getElementById('file' + idx));
            attachFile.delAdd(idx); 
            return
         }
         document.getElementById('attachFileDiv').removeChild(document.getElementById('file' + idx));
      },
      
      delAdd : function(idx){
         var div = document.createElement('div');
         div.style.marginTop = '3px';
         div.id = 'file' + idx;
         var file = document.all ? document
               .createElement('<input name="files">') : document
               .createElement('input');
         file.type = 'file';
         file.name = 'file_img'+idx;
         file.size = '20';
         file.id = 'file_img' + idx;
         file.onchange = function(){
            attachFile.add(idx);
         }
         
         
         var btn = document.createElement('input');
         btn.type = 'button';
         btn.value = '삭제';
         btn.onclick = function() {
            var isDel = confirm('삭제 하시겠습니까?')
            if(isDel && document.getElementById('file_img'+idx).value != ''){
               attachFile.del(idx);
            }
         }
         btn.style.marginLeft = '5px';
         var fileCount = document.getElementById('attachFileDiv').childElementCount;
         if(fileCount >= 5){
            alert("파일은 총 5개만 등록 가능합니다.")
            return
         }
         document.getElementById('attachFileDiv').appendChild(div);   
         
         
         div.appendChild(file);
         div.appendChild(btn);
      }
   }
   function styleContents() {
      const text = document.querySelector('#textarea');
      const value = text.value;
      document.getElementById('style_contents').value = value.replace(/(?:\r\n|\r|\n)/g, '<br>');

      document.getElementById('f').submit();
   }
    function search(event){
         if(event.keyCode == 13){
            var searchString = document.getElementById('search').value;
            location.href('shop.user?searchString='+encodeURI(searchString))
         } 
         return
      }
function addTag(num,prodImg,subject){
    var isCheck = document.getElementById('prodTag'+num);
   if(isCheck){
      alert("이미등록된 태그입니다.")
      return
   }
   var TagCount = document.getElementById('prodTag').childElementCount;
   if(TagCount >= 10){
      alert("상품태그는 10개만 등록 가능합니다.")
      return
   }
   var div = document.createElement('div');
   div.style.marginTop = '3px';
   div.id = 'prodTag' +num;
   document.getElementById('prodTag').appendChild(div);

   var bt = document.createElement('input');
   bt.type = 'button';
   bt.value = 'X';
   bt.className = 'btn btn-outline-dark';
   bt.onclick = function() {
      document.getElementById('prodTag').removeChild(document.getElementById('prodTag' + num));
   } 
   var name = document.createElement('input');
   name.type = 'text';
   name.value = subject;
   name.className = 'form-control';
   name.style.display='inline';
   name.style.width='40%';
   name.disabled=true;
   var img = document.createElement('img');
   img.setAttribute("id",'img'+num);
   img.setAttribute("src", prodImg);
   img.setAttribute("width", "50");
   img.setAttribute("height", "50");
   var prod_num = document.createElement('input');
   prod_num.type = 'hidden';
   prod_num.value = num;
   prod_num.name = 'prod_num';
   document.getElementById('prodTag'+num).appendChild(img);
   document.getElementById('prodTag'+num).appendChild(name);
   document.getElementById('prodTag'+num).appendChild(bt);      
   document.getElementById('prodTag'+num).appendChild(prod_num);   
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
   
            url : './searchTagList.user', 
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
               bt.className = 'btn btn-outline-dark'
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
                  var img = '<img src="'+obj.prod_img1+'" width="50",height="50">'
                  var str = '<a href="javascript:addTag('+"'"+obj.prod_num+"',"+"'"+obj.prod_img1+"',"+"'"+obj.subject+"'"+')">'+img+prod_subject+'</a>'
                  $('#searchResult').append(str);
                  if (count == co)
                  break
               }
            },
         });
      }

        
        
      function check() {
         if(document.getElementById("file_img0").value == ''){
            alert("이미지를 삽입해 주세요.")
            return
         }
         styleContents();
      }
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <div align="center" class="basicFont">
      <form id="f" action="styleWrite.user" method="post"
         enctype="multipart/form-data" >
         <table class = "table" style = "width:70%;">

            <tr align = "center">
               <th>게시글 이미지</th>
            </tr>
            <tr align = "center">
               <td>
                  <div id="attachFileDiv">
                     <div id="file0">
                        <input type="file" id="file_img0" name="file_img0" value=""
                           size="20" onchange="javascript:attachFile.add(0)">
                     </div>
                  </div>
               </td>
            </tr>
            <tr align = "center">
               <td><textarea style = "width:60%;display:inline;" class = "form-control" id="textarea" rows="10" cols="40"
                     placeholder="#아이템과 #스타일을 자랑해보세요"></textarea> <input type="hidden"
                  id="style_contents" name="style_contents"></td>
            </tr>
            <tr align = "center">
               <th>상품태그</th>
            </tr>
            <tr align = "center">
               <td>
                  <div id="prodTag"></div>
               </td>
            </tr>
            <tr align ="center">
               <td><input type="text" id="search" class = "form-control" style = "width:40%;display:inline;"
                  oninput="searchList('${upPath}','5')" onkeypress="search(event)"
                  placeholder="브랜드,모델명,모델번호 등" size="20">
                  <div id="searchResult"></div>
                  <div id="moreShow"></div></td>
                  
            </tr>
            <tr align = "center">
               <td style="text-align:center;"><input style=" width: 100px;" type="button" onclick="check()" value="등록" class="btn btn-outline-dark">
               </td>
            </tr>
         </table>
      </form>
   </div>
</body>
</html>
<%@include file="bottom.jsp"%>