<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
	function setConfirmSize(i, str,qty) {
		var s = window.opener.document.getElementById('edit' + i);
		var k = Number(document.getElementById('size' + i).value);
		var p = Number(qty);
		alert(p)
		if (!s) {
			if (str == 'change') {
				var add = window.opener.document.createElement('input');
				add.type = 'hidden';
				add.id = 'edit' + i;
				add.name = 'edit' + i;
				add.value = k;
				window.opener.document.getElementById('selectAdd').appendChild(add);
				window.opener.document.getElementById(i).value = i + " : "+add.value;
				window.close();
			}
			if (str == 'append') {
				var add = window.opener.document.createElement('input');
				add.type = 'hidden';
				add.id = 'edit' + i;
				add.name = 'edit' + i;
				add.value = p+k;
				window.opener.document.getElementById('selectAdd').appendChild(
						add);
				window.opener.document.getElementById(i).value = i + " : "
						+ add.value;
				window.close();
			}
		}
		if (s) {
			if(str == 'change'){
				var d = k;
				s.value = d;
				window.opener.document.getElementById(i).value = i + " : " + d;
				window.close();
			}
			if(str == 'append'){
				var d = Number(s.value);
				s.value = d+k;
				window.opener.document.getElementById(i).value = i + " : " + s.value;
				window.close();
			}
			
		}
	}
</script>
<html>
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
   <link rel="stylesheet" href="resources/css/bootstrap.min.css"
   type="text/css">
<head>
<meta charset="UTF-8">
<title>사이즈 수량 수정</title>
</head>
<body>
	<div align="center">
		<font size="6" color="Black">${i } 사이즈 수량 수정</font><br> <input
			type="text" class = "form-control" style = "width:50%;display:inline;" value="${qty }" id="size${i }" size="30"> <br>
			<i class="bi bi-check-lg" onclick="setConfirmSize('${i}','change','${qty }')" style = "cursor:pointer;">수량 변경하기</i>
			&nbsp;&nbsp;
			<i class="bi bi-plus-circle" onclick="setConfirmSize('${i}','append','${qty}')" style = "cursor:pointer">수량추가</i>
			
			 &nbsp;&nbsp;
		<i class="bi bi-x-lg" onclick="window.close()" style = "cursor:pointer;">닫기</i>
	</div>
</body>
</html>