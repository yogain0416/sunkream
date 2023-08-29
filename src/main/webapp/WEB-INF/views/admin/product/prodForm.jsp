<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../admin_top.jsp"%>
<link rel="stylesheet" href="resources/css/slide.css" type="text/css">
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
					document.getElementById('img0').src = document.getElementById('prod_img0').value;
					return
				}else{
					var img = document.createElement('img');
					img.setAttribute("id",'img'+idx);
					img.setAttribute("src", document.getElementById('prod_img'+idx).value);
					img.setAttribute("width", "50");
					img.setAttribute("height", "50");	
					document.getElementById('file'+idx).appendChild(img);
				}	
			}
			if(idx != 0){
				if(check == 2){
					var img = document.createElement('img');
					img.setAttribute("id",'img'+idx);
					img.setAttribute("src", document.getElementById('prod_img'+idx).value);
					img.setAttribute("width", "50");
					img.setAttribute("height", "50");	
					document.getElementById('file'+idx).appendChild(img);
				}else if(check == 3){
					document.getElementById('img'+idx).src = document.getElementById('prod_img'+idx).value;
					return
				}	
			}
			var file = document.all ? document
					.createElement('<input name="files">') : document
					.createElement('input');
			file.type = 'file';
			file.name = 'prod_img'+(idx+1);
			file.size = '20';
			file.id = 'prod_img' + (idx+1);
			file.onchange = function(){
				attachFile.add((idx+1));
			}
			file.multiple = 'multiple';
			
			var btn = document.createElement('input');
			btn.type = 'button';
			btn.value = '삭제';
			btn.className = 'btn btn-outline-dark';
			btn.onclick = function() {
				var isDel = confirm('삭제 하시겠습니까?')
				if(isDel && document.getElementById('prod_img'+(idx+1)).value != ''){
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
			if(fileCount == 5 && document.getElementById('prod_img4').value != ''){
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
			file.name = 'prod_img'+idx;
			file.size = '20';
			file.id = 'prod_img' + idx;
			file.onchange = function(){
				attachFile.add(idx);
			}
			
			
			var btn = document.createElement('input');
			btn.type = 'button';
			btn.value = '삭제';
			btn.className = 'btn btn-outline-dark';
			btn.onclick = function() {
				var isDel = confirm('삭제 하시겠습니까?')
				if(isDel && document.getElementById('prod_img'+idx).value != ''){
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
			if(value == "cate_kr_brand"){
				for(var i in cateList ){
					$("#cate_kr_type").append("<option value ='"+cateList[i].cate_kr_type+"'>"+cateList[i].cate_kr_type+ "</option>");
				}
				if (div.childElementCount != 1) {
					document.getElementById(input_id).value = cateList[0].cate_brand;
				}
				else{
					var input = document.createElement('input');
					input.type = 'hidden';
					input.name = input_id;
					input.value = cateList[0].cate_brand;
					input.id = input_id;
					document.getElementById(id).appendChild(input);
				}
			}
			if(value == "cate_kr_type"){
				for(var i in cateList ){
					$("#cate_kr_subType").append("<option value ='"+cateList[i].cate_kr_subType+"'>"+cateList[i].cate_kr_subType+"</option>");
				}
				if (div.childElementCount != 1) {
					document.getElementById(input_id).value = cateList[0].cate_type;
				}
				else{
					var input = document.createElement('input');
					input.type = 'hidden';
					input.name = input_id;
					input.id = input_id;
					input.value = cateList[0].cate_type;
					document.getElementById(id).appendChild(input);
				}
				
			}
			if(value == "cate_kr_subType"){
				if (div.childElementCount != 1) {
					document.getElementById(input_id).value = cateList[0].cate_subType;
				}
				else {
					var input = document.createElement('input');
					input.type = 'hidden';
					input.name = input_id;
					input.id = input_id;
					input.value = cateList[0].cate_subType;
					document.getElementById(id).appendChild(input);
				} 
			}
		},
		error : function() {
			alert("에러");
		}
	});
};
	function check() {
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
		if(document.getElementById("prod_img0").value == ''){
			alert("이미지를 삽입해 주세요.")
			return
		}
		document.f.submit()
	}
	function utf(id){
		 var regexp = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
		    var value = $("#"+id).val();
		    if (regexp.test(value)) {
		        $("#"+id).val(value.replace(regexp, ''));
		    }
	}
</script>
<html>
<head>
<style>
input[type=text]{
	width:80%;

}
</style>
<meta charset="UTF-8">
<title>prodInput</title>
</head>
<body>
<div align="center">
		<form name="f" action="prodInput.admin" method="post"
			enctype="multipart/form-data">
			<table class = "table" style = "width:60%;">
			<thead>
			<tr align = "center">
			<td colspan = "2"><h3>상품등록</h3></td>
			</tr>
			</thead>
				<tr align="center">
					<th>브랜드</th>
					<td><div id="cateKrBrand">
							<select name="cate_kr_brand" id="cate_kr_brand"  class="form-select" aria-label="Default select example"
								onchange="javascript:cateSelect('cate_kr_brand')">
								<option value="선택" id="kr_brand" selected>===선택===</option>
								<c:forEach var="dto" items="${brand_kr_list}">
									<option value="${dto}" id="kr_brand">${dto}</option>
								</c:forEach>
							</select>
						</div></td>
				</tr>
				<tr align="center">
					<th>대분류</th>
					<td>
						<div id="cateKrType">
							<select name="cate_kr_type" id="cate_kr_type"
								onchange="javascript:cateSelect('cate_kr_type')">
								<option value="선택" id="kr_type" selected>===선택===</option>
								
							</select>
						</div>
					</td>
				</tr>
				<tr align="center">
					<th>소분류</th>
					<td>
						<div id="cateKrSubType">
							<select name="cate_kr_subType" id="cate_kr_subType"
								onchange="cateSelect('cate_kr_subType')">
								<option value="선택" id="kr_subType" selected>===선택===</option>
							</select>
						</div>
					</td>
				</tr>
				<tr align="center">
					<th>상품명(한글)</th>
					<td><input type="text" class = "form-control" name="prod_kr_name" id="prod_kr_name"
						style='ime-mode: active'
						onkeyup="utf('prod_kr_name')"></td>
				</tr>
				<tr align="center">
					<th>상품명(영문)</th>
					<td><input type="text" name="prod_name" class = "form-control" id="prod_name"
						style="ime-mode: disabled; text-transform: uppercase;"></td>
				</tr>
				<tr align="center">
					<th>색상(한글)</th>
					<td><input type="text" class = "form-control" name="prod_kr_color" id="prod_kr_color" onkeyup="utf('prod_kr_color')"></td>
				</tr>
				<tr align="center">
					<th>색상(영문)</th>
					<td><input type="text" class = "form-control" name="prod_color" id="prod_color"
						style="ime-mode: disabled; text-transform: uppercase;"></td>
				</tr>
				<tr align="center">
					<th>상품이미지</th>
					<td><div id="attachFileDiv">
							<div id="file0">
								<input type="file"   name="prod_img0" value="" size="20"
									id="prod_img0" onchange="javascript:attachFile.add(0)"
									multiple="multiple">
							</div>
						</div></td>
				</tr>
				<tr align="center">
					<th>상품가격</th>
					<td><input type="text" name="prod_price" id="prod_price" class = "form-control"
						oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"></td>
				</tr>
				<tr align="center">
					<th>성별</th>
					<td><select name="prod_gender" id="prod_gender">
							<option value="M">M</option>
							<option value="F">F</option>
							<option value="All">All</option>
					</select></td>
				</tr>
				<tr align="center">
					<td colspan="2">
					<svg onclick="javascript:check()" style= "cursor:pointer;" xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-check-circle" viewBox="0 0 16 16">
  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
  <path d="M10.97 4.97a.235.235 0 0 0-.02.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-1.071-1.05z"/>
</svg>
				</tr>
			</table>
		</form>
	</div>
</div>
<%@include file="../../bottom.jsp"%>