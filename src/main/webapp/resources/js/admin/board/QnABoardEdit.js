		function cateSelect() {
			$("#qna_subCate > option").remove();
			var qna_cate = $('#qna_cate option:selected').val();
			$.ajax({
				url : './getQnaSubCate.admin',
				type : 'post',
				data : {
					qna_cate : qna_cate
				},
				cache : false,
				success : function(list) {
					if (qna_cate == "---선택---") {
						$("#qna_subCate").hide();
					} else {
						$("#qna_subCate").show();
						$('qna_subCate').children('option:not(:first)')
								.remove();
						var laborOption = "";
						for ( var i in list) {
							var obj = list[i];
							var qna_subCate = obj.qna_subCate;
							if (qna_subCate == '신고')
								continue;
							laborOption = "<option value ='"+qna_subCate+"'>"
									+ qna_subCate + "</option>";
							$("#qna_subCate").append(laborOption);
						}
					}
				},
				error : function() {
					alert("에러");
				}
			});
		};

		function checkInput() {
			if (document.qna.qna_cate.value == "---선택---") {
				alert("QnA_Cate를 선택해주세요")
				return false
			}
			if (document.qna.qna_subject.value == "") {
				alert("QnA_subject를 입력해주세요")
				document.qna.qna_subject.focus();
				return false
			}
			if (document.qna.qna_contents.value == "") {
				alert("QnA_contents를 입력해주세요")
				document.qna.qna_contents.focus();
				return false
			}
			var countImg = document.getElementById('file-list').childElemntCount;
			var countFile = document.getElementById('attachFileDiv').childElemntCount;
			if((countImg+countFile) > 5){
				alert("이미지는 5개만 올릴수 있습니다.")
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
					var imgCount = document.getElementById('file-list').childElementCount;
					var fileCount = document.getElementById('attachFileDiv').childElementCount;
					
					document.getElementById('attachFileDiv').appendChild(div);	
					
					div.appendChild(file);
					div.appendChild(btn);
					if((fileCount+imgCount) == 5){
						alert("파일은 총 5개만 등록 가능합니다.")
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
						alert("파일은 총 5개만 등록 가능합니다.")
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