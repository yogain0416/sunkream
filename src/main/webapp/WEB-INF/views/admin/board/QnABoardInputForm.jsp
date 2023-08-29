<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../admin_top.jsp"%>
<!DOCTYPE html>
<html>
<head>
<style>
#qna_subCate {
	display: none;
}

#reportRow {
	display: none;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>QnABoardInputForm</title>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
</head>
<body>
	<script>
	function cateSelect(){
		$("#qna_subCate > option").remove();
		var qna_cate = $('#qna_cate option:selected').val();
		$.ajax({
	        url:'./getQnaSubCate.admin', 
	        type:'post', 
	        data:{qna_cate:qna_cate},
	        cache:false,
	        success:function(list){
	        	if(qna_cate == "---선택---"){
	        		$("#qna_subCate").hide();
	        	}else{
	        		$("#qna_subCate").show();
	        		$('qna_subCate').children('option:not(:first)').remove();
	        		var laborOption = "";
	        		for(var i in list){
	        			var obj = list[i];
	        			var qna_subCate = obj.qna_subCate;
	        			if(qna_subCate == '신고') continue;
	        			laborOption = "<option value ='"+qna_subCate+"'>"+qna_subCate+"</option>";
	        			 $("#qna_subCate").append(laborOption);
	        		}
	        	}
	        },
	        error:function(){
	        	alert("에러");
	        }
	    });
	};
	
	function checkInput(){
		if(document.qna.qna_cate.value=="---선택---"){
			alert("QnA_Cate를 선택해주세요")
			return false
		}
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
					alert("파일은 총 5개만 등록 가능합니다.")
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
				file.style = "width:60%";
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
	function onSubmit(){
		document.qna.submit();
	}
</script>
	<div class="div3" id="basicFont">
		<div align="center">
		<h3>관리자 게시글 작성</h3>
		<br>
		<hr width = "60%">
		
			<form name="qna" method="post" action="QnABoardInput.admin"
				onsubmit="return checkInput()" enctype="multipart/form-data">
				<input type="hidden" name="user_num" value="${admin_num}"> <input
					type="hidden" name="qna_step" value="0">
				<table class="table" style="width:80%">
					<tr align="center">
						<th>카테고리</th>
						<th><select id="qna_cate" name="qna_cate"
							onchange="cateSelect()" class="form-select" aria-label="Default select example" size="1" style="width:30%">
								<option value="---선택---">---선택---</option>
								<c:forEach var="qna_cate" items="${cateList}">
									<c:if test="${qna_cate != '1:1문의'}">
										<option value="${qna_cate}">${qna_cate}</option>
									</c:if>
								</c:forEach>
								<%--                <c:forTokens items="---선택---,공지,FAQ,1:1문의" delims="," var="qna_cate">
                     <option value ="${qna_cate}">${qna_cate}</option>
               </c:forTokens> --%>
						</select><select id="qna_subCate" name="qna_subCate" class="form-select" aria-label="Default select example" size="1" style="width:30%"></select></th>
					</tr>
					<tr align="center">
						<th>제목</th>
						<td><input style = "width:60%;" class="form-control" type="text" name="qna_subject"></td>
					</tr>
					<tr align = "center">
						<th>문의 이미지</th>
						<td>
							<div id="attachFileDiv">
								<div id="file0">
									<input style="width:60%" type="file" id="file_img0" name="file_img0" value=""
										size="20" onchange="javascript:attachFile.add(0)">
								</div>
							</div>
						</td>
					</tr>
					<tr align = "center">
					<th>내용</th>
					<td ><textarea name="qna_contents" class="form-control" style= "width:60%" cols="30" rows="15"></textarea>
					</td>
					</tr>
					<tr id="reportRow" align="center">
						<th>피신고인</th>
						<td>
							<!-- <input type="hidden" value="2" name="report_num"> -->
						</td>
					</tr>
				</table>
				<br>
				<hr width = "60%">
				<a href="javascript:onSubmit()">등록<svg xmlns="http://www.w3.org/2000/svg"
						width="22" height="22" fill="currentColor"
						class="bi bi-pencil-square" viewBox="0 0 16 16">
  <path
							d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
  <path fill-rule="evenodd"
							d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z" />
</svg></a>&nbsp;
					<svg style = "cursor:pointer;" onclick="location.href='QnABoardInput.admin'" xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" class="bi bi-x-circle" viewBox="0 0 16 16">
  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
  <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
</svg>
			</form>
		</div>
	</div>
	</div>
</body>
</html>
<%@include file="../../bottom.jsp"%>