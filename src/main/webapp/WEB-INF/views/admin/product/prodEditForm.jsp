<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@include file="../admin_top.jsp"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<style>
#reportRow {
   display: none;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>prodEditForm</title>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
</head>
<body>
   <script>
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
               var imgCount = document.getElementById('file-list').childElementCount;
               var fileCount = document.getElementById('attachFileDiv').childElementCount;
               
               document.getElementById('attachFileDiv').appendChild(div);   
               
               div.appendChild(file);
               div.appendChild(btn);
               if((fileCount+imgCount) == 5){
                  document.getElementById(file.id).disabled = true;
                  return
               }
            },
            del : function(idx) { // 파일필드 삭제
               var fileCount = document.getElementById('attachFileDiv').childElementCount;
               if(fileCount == 5 && document.getElementById('file_img4').value != ''){
                  document.getElementById('attachFileDiv').removeChild(document.getElementById('file' + idx));
                  attachFile.delAdd(idx); 
                  return
               }
               document.getElementById('attachFileDiv').removeChild(document.getElementById('file' + idx));
               var imgCount = document.getElementById('file-list').childElementCount;
               var fileCount = document.getElementById('attachFileDiv').childElementCount;
               if((imgCount+fileCount) != 6){
                  document.getElementById('attachFileDiv').lastElementChild.firstElementChild.disabled = false;
                  return
               }
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
                  return
               }
               document.getElementById('attachFileDiv').appendChild(div);   
               
               div.appendChild(file);
               div.appendChild(btn);
            }
            
            
         }
      $(document).ready(function() {
           $("a[name='file-delete']").on("click", function(e) {
               e.preventDefault();
               deleteFile($(this));
           });
           var imgCount = document.getElementById('file-list').childElementCount;
         var fileCount = document.getElementById('attachFileDiv').childElementCount;
         var lastFile = document.getElementById('attachFileDiv').lastElementChild.id;
         if((imgCount+fileCount) == 6){
            document.getElementById(lastFile).firstElementChild.disabled = true;
            return
         }else{
            document.getElementById(lastFile).firstElementChild.disabled = false;
            return
         }
       })
       function deleteFile(obj) {
           obj.parent().remove();
           this.fileDisabled();
       }
      function fileDisabled(){
         var imgCount = document.getElementById('file-list').childElementCount;
         var fileCount = document.getElementById('attachFileDiv').childElementCount;
         var lastFile = document.getElementById('attachFileDiv').lastElementChild.id;
         if((imgCount+fileCount) == 6){
            document.getElementById(lastFile).firstElementChild.disabled = true;
            return
         }else{
            document.getElementById(lastFile).firstElementChild.disabled = false;
            return
         }
      }
      function cateSelect(value) {
         if(value == 'cate_kr_brand'){
            $("#cate_kr_type > option").remove();
            $("#cate_type").val('');
            $("#cate_subType").val('');
            $("#cate_kr_subType > option").remove();
            $("#cate_kr_type").append("<option value ='===선택==='>===선택===</option>");
            $("#cate_kr_subType").append("<option value ='===선택==='>===선택===</option>");
         }
         if(value == 'cate_kr_type'){
            $("#cate_subType").val('');
            $("#cate_kr_subType > option").remove();
            $("#cate_kr_subType").append("<option value ='===선택==='>===선택===</option>");
         }
         var cate_code = null;
         var id = '';
         var input_id ='';
         var sub_kr_id = '';
         var sub_id = '';
         var val = '';
         if (value == 'cate_kr_brand') {
            cate_code = document.getElementById('cate_kr_brand').value;
            val = document.getElementById('cate_kr_brand').value;
            id = 'cateKrBrand';
            input_id='cate_brand';
            sub_kr_id = 'cate_kr_type';
            sub_id = 'cate_type';
         }
         ;
         if (value == 'cate_kr_type') {
            cate_code = document.getElementById('cate_kr_type').value;
            val = document.getElementById('cate_kr_brand').value;
            id = 'cateKrType';
            input_id='cate_type';
            sub_kr_id = 'cate_kr_subType';
            sub_id = 'cate_subType';
         }
         ;
         if (value == 'cate_kr_subType') {
            cate_code = document.getElementById('cate_kr_subType').value;
            val = document.getElementById('cate_kr_brand').value;
            id = 'cateKrSubType';
            input_id='cate_subType';
            sub_kr_id = 'cate_kr_subType';
            sub_id = 'cate_subType';
         }
         ;
         var div = document.getElementById(id);
         
         $.ajax({
            url : './cate.admin',
            type : 'post',
            data : {
               str : value,
               cate_code : cate_code,
               cate_kr_brand : val
            },
            
            cache : false,
            success : function(cateList) {
               if (div.childElementCount != 1) {
                  if(value == "cate_kr_brand"){
                     document.getElementById(input_id).value = cateList[0].cate_brand;
                     for(var i in cateList ){
                        $("#cate_kr_type").append("<option value ="+cateList[i].cate_kr_type+">"+cateList[i].cate_kr_type+ "</option>");
                     }
                  }
                  if(value == "cate_kr_type"){
                     document.getElementById(input_id).value = cateList[0].cate_type;
                     for(var i in cateList ){
                        $("#cate_kr_subType").append("<option value ="+cateList[i].cate_kr_subType+">"+cateList[i].cate_kr_subType+ "</option>");
                     }
                  }
                  if(value == "cate_kr_subType"){
                     document.getElementById(input_id).value = cateList[0].cate_subType;
                  }
               } else {
                  var input = document.createElement('input');
                  input.type = 'text';
                  input.name = input_id;
                  if(value == "cate_kr_brand"){
                     input.value = cateList[0].cate_brand;
                  }
                  if(value == "cate_kr_type"){
                     input.value = cateList[0].cate_type;
                  }
                  if(value == "cate_kr_subType"){
                     input.value = cateList[0].cate_subType;
                  }
                  input.id = input_id;
                  document.getElementById(id).appendChild(input);
               } 
            },
            error : function() {
            }
         });
      };
      function check(mode) {
         var imgChild = document.getElementById("file-list").childElementCount;
         var fileChild = document.getElementById("attachFileDiv").childElementCount;
         var allChild =(imgChild+fileChild);
         if(document.getElementById("prod_kr_name").value==''||document.getElementById("prod_kr_name")==null){
            alert('상품명을 입력해 주세요.')
            document.getElementById("prod_kr_name").focus()
            return
         }   
         if(document.getElementById("prod_name").value==''||document.getElementById("prod_name")==null){
            alert('상품명을 입력해 주세요.')
            document.getElementById("prod_name").focus()
            return
         }
         if(document.getElementById("prod_kr_color").value==''||document.getElementById("prod_kr_color")==null){
            alert('상품색상을 입력해 주세요.')
            document.getElementById("prod_kr_color").focus()
            return
         }
         if(document.getElementById("prod_color").value==''||document.getElementById("prod_color")==null){
            alert('상품색상을 입력해 주세요.')
            document.getElementById("prod_color").focus()
            return
         }
         if(document.getElementById("prod_price").value==''||document.getElementById("prod_price")==null){
            alert('상품가격을 입력해 주세요.')
            document.getElementById("prod_kr_name").focus()
            return
         }
         
         if(document.getElementById("cate_kr_brand").value == '선택'){
            alert("브랜드명을 선택해 주세요.")
            return
         }
         if(document.getElementById("cate_kr_type").value == '선택'){
            alert("대분류카테고리를 지정해 주세요.")
            return
         }
         if(document.getElementById("cate_kr_subType").value == '선택'){
            alert("소분류 카테고리를 지정해 주세요.")
            return
         }
         if(allChild == 1){
            alert("이미지를 삽입해 주세요. 현재 이미지 수 "+allChild)
            return
         }
            document.prodEdit.submit()
      }
      function is_del(prod_num){
         question = confirm("삭제하시겠습니까 ?")
         if(question == true){
            location.href = "prodDelete.admin?prod_num="+prod_num;
         }
         else {
            return false;
         }
      }
      function utf(id){
          var regexp = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
             var value = $("#"+id).val();
             if (regexp.test(value)) {
                 $("#"+id).val(value.replace(regexp, ''));
             }
      }
   </script>
   <div class="div3" align="left" id = "basicFont">
      <div align="center">
            <form name="prodEdit" method="post" action="prodEdit.admin"
               enctype="multipart/form-data">
         <input type="hidden" name="prod_num" value="${dto.prod_num}">
         <!-- <input type="hidden" name = "user_num" value="1"> -->
         <table class = "table" style = "width:70%;">
            <tr align="center">
               <th>브랜드</th>
               <td><c:if test="${dto.del eq 'N' }">
                     <div id="cateKrBrand">
                        <select name="cate_kr_brand" id="cate_kr_brand"
                           onchange="javascript:cateSelect('cate_kr_brand')">
                           <option value="선택" id="kr_brand" selected>===선택===</option>
                           <c:forEach var="dto" items="${brand_kr_list}">
                              <c:if test="${dto eq cate_kr_brand }">
                                 <option value="${dto}" id="kr_brand" selected>${dto}</option>
                              </c:if>
                              <c:if test="${dto != cate_kr_brand }">
                                 <option value="${dto}" id="kr_brand">${dto}</option>
                              </c:if>
                           </c:forEach>
                        </select> <input type="hidden" name="cate_brand" id="cate_brand"
                           value="${dto.cate_brand }">
                     </div>
                  </c:if> <c:if test="${dto.del eq 'Y' }">${dto.cate_kr_brand }
                     <input type="hidden" name="cate_kr_brand" id="cate_kr_brand"
                        value="${dto.cate_kr_brand }">
                     <input type="hidden" name="cate_brand" id="cate_brand"
                        value="${dto.cate_brand }">
                  </c:if></td>
            </tr>
            <tr align="center">
               <th>대분류</th>
               <td><c:if test="${dto.del eq 'N' }">
                     <div id="cateKrType">
                        <select name="cate_kr_type" id="cate_kr_type"
                           onchange="javascript:cateSelect('cate_kr_type')">
                           <option value="선택" id="kr_type" selected>===선택===</option>
                                 <option value="${dto.cate_kr_type}" id="kr_type" selected>${dto.cate_kr_type}</option>
                        </select> <input type="hidden" name="cate_type" id="cate_type"
                           value="${dto.cate_type }">
                     </div>
                  </c:if> <c:if test="${dto.del eq 'Y' }">${dto.cate_kr_type }
                        <input type="hidden" name="cate_kr_type"
                        value="${dto.cate_kr_type }" readOnly>
                     <input type="hidden" name="cate_type" id="cate_type"
                        value="${dto.cate_type }">
                  </c:if></td>
            </tr>
            <tr align="center">
               <th>소분류</th>
               <td><c:if test="${dto.del eq 'N' }">
                     <div id="cateKrSubType">
                        <select name="cate_kr_subType" id="cate_kr_subType"
                           onchange="cateSelect('cate_kr_subType')">
                           <option value="선택" id="kr_subType" selected>===선택===</option>
                                 <option value="${dto.cate_kr_subType }" id="kr_subType" selected>${dto.cate_kr_subType }</option>
                        </select> <input type="hidden" name="cate_subType" id="cate_subType"
                           value="${dto.cate_subType }">
                     </div>
                  </c:if> <c:if test="${dto.del eq 'Y' }">
                     ${dto.cate_kr_subType }
                     <input type="hidden" name="cate_subType" id="cate_subType"
                        value="${dto.cate_kr_subType }">
                     <input type="hidden" name="cate_subType" id="cate_subType"
                        value="${dto.cate_subType }">
                  </c:if></td>
            </tr>
            <tr align="center">
               <th>상품명(한글)</th>
               <td><c:if test="${dto.del eq 'N' }">
                     <input type="text" class= "form-control" name="prod_kr_name" id="prod_kr_name"
                        value="${dto.prod_kr_name }" onkeyup = "utf('pord_kr_name')">
                  </c:if> <c:if test="${dto.del eq 'Y' }">
                     ${dto.prod_kr_name }
                     <input type="hidden" name="prod_kr_name" id="prod_kr_name"
                        value="${dto.prod_kr_name }">
                  </c:if></td>
            </tr>
            <tr align="center">
               <th>상품명(영문)</th>
               <td><c:if test="${dto.del eq 'N' }">
                     <input type="text" name="prod_name" id="prod_name" class= "form-control"
                        value="${dto.prod_name }"
                        style="ime-mode: disabled; text-transform: uppercase;">
                  </c:if> <c:if test="${dto.del eq 'Y' }">
                     ${dto.prod_name }
                     <input type="hidden" name="prod_name" id="prod_name"
                        value="${dto.prod_name }"
                        style="ime-mode: disabled; text-transform: uppercase;">
                  </c:if></td>
            </tr>
            <tr align="center">
               <th>색상(한글)</th>
               <td><c:if test="${dto.del eq 'N' }">
                     <input type="text" name="prod_kr_color" id="prod_kr_color" class= "form-control"
                        value="${dto.prod_kr_color }" onkeyup = "utf('prod_kr_color')" style="IME-MODE: active">
                  </c:if> <c:if test="${dto.del eq 'Y' }">
                        ${dto.prod_kr_color }
                        
                        <input type="hidden" name="prod_kr_color" id="prod_kr_color"
                        value="${dto.prod_kr_color }" style="IME-MODE: active">
                  </c:if></td>
            </tr>
            <tr align="center">
               <th>색상(영문)</th>
               <td><c:if test="${dto.del eq 'N' }">
                     <input type="text" name="prod_color" id="prod_color" class= "form-control"
                        value="${dto.prod_color }"
                        style="ime-mode: disabled; text-transform: uppercase;">
                  </c:if> <c:if test="${dto.del eq 'Y' }">
                     ${dto.prod_color }
                     <input type="hidden" name="prod_color" id="prod_color"
                        value="${dto.prod_color }"
                        style="ime-mode: disabled; text-transform: uppercase;">
                  </c:if></td>
            </tr>
            <tr align = "center">
               <th>상품이미지</th>
               <td>

                  <div class="form-group file-group" id="file-list">
                     <c:set var="number" value="1" />
                     <c:forEach items="${imgList}" var="file">
                        <div class="file-input">
                           <!-- <span class="glyphicon glyphicon-camera" aria-hidden="true"></span> -->
                           <c:if test="${file != null }">
                              <img src="${upPath}/${file}" width="50" height="50">
                              <br>
                              ${file} 
                              <c:if test="${dto.del eq 'N' }">
                                 <a href='#this' name='file-delete'>삭제</a>
                              </c:if>
                              <input type="hidden" name="prod_img${number}" value="${file}">
                           </c:if>
                        </div>
                        <c:set var="number" value="${number+1}" />
                     </c:forEach>
                  </div> <c:if test="${dto.del eq 'N' }">
                     <div id="attachFileDiv">
                        <div id="file0">
                           <input type="file" id="file_img0" name="file_img0" value=""
                              size="20" onchange="javascript:attachFile.add(0)">
                        </div>
                     </div>
                  </c:if>
               </td>
            </tr>
            <tr align="center">
               <th>상품가격</th>
               <td><c:if test="${dto.del eq 'N' }">
                     <input type="text" name="prod_price" id="prod_price" class= "form-control"
                        value="${dto.prod_price }"
                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                        <input type ="hidden" value = "${dto.prod_price }" name = "originPrice">
                  </c:if> <c:if test="${dto.del eq 'Y' }">
                     ${dto.prod_price }
                     <input type="hidden" name="prod_price" id="prod_price"
                        value="${dto.prod_price }"
                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                  </c:if></td>
            </tr>
            <tr align="center">
               <th>성별</th>
               <td><c:if test="${dto.del eq 'N' }">
                     <select name="prod_gender" id="prod_gender">
                        <c:forEach var="i" items="${genderList }">
                           <c:if test="${i eq dto.prod_gender }">
                              <option value="${i }" selected>${i }</option>
                           </c:if>
                           <c:if test="${i != dto.prod_gender }">
                              <option value="${i}">${i }</option>
                           </c:if>
                        </c:forEach>
                     </select>
                  </c:if> <c:if test="${dto.del eq 'Y' }">
                  ${dto.prod_gender }
                  <input type="hidden" name="prod_gender"
                        value="${dto.prod_gender }">
                  </c:if></td>
            </tr>
            <c:if test="${dto.del eq 'N' }">
            <tr align = "center">
            <td colspan = "2"><button type="button" id="confirm" class="btn btn-outline-dark"
               onclick="location.href = 'size_qty_edit.admin?prod_num=${dto.prod_num}'" >사이즈별 수량 변경</button>
               </td>
               </tr>
               </c:if>
         </table>
         <c:if test="${dto.del eq 'N' }">
            <i class="bi bi-pencil-square" onclick="check('edit')" style = "cursor:pointer;">수정</i>&nbsp;
            <i style ="cursor:pointer;" onclick="javascript:is_del('${dto.prod_num}')" class="bi bi-trash3">삭제</i>
            <i style = "cursor:pointer;" onclick="location.href = 'prodList.admin'" class="bi bi-card-list">목록으로</i>
         </c:if>
         <c:if test="${dto.del eq 'Y' }">
            <i style="cursor:pointer;" onclick="location.href='prodRegist.admin?prod_num=${dto.prod_num}'" class="bi bi-recycle">재등록</i>
            <i style = "cursor:pointer;" onclick="location.href = 'prodList.admin?del=Y'" class="bi bi-card-list">목록으로</i>
         </c:if>
         &nbsp;
         </form>
      </div>
   </div>
   </div>
</body>
</html>
<%@include file = "../../bottom.jsp" %>