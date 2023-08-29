<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="zxx">

<head>

<style>
a{
  color : black;
}
a:link {
  color : black;
}
a:visited {
  color : black;
}
a:hover{
	color : red;
}

@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
.shopTop{
	font-family : 'GmarketSansMedium';
}
@font-face {
    font-family: 'Dovemayo_gothic';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.1/Dovemayo_gothic.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
.basicFont{
	font-family: 'Dovemayo_gothic';
}
#basicFont{
	font-family: 'Dovemayo_gothic';
}


</style>

<script>
window.ready(window.setInterval(function(){
	$.ajax({
		url:'./alarmCheck.user',
		cache : false,
		success : function(co){
			if(co>0){
				document.getElementById('alarm_bell').className = 'bi bi-bell-fill';
				document.getElementById('alarm_bell2').className = 'bi bi-bell-fill';
			}
		}
	});
},4000));
function alarmClick(){
	document.getElementById("alarm_bell").className = "bi bi-bell";
	document.getElementById('alarm_bell2').className = 'bi bi-bell';
	window.open('userAlarm.user',' ',"width = 600, height = 600,scrollBars=yes, resizeable = no,left=pixels");
	
}
</script>
<meta charset="UTF-8">
<meta name="description" content="Ashion Template">
<meta name="keywords" content="Ashion, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>EzenKream</title>
<!-- bootstrap icon -->
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<!-- Google Font -->
<link
   href="https://fonts.googleapis.com/css2?family=Cookie&display=swap"
   rel="stylesheet">
<link
   href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&display=swap"
   rel="stylesheet">
<!-- Css Styles -->
<link rel="stylesheet" href="resources/css/bootstrap.min.css"
   type="text/css">
<link rel="stylesheet" href="resources/css/font-awesome.min.css"
   type="text/css">
<link rel="stylesheet" href="resources/css/elegant-icons.css"
   type="text/css">
<link rel="stylesheet" href="resources/css/jquery-ui.min.css"
   type="text/css">
<link rel="stylesheet" href="resources/css/magnific-popup.css"
   type="text/css">
<link rel="stylesheet" href="resources/css/owl.carousel.min.css"
   type="text/css">
<link rel="stylesheet" href="resources/css/slicknav.min.css"
   type="text/css">
<link rel="stylesheet" href="resources/css/style.css" type="text/css">

<!-- 쿼리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<style>
input[type=text]::-ms-clear {
display:none;
}
</style>
</head>

<body>
   <!-- Page Preloder -->
   <div id="preloder">
      <div class="loader"></div>
   </div>

   <!-- Offcanvas Menu Begin -->
   <div class="offcanvas-menu-overlay"></div>
   <div class="offcanvas-menu-wrapper">
      <div class="offcanvas__close">+</div>
      
      <!-- 탑쪽 로고 -->
      <div class="offcanvas__logo">
         <a href="/"><img src="resources/img/logo.png" alt="EzenKream"></a>
      </div>
      
      
      <div id="mobile-menu-wrap"></div>
      <ul class="offcanvas__widget">
         <c:if test="${sessionProfileName == 'admin'}">
            <li><a href="sales.admin">관리자페이지</a>
         </c:if>
         <li><a href="announce.user">고객센터</a>
         <li><a href="cartList.user">관심상품</a>
         <li><c:if test="${empty sessionUser_num}">
               <a href="main.login">
            </c:if> <c:if test="${not empty sessionUser_num}">
                        <a href="javascript:alarmClick()">
                     </c:if>
                    <i class="bi bi-bell" style="width=40px;height=40px;" id = "alarm_bell"></i></a>
         <li><c:if test="${empty sessionUser_num}">
               <a href="main.login">로그인</a>
            </c:if> <c:if test="${not empty sessionUser_num}">
               <a href="logout.login">로그아웃</a>
            </c:if>
      </ul>
   </div>
   <!-- Offcanvas Menu End -->

   <!-- Header Section Begin -->
   <header class="header">
      <div class="container1">
         <div class="row">
            <div class="col" align = "right">
                <div class="header__right">
            		<div class="header__right__auth"> 
                     <c:if test="${sessionProfileName == 'admin'}">
                        <a href="sales.admin">관리자페이지</a>
                     </c:if>
                     <a href="announce.user">고객센터</a>
                     <a href="cartList.user">관심상품</a>
                     <c:if test="${empty sessionUser_num}">
                        <a href="main.login">
                     </c:if>
                    <c:if test="${not empty sessionUser_num}">
                        <a href="javascript:alarmClick()">
                     </c:if>
                    <i class="bi bi-bell" style="width=40px;height=40px;" id = "alarm_bell2"></i></a>
                     <c:if test="${empty sessionUser_num}">
                        <a href="main.login">로그인</a>
                     </c:if>
                     <c:if test="${not empty sessionUser_num}">
                        <a href="logout.login">로그아웃</a>
                     </c:if>
                  </div>
               </div>
            </div>
         </div>
         
         <div class="row">
            <div class="col">
               <div class="header__logo">
                  <a href="main.main"><img src="resources/img/logo.png" alt="ezenKream"></a>
               </div>
            </div>
            
            <div class="col" align="right">
               <nav class="header__menu">
                  <ul>
                     <li><a href="main.main" style="font-size: 20px;" >HOME</a>
                     <li><a href="style.user" style="font-size: 20px;">STYLE</a>
                     <li><a href="shop.user" style="font-size: 20px;">SHOP</a>
                     <li>                     
                     <c:if test="${empty sessionUser_num}">
                        <a href="main.login" style="font-size: 20px;">
                     </c:if>
                     <c:if test="${not empty sessionUser_num}">
                        <a href="my.user?user_num=${sessionUser_num}" style="font-size: 20px;">
                     </c:if>
                     MY</a>                     
                    <!-- 검색 --><li><a href="search.user" style="font-size: 20px;"><i class="bi bi-search"></i></a>
                  </ul>
               </nav>
            </div>
         </div>
         <div class="canvas__open">
            <i class="fa fa-bars"></i>
         </div>
      </div>
   </header>