<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>   
<%@include file="top.jsp"%>
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
a:hover .blueHover {
	color:red;
}
</style>
<meta charset="UTF-8">
<script type="text/javascript">
   function followList(userNum, mode) {
      window.open("followList.user?userNum=" + userNum + "&mode=" + mode, "",
    		  "width=640, height=400,scrollbars=yes, resizable=no,left=pixels")
   }
   function banList(userNum) {
	      window.open("banList.user?userNum=" + userNum , "",
	    		  "width=640, height=400,scrollbars=yes, resizable=no,left=pixels")
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
      window.open("reportOpen.user?report_num="+report_num+"&checkBan="+checkBan,"reportMem"
    		  ,"width=100,height=200,scrollbars=yes, resizable=no, left=pixels");
   }
   
</script>
</head>
<body>
   <div align="center" class="basicFont">
	<div class="row">
		<div class="col">
			<img src="${upPath}/${memberDTO.profile_img}" height="100" width="100"
			class="rounded-circle"
				onerror="this.src='https://blog.kakaocdn.net/dn/c3vWTf/btqUuNfnDsf/VQMbJlQW4ywjeI8cUE91OK/img.jpg'">
		</div>
	</div>
    <div class="row">
		<div class="col">  
      <h2>${memberDTO.profile_name}</h2>
      </div>
    </div>
    <div class="row">
		<div class="col">  
       ${memberDTO.name}
      </div>
    </div>
    <div class="row">
		<div class="col">  
      <h6>${memberDTO.info}</h6>
      </div>
    </div> 
    <div class="row">
    	<div class="col">
    		<c:if test="${empty sessionUser_num}">
         <a href="main.login"> 팔로우</a>
      </c:if>
      <c:if test="${not empty sessionUser_num}">
         <!--int 1이면 팔로우 2면 팔로우취소 3이면 맞팔 -->
         <c:if test="${checkFollowing==1}">
            <input type="button" id="follow" name="follow" value="팔로우 "
               onclick="addFollow('${memberDTO.user_num}')" 
               class="btn btn-outline-dark"/>
         </c:if>
         <c:if test="${checkFollowing==2}">
            <input type="button" id="follow" name="follow" value="팔로우취소 "
               onclick="removeFollow('${memberDTO.user_num}')" 
                class="btn btn-outline-dark"/>
         </c:if>
         <c:if test="${checkFollowing==3}">
            <input type="button" id="follow" name="follow" value="맞팔로우 "
               onclick="addFollow('${memberDTO.user_num}')"
                class="btn btn-outline-dark" />
         </c:if>
         <c:if test="${checkFollowing==4}">
         <a href="myProfileManage.user?user_num=${sessionUser_num}"><font size="5px" color="blue" class="blueHover">프로필 관리</font></a>
         </c:if>
         &nbsp;&nbsp;&nbsp;
         <c:if test="${checkFollowing==4}">
         <a href="styleWrite.user?user_num=${sessionUser_num}&mode=my"><font size="5px" color="blue" class="blueHover">게시글 등록</font></a>
         </c:if>
         <c:if test="${checkFollowing!=4 }">
         <a href="javascript:reportMem('${memberDTO.user_num}','${checkBan}')">...</a>
         </c:if>
      </c:if>
    	</div>
    </div>
      
      
    <div class="row">
    	<div class="col" id="basicFont">
    		 <table>
         <tr>
            <td><font size="4px">게시물: ${boardSu} 개 &nbsp;</font></td>
            <td><a href="javascript:followList('${memberDTO.user_num}','follower')"><font size="4px">팔로워:
                  ${followerSu}&nbsp;&nbsp;</font></a></td>
            <td><a href="javascript:followList('${memberDTO.user_num}','following')"><font size="4px">팔로잉:
                  ${followingSu}</font></a></td>
      </table>
    	</div>
    </div>  
     

	
      <table>
         <c:set var="count" value="0" />
         <tr>
            <c:forEach var="dto" items="${list}">

               <td><br> <a
                  href="styleView.user?styleNum=${dto.style_num}&userNum=${dto.user_num}"><img
                     src="${upPath}/${dto.style_img1}" height="150" width="150"></a>
                  <br> <a href="myProfile.user?user_num=${dto.user_num}"> <img
                     src="${upPath}/${memberDTO.profile_img}" height="30" width="30">
                     작성자: ${memberDTO.profile_name}
               </a> <br> <c:if test="${not empty sessionUser_num}">
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

                  <div id="likeSu"></div> <div class="wordtest">${dto.style_contents}</div></td>
               <c:set var="count" value="${count+1}" />
               <c:if test="${count%2==0}">
         </tr>
         <tr>
            </c:if>
            </c:forEach>
      </table>
   </div>
</body>
</html>
<%@include file="bottom.jsp"%>