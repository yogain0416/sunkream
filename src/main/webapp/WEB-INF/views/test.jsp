<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>무한스크롤 예제</title>

</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
  <script>
  	function letTest(){
  		var test = '테스트';
  		$.ajax({
  			url : "./test.user",
  			type : "post",
  			dataType : "text",
  			data : {test:test},
  			contentType: false,
  		    processData: false,
  			cache : false,
		    success : function(res){
		    	alert('나옴:'+res)
		    	var html = jQuery('<div>').html(res);
		    	alert(html)
				var contents = html.find("div#testDiv").html();
		    	alert(contents)
				$("#test1").html(contents);
		    },
		    });
  	}
  </script>
<body>       
 <input type="button" value="클릭해봐바" onclick="letTest()">
    <div id="test1"></div>
    <div id="test2"></div>  
  <h1><a href="javascript:letTest()">에이젝스실험</a></h1>
 

</body>
</html>