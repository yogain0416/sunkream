<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@include file="../../top.jsp"%>
<!DOCTYPE html>
<html>
<head>
<style>
.wordtest {
	boarder: 1px solidblack;
	width: 200px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	text-align: left;
	display: -webkit-box;
	-webkit-box-orient: vertical;
	-webkit-line-clamp: 2;
	/* 	    white-space: normal; */
	line-height: 1.2;
	height: 2.4em;
}
</style>
<meta charset="UTF-8">
<script type="text/javascript">
   function followList(userNum, mode) {
      window.open("followList.user?userNum=" + userNum + "&mode=" + mode, "",
            "width=640, height=400,scrollbars=yes, resizable=no, left=pixels")
   }
   function banList(userNum) {
	      window.open("banList.user?userNum=" + userNum , "",
	            "width=640, height=400,scrollbars=yes, resizable=no, left=pixels")
	   }
   function addLike(styleNum) {
      $.ajax({
         url : './likeStyle.user', //Controller에서 요청 받을 주소
         type : 'post', //POST 방식으로 전달
         data : {
            styleNum : styleNum
         },
         cache : false,
         success : function(likeSu) {//컨트롤러에서 넘어온 cnt값을 받는다  
            document.getElementById(styleNum).value = likeSu;
            document.getElementById('like'+styleNum).className = "bi bi-heart-fill";
            document.getElementById('like'+styleNum).onclick = function() {
               removeLike(styleNum);
            }
         }
      });

   };
   
   function removeLike(styleNum) {
      $.ajax({
         url : './removeLikeStyle.user', //Controller에서 요청 받을 주소
         type : 'post', //POST 방식으로 전달
         data : {
            styleNum : styleNum
         },
         cache : false,
         success : function(likeSu) {//컨트롤러에서 넘어온 cnt값을 받는다  
            document.getElementById(styleNum).value = likeSu;
            document.getElementById('like'+styleNum).className = "bi bi-heart";
            document.getElementById('like'+styleNum).onclick = function() {
               addLike(styleNum);
            }
         }
      });

   };
   function removeFollow(userNum) {
      $.ajax({
         url : './removeFollow.user', //Controller에서 요청 받을 주소
         type : 'post', //POST 방식으로 전달
         data : {
            userNum : userNum
         },
         cache : false,
         success : function(map) {//컨트롤러에서 넘어온 cnt값을 받는다  
            document.getElementById('followerSu').value = map.followerSu;
            if (map.checkFollowing == 3) {
               document.getElementById('follow').value = "맞팔로우";
            } else {
               document.getElementById('follow').value = "팔로우";
            }
            document.getElementById('follow').onclick = function() {
               addFollow(userNum);
            }
         }
      });

   };
   function addFollow(userNum) {
      $.ajax({
         url : './addFollow.user', //Controller에서 요청 받을 주소
         type : 'post', //POST 방식으로 전달
         data : {
            userNum : userNum
         },
         cache : false,
         success : function(followerSu) {//컨트롤러에서 넘어온 cnt값을 받는다  
            alert("팔로우 성공")
            document.getElementById('followerSu').value = followerSu;
            document.getElementById('follow').value = "팔로우취소";
            document.getElementById('follow').onclick = function() {
               removeFollow(userNum);
            }
         }
      });

   };
   
   function reportMem(report_num,checkBan){
      window.open("reportOpen.user?report_num="+report_num+"&checkBan="+checkBan,"reportMem","width=100,height=200 ,resizable=no,left=pixels");
   }
   
   	var isStart = true;
	var isEnd = false; 
	var count = 16;
	window.onscroll = function(e) {
		var boxHeight = document.getElementById('styleBoard').clientHeight;
		var user_num = document.getElementById('profileUser_num').value;
		var listSize = Number(document.getElementById('listSize').value);
		if(listSize <= 8){
			isEnd = true;
		}
		if(window.pageYOffset >= boxHeight/3 && !isEnd && isStart) { 
			var div = document.getElementById('styleBoard');
		  	isStart = false;
		  	$.ajax({
		  		url : './myProfileScroll.user',
		  		type : 'post',
		  		data : {
		  			user_num : user_num,
		  			count : count
		  		},
		  		cache : false,
		  		success : function(res) {
			  		while (div.firstChild) {
			  	    	div.removeChild(div.firstChild);
			  		}
			  		var html = jQuery('<div>').html(res);
			  		var contents = html.find("div#styleBoard").html();
			  		$("#styleBoard").html(contents);
			  		if(listSize <= count){
			  			isEnd = true;
			  		}else{
			  			isEnd = false;
			  			count += 8;
			  		}
			  		window.scrollBy(0, -100);
			  		isStart = true;
		  		},
		 	});
		}
	} 
   
   
   
</script>
</head>
<body>

