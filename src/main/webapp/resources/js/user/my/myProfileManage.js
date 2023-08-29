	function banList(userNum) {
		window.open("banList.user?userNum=" + userNum , "",
				"width=640, height=400,scrollbars=yes, resizable=no")
	}
	function imgEdit(upPath){
		var file = document.getElementById('profile_imgEdit');
		file.click();
	 	if(file.value != ""){
	 		var form = file.files[0];
			var formData = new FormData()
			formData.append('img',form);
			$.ajax({
				url : './profile_imgEdit.user',
				type : 'post',
				enctype : 'multipart/form-data',
				data : formData,
		        contentType : false,
		        processData : false,  
				cache : false,
				success : function(profile_img) {
					//보낼때 인코드했으니 받을때 디코드하기
					var profile_img = decodeURIComponent(profile_img)
					//이미지 element 만들기
					var img = document.createElement('img');
					img.setAttribute("src", upPath+'/'+profile_img);
					img.setAttribute("width", "100");
					img.setAttribute("height", "100");
					img.setAttribute("class","rounded-circle");
					img.setAttribute("onerror","this.src='https://blog.kakaocdn.net/dn/c3vWTf/btqUuNfnDsf/VQMbJlQW4ywjeI8cUE91OK/img.jpg'");
					//div에 있는 원래 img 삭제하기
					var div = document.getElementById('profile_img');
					div.removeChild(div.firstElementChild);
					//edit된 img 추가해주기
					div.appendChild(img)
				}
			});
		} 
	}	
					
	function imgDel(upPath){
		var file = document.getElementById('profile_imgEdit');
		file.value="";
		var form = file.files[0];
		var formData = new FormData()
		formData.append('img',form);
		$.ajax({
			url : './profile_imgEdit.user',
			type : 'post',
			enctype : 'multipart/form-data',
			data : formData,
	        contentType : false,
	        processData : false,  
			cache : false,
			success : function(profile_img) {
				//이미지 element 만들기
				var img = document.createElement('img');
				img.setAttribute("src", upPath+'/'+profile_img);
				img.setAttribute("width", "100");
				img.setAttribute("height", "100");
				img.setAttribute("class","rounded-circle");
				img.setAttribute("onerror","this.src='https://blog.kakaocdn.net/dn/c3vWTf/btqUuNfnDsf/VQMbJlQW4ywjeI8cUE91OK/img.jpg'");
				//div에 있는 원래 img 삭제하기
				var div = document.getElementById('profile_img');
				div.removeChild(div.firstElementChild);
				//edit된 img 추가해주기
				div.appendChild(img)
			}
		});
	}

	
	function checkProfileName(e){
		e.value = e.value.replace(/[^a-zA-Z0-9_]/gi, '')
		var profileName = $('#profile_name').val();
		if(profileName == "" || profileName == null){
			$("#profile_name_save").attr("disabled",true);
			$("#profileName-blank").show();
			return
		}
		$.ajax({
			url:'./checkProfileName',
			type:'post',
			data:{profile_name:profileName},
			cache:false,
			success:function(res){
				if(res == 0){
					$("#profileName-blank").hide();
					$("#profileName-already").hide();
					$("#profile_name_save").attr("disabled",false);
				}else{
					$("#profileName-blank").hide();
					$("#profileName-already").show();
					$("#profile_name_save").attr("disabled",true);
				}
			},
			error:function(){
				alert("에러");
			}
		});
	}
	
	function profile_nameEdit(){
		$("#profile_nameEdit").css("visibility","hidden");
		var div = document.getElementById('profile_nameDiv')
		$("#profile_name").attr("readOnly",false);
		$("#profile_name_hr").css("border","1px solid");
		var original = $("#profile_name").val();
		var save = document.createElement('input');
		save.type = 'button';
		save.id = 'profile_name_save'
		save.value = '저장';
		save.className = 'btn btn-outline-dark';
		save.disabled = true;
		save.onclick= function(){
			var profile_name = document.getElementById('profile_name').value;
 			$.ajax({
				url : './saveProfileName.user',
				type : 'post',
				data : {profile_name:profile_name},
				cache:false,
				success:function(res){
					while(div.hasChildNodes()){
						div.removeChild(div.firstChild);
					}
					$("#profile_nameEdit").css("visibility","visible");
					$("#profile_name_hr").css("border","");
					$("#profileName-already").hide();
					$("#profileName-blank").hide();
					$("#profile_name").attr("readOnly",true);
					document.getElementById('topProfile_name').innerText = profile_name;
				},
			})
		}
		var cancel = document.createElement('input');
		cancel.type = 'button';
		cancel.id = 'profile_name_cancel';
		cancel.className = 'btn btn-outline-dark';
		cancel.value = '취소';
		cancel.onclick=function(){
			$("#profile_name").attr("readOnly",true);
			while(div.hasChildNodes()){
				div.removeChild(div.firstChild);
			}
			document.getElementById('profile_name').value = original;
			$("#profile_nameEdit").css("visibility","visible");
			$("#profile_name_hr").css("border","");
			$("#profileName-already").hide();
			$("#profileName-blank").hide();
			document.getElementById('topProfile_name').innerText = original;
		}
		div.appendChild(save)
		div.appendChild(cancel)
	}
	
	
	//이름 특수문자,띄어쓰기 금지 && 이름입력안될시 저장버튼 비활성화
	function checkName(e){
		var name = $("#name").val();
		if(name == ""){
			$("#name_save").attr("disabled",true);
			$("#name-blank").show();
		}else{
			$("#name_save").attr("disabled",false);
			$("#name-blank").hide();
		}
		e.value = e.value.replace(/[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi, '')
	}
	
	function nameEdit(){
		$("#nameEdit").css("visibility","hidden");
		var div = document.getElementById('nameDiv')
		$("#name").attr("readOnly",false);
		$("#name_hr").css("border","1px solid");
		var original = $("#name").val();
		var save = document.createElement('input');
		save.type = 'button';
		save.id = 'name_save'
		save.value = '저장';
		save.className = 'btn btn-outline-dark';
		save.disabled = false;
		save.onclick= function(){
			var name = document.getElementById('name').value;
 			$.ajax({
				url : './saveName.user',
				type : 'post',
				data : {name:name},
				cache:false,
				success:function(res){
					while(div.hasChildNodes()){
						div.removeChild(div.firstChild);
					}
					$("#nameEdit").css("visibility","visible");
					$("#name_hr").css("border","");
					$("#name-blank").hide();
				},
			})
		}
		var cancel = document.createElement('input');
		cancel.type = 'button';
		cancel.id = 'name_cancel'
		cancel.value = '취소';
		cancel.className = 'btn btn-outline-dark';
		cancel.onclick=function(){
			$("#name").attr("readOnly",true);
			while(div.hasChildNodes()){
				div.removeChild(div.firstChild);
			}
			document.getElementById('name').value = original;
			$("#nameEdit").css("visibility","visible");
			$("#name_hr").css("border","");
			$("#name-blank").hide();
		}
		div.appendChild(save)
		div.appendChild(cancel)
	}
	
	function infoEdit(){
		$("#infoEdit").css("visibility","hidden");
		var div = document.getElementById('infoDiv')
		$("#info").attr("readOnly",false);
		$("#info_hr").css("border","1px solid");
		var original = $("#info").val();
		var save = document.createElement('input');
		save.type = 'button';
		save.id = 'info_save'
		save.value = '저장';
		save.className = 'btn btn-outline-dark';
		save.disabled = false;
		save.onclick= function(){
			var info = document.getElementById('info').value;
			alert(info)
 			$.ajax({
				url : './saveInfo.user',
				type : 'post',
				data : {info:info},
				cache:false,
				success:function(res){
					while(div.hasChildNodes()){
						div.removeChild(div.firstChild);
					}
					$("#infoEdit").css("visibility","visible");
					$("#info_hr").css("border","");
				},
			})
		}
		var cancel = document.createElement('input');
		cancel.type = 'button';
		cancel.id = 'info_cancel'
		cancel.value = '취소';
		cancel.className = 'btn btn-outline-dark';
		cancel.onclick=function(){
			$("#info").attr("readOnly",true);
			while(div.hasChildNodes()){
				div.removeChild(div.firstChild);
			}
			document.getElementById('info').value = original;
			$("#infoEdit").css("visibility","visible");
			$("#info_hr").css("border","");
		}
		div.appendChild(save)
		div.appendChild(cancel)
	}