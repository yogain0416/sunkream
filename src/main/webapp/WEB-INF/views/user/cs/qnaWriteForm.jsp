<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>QnAWriteForm</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
</head>
<body>
<script>
	function checkInput(){
		if(document.qna.qna_subject.value==""){
			alert("QnA_subject를 입력해주세요")
			document.qna.qna_subject.focus();
			return false
		}
		if(document.qna.qna_contents.value==""){
			alert("QnA_contents를 입력해주세요")
			document.qna.qna_contents.focus();
			return false
		}
		return true
	}
	attachFile = {
			add : function(asd) { // 파일필드 추가
				var idx = asd;
				alert("첫 시작 idx="+idx)
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
						alert('이미지Element생성'+idx)
						img.setAttribute("id",'img'+idx);
						img.setAttribute("src", document.getElementById('file_img'+idx).value);
						img.setAttribute("width", "50");
						img.setAttribute("height", "50");	
						document.getElementById('file'+idx).appendChild(img);
						alert(document.getElementById('file_img'+idx).value) //이미지 주소
					}	
				}
				alert("check값:"+check)
				if(idx != 0){
					if(check == 2){
						var img = document.createElement('img');
						alert('이미지Element생성'+idx)
						img.setAttribute("id",'img'+idx);
						img.setAttribute("src", document.getElementById('file_img'+idx).value);
						img.setAttribute("width", "50");
						img.setAttribute("height", "50");	
						document.getElementById('file'+idx).appendChild(img);
						alert(document.getElementById('file_img'+idx).value) //이미지 주소	
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
					alert("파일은 총 5개만 등록 가능합니다.")
					return
				}
				document.getElementById('attachFileDiv').appendChild(div);	
				
				alert("attachFileDiv 자식 갯수 :"+ fileCount)
				div.appendChild(file);
				div.appendChild(btn);
			},
			del : function(idx) { // 파일필드 삭제
				alert("del안에들어옴! idx="+idx)
				var fileCount = document.getElementById('attachFileDiv').childElementCount;
				if(fileCount == 5 && document.getElementById('file_img4').value != ''){
					document.getElementById('attachFileDiv').removeChild(document.getElementById('file' + idx));
					attachFile.delAdd(idx); 
					alert("해치웠나?")
					return
				}
				document.getElementById('attachFileDiv').removeChild(document.getElementById('file' + idx));
				alert("삭제후 파일 갯수"+document.getElementById('attachFileDiv').childElementCount)
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
				
				alert("attachFileDiv 자식 갯수 :"+ fileCount)
				div.appendChild(file);
				div.appendChild(btn);
			}
			
			
		}
	function onSubmit(){
		document.qna.submit();
	}
	function reset(){
		document.qna.reset();
	}
</script>
<div class="div3" id = "basicFont">
   <div align="center">
      <form name="qna" method="post" action="qnaWriteForm.user" onsubmit="return checkInput()"
      enctype="multipart/form-data">
      <input type="hidden" name = "user_num" value="${sessionUser_num}">
      <input type="hidden" name="qna_step" value="0">
      <input type="hidden" id="qna_cate" name="qna_cate" value="1:1문의">
      <table class = "table" style="width:70%;">
      <thead>
      <tr align = "center">
      <td colspan = "2"><h3>게시글 작성</h3>
      </td>
      </tr>
      </thead>
         <tr align = "center">
	            <th>카테고리</th>
	            <c:if test="${empty subCateList}">
         		<th>
         		1:1문의[신고]
         		<input type="hidden" value="신고" name="qna_subCate">
         		</th>
         		</c:if>
	            <c:if test="${not empty subCateList}">
	            <th>
	            1:1문의
	            <select id="qna_subCate" name="qna_subCate">
	            	<c:forEach var="subCate" items="${subCateList}">
	            		<c:if test="${subCate != '신고'}">
	            		<option value="${subCate}">${subCate}</option>
	            		</c:if>
	            	</c:forEach>
	            </select>
	            </th>
            </c:if>
         </tr>
         <tr align = "center">
            <th>제목</th>
            <td><input type="text" class = "form-control" style="width:40%;" name="qna_subject"></td>
         </tr>
         <tr>
         <tr align = "center">
         	<th>문의 이미지</th>
         	<td>
         		<div id="attachFileDiv">
         			<div id="file0">
						<input type="file" id="file_img0"name="file_img0" value="" size="20"
							onchange="javascript:attachFile.add(0)" >
					</div>		
				</div>
			</td>
         </tr><tr align = "center">
            <th>내용</th>
            <td><textarea class = "form-control" style = "width:60%;" name="qna_contents" cols="20" rows="15"></textarea>
            </td>
         </tr>
         <c:if test="${not empty report_num}">
		 <tr align = "center">
				<th>피신고인</th>
				<td>
				${report_name}
				<input type="hidden" value="${report_num}" name="report_num">
				</td>
		 </tr>
		 </c:if>
		 <c:if test="${empty report_num}">
		 	<input type="hidden" value="0" name="report_num">
		 </c:if>
      </table>
      <i onclick = "onSubmit()" class="bi bi-pencil-square" style = "cursor:pointer;">등록</i>
      &nbsp;
      <i onclick= "reset()" style = "cursor:pointer;" class="bi bi-x-circle">다시작성</i>
      &nbsp;
      <i class="bi bi-backspace"  style = "cursor:pointer;" onclick="javascript:window.history.back()">뒤로가기</i>
      </form>
   </div>
   </div>
   </div>
</body>
</html>
<%@include file="../../bottom.jsp" %>