<input type="hidden" value="${memberDTO.user_num}" id="profileUser_num">
<input type="hidden" value="${boardSu}" id="listSize">

   <div align="center" class="basicFont">
      <img src="${upPath}/${memberDTO.profile_img}" height="100" width="100"
      	class="rounded-circle"
		onerror="this.src='https://blog.kakaocdn.net/dn/c3vWTf/btqUuNfnDsf/VQMbJlQW4ywjeI8cUE91OK/img.jpg'">
      <br>
      <h2>${memberDTO.profile_name}</h2>
      <br>
      ${memberDTO.name}
      <br>
      <h6>${memberDTO.info}</h6>
      <br>
      <c:if test="${empty sessionUser_num}">
       	<input type="button" value="팔로우 " class="btn btn-outline-dark"
               onclick="location.href='main.login'"/>
      </c:if>
      <c:if test="${not empty sessionUser_num}">
         <!--int 1이면 팔로우 2면 팔로우취소 3이면 맞팔 -->
         <c:if test="${checkFollowing==1}">
            <input type="button" id="follow" name="follow" value="팔로우 " 
              class="btn btn-outline-dark" onclick="addFollow('${memberDTO.user_num}')" />
         </c:if>
         <c:if test="${checkFollowing==2}">
            <input type="button" id="follow" name="follow" value="팔로우취소 "
              class="btn btn-outline-dark" onclick="removeFollow('${memberDTO.user_num}')" />
         </c:if>
         <c:if test="${checkFollowing==3}">
            <input type="button" id="follow" name="follow" value="맞팔로우 "
             class="btn btn-outline-dark"  onclick="addFollow('${memberDTO.user_num}')" />
         </c:if>
         <c:if test="${checkFollowing==4}">
       <a href="javascript:banList('${memberDTO.user_num}')"><font color="green">차단한 계정 목록</font></a>
         </c:if>
         <c:if test="${checkFollowing!=4 }">
          <input type="button" value="... "
              class="btn btn-outline-dark" onclick="reportMem('${memberDTO.user_num}','${checkBan}')" />
         </c:if>
      </c:if>
      <table>
         <tr>
            <td>게시물:${boardSu}개</td>
            <td><a href="javascript:followList('${memberDTO.user_num}','follower')">
            	<font color="blue">팔로워</font>:
                  <input type="text" id="followerSu" value="${followerSu}" size="1"
                  style="border: 0 solid black" readOnly />
            </a></td>
            <td><a href="javascript:followList('${memberDTO.user_num}','following')">
            	<font color="blue">팔로잉</font>:
                  </a>${followingSu}</td>
      </table>

<div id="styleBoard" class="basicFont">
	<c:if test="${empty list}">
		<h3>게시글이 없습니다.</h3>
	</c:if>
	<c:if test="${not empty list}">
	      <table>
	         <c:set var="colCount" value="0"/>
	         <c:set var="co" value="0"/>
	         <tr>
	            <c:forEach var="dto" items="${list}">
	            	<c:if test="${co < 8}">
	               <td><br> <a href="styleView.user?styleNum=${dto.style_num}&userNum=${dto.user_num}">
	               <img src="${upPath}/${dto.style_img1}" height="150" width="150"></a>
	                  <br> <a href="myProfile.user?user_num=${dto.user_num}"> 
	                  <img src="${upPath}/${memberDTO.profile_img}" height="30" width="30"
	                  	class="rounded-circle"
						onerror="this.src='https://blog.kakaocdn.net/dn/c3vWTf/btqUuNfnDsf/VQMbJlQW4ywjeI8cUE91OK/img.jpg'">
	                     	작성자: ${memberDTO.profile_name}</a>
	                <br> <c:if test="${not empty sessionUser_num}">
	                     <c:if test="${dto.checkLike==2}">
	                       <i onclick = "addLike('${dto.style_num }')" style = "color:red; cursor:pointer" id = "like${dto.style_num }" class="bi bi-heart"></i>
	                     </c:if>
	                     <c:if test="${dto.checkLike==1}">
	                       <i onclick = "javascript:removeLike('${dto.style_num }')" style= "color:Red; cursor : pointer;" id = "like${dto.style_num }" class="bi bi-heart-fill"></i>
	                     </c:if>
	                  </c:if> <c:if test="${empty sessionUser_num}">
	                     <i onclick = "location.href = 'main.login'" style = "color:red;cursor:pointer;" class="bi bi-balloon-heart"></i>
	                  </c:if> :<input type="text" id="${dto.style_num}"
	                  value="${dto.style_like}" size="1" style="border: 0 solid black"
	                  readOnly />
	
	                  <div id="likeSu"></div><div class="wordtest">${dto.style_contents}</div></td>
	               	<c:set var="colCount" value="${colCount+1}" />
	               	 <c:set var="co" value="${co+1}"/>
	               	<c:if test="${colCount%4==0}">
	         			</tr>
	         			<tr>
	           		</c:if>
	           		</c:if>
	            </c:forEach>
	      </table>
	</c:if>
</div>


</div>
</body>
</html>
<%@include file="../../bottom.jsp"%>