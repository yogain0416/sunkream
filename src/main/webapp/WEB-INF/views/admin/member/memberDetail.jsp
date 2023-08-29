<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../admin_top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member Detail</title>
</head>
<body>
<script>
function onSubmit(){
   document.memberEdit.submit();
}
function reset(){
   document.memberEdit.reset();
}
</script>
<div class="div3" id = "basicFont">
   <div align="center">
      <form id="memberEdit" name="memberEdit" method="post" action="memberEdit.admin">
      <input type="hidden" name="user_num" value="${getMember.user_num}">
      <table class= "table table-hover" style = "width:70%;">
      <thead>
      <tr align = "center">
      <td colspan = "2"><h5>${getMember.profile_name}님의 개인정보</h5></td>
      </tr>
      </thead>
         <tr align = "center">
            <th>이메일</th>
            <td>${getMember.email}</td>
         </tr>
         <tr align = "center">
            <th>사이즈</th>
            <td>${getMember.user_size}</td>
         </tr>
         <tr align="center">
            <th>프로필이름</th>
            <td>${getMember.profile_name}</td>
         </tr>
         <tr align ="center">
            <th>이름</th>
            <td>${getMember.name}</td>
         </tr>
         <tr align = "center">
            <th>휴대폰번호</th>
            <td>${getMember.phone_num}</td>
         </tr>
         <tr align = "center">
            <th>생년월일</th>
            <td>${getMember.birth}</td>
         </tr>
         <tr align = "center">
            <th>성별</th>
            <td>${getMember.gender}</td>
         </tr>
         <tr align= "center">
            <th>이미지</th>
            <td><img src="${upPath}/${getMember.profile_img}" class="rounded-circle" onerror="this.src='https://blog.kakaocdn.net/dn/c3vWTf/btqUuNfnDsf/VQMbJlQW4ywjeI8cUE91OK/img.jpg'" width="100" height="100"></td>
         </tr>
         <tr align = "center">
            <th>포인트</th>
            <td>${getMember.point}</td>
         </tr>
         <tr align = "center">
            <th>패널티</th>
            <td>
            <input type = "text" value="${getMember.penalty}" class = "form-control" style = "width:30%" name ="penalty"></td>
         </tr>
         <tr align = "center">
            <th>소개</th>
            <td>${getMember.info}</td>
         </tr>
         <tr align = "center">
            <th>페널티 정보</th>
            <td><textarea name="admin_info" class = "form-control" >${getMember.admin_info}</textarea></td>
         </tr>
      </table>
         <c:if test="${getMember.del == 'N'}">
            <i class="bi bi-person-circle" onclick="location.href='myProfile.user?user_num=${getMember.user_num}'" style = "cursor:pointer">프로필</i>
         </c:if>
         &nbsp;
         <i class="bi bi-pencil-square" onclick="onSubmit()" style = "cursor:pointer;">수정</i>
         &nbsp;
         <i class="bi bi-x-circle" onclick = "reset()" style= "cursor:pointer;">다시작성</i>
      </form>
   </div>
   </div>
   </div>
</body>
</html>
<%@include file="../../bottom.jsp" %>