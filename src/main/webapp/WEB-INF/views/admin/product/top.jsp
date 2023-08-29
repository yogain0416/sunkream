<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<meta charset="UTF-8">
<meta name="description" content="Ashion Template">
<meta name="keywords" content="Ashion, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>KREAM</title>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="resources/js/jquery-3.3.1.min.js"></script>
<script src="resources/js/bootstrap.min.js"></script>
<script src="resources/js/jquery.magnific-popup.min.js"></script>
<script src="resources/js/jquery-ui.min.js"></script>
<script src="resources/js/mixitup.min.js"></script>
<script src="resources/js/jquery.countdown.min.js"></script>
<script src="resources/js/jquery.slicknav.js"></script>
<script src="resources/js/owl.carousel.min.js"></script>
<script src="resources/js/jquery.nicescroll.min.js"></script>
<script src="resources/js/main.js"></script>
<script src="resources/js/jquery-3.3.1.min.js"></script>
<script src="resources/js/bootstrap.min.js"></script>
<script src="resources/js/jquery.magnific-popup.min.js"></script>
<script src="resources/js/jquery-ui.min.js"></script>
<script src="resources/js/mixitup.min.js"></script>
<script src="resources/js/jquery.countdown.min.js"></script>
<script src="resources/js/jquery.slicknav.js"></script>
<script src="resources/js/owl.carousel.min.js"></script>
<script src="resources/js/jquery.nicescroll.min.js"></script>
<script src="resources/js/main.js"></script>
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
<link rel="stylesheet" href="resources/css/slide.css" type="text/css">
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
</head>
<body>
	<div align="right">
		<header class="header">
			<div class="container-fluid">
				<div class="row">
					<div class="col-xl-3 col-lg-2">
						<div class="header__logo">
							<a href="./index.html"><img src="resources/images/logo.png"
								width="100" height="100"></a>
						</div>
					</div>
					<div class="col-xl-6 col-lg-7">
						<nav class="header__menu">
							<ul>
								<li><a href="./index.html">Home</a></li>
								<li><a href="prodCateInput.admin">STYLE</a></li>
								<li><a href="prodCateList.admin">SHOP</a></li>
								<li><a href="#">Pages</a>
									<ul class="dropdown">
										<li><a href="./product-details.html">Product Details</a></li>
										<li><a href="./shop-cart.html">Shop Cart</a></li>
										<li><a href="./checkout.html">Checkout</a></li>
										<li><a href="./blog-details.html">Blog Details</a></li>
									</ul></li>
							</ul>
						</nav>
					</div>
					<div class="col-lg-3">
						<div class="header__right">
							<div class="header__right__auth">
								<a href="#">고객센터</a> <a href="#">마이페이지</a> <a href="#">관심상품</a>
								<a href="#">알림</a> <a href="#">로그인</a>
							</div>
							<!-- <ul class="header__right__widget">
                            <li><span class="icon_search search-switch"></span></li>
                            <li><a href="#"><span class="icon_heart_alt"></span>
                                <div class="tip">2</div>
                            </a></li>
                            <li><a href="#"><span class="icon_bag_alt"></span>
                                <div class="tip">2</div>
                            </a></li>
                        </ul>
                        -->
						</div>
					</div>
				</div>
				<div class="canvas__open">
					<i class="fa fa-bars"></i>
				</div>
			</div>
				<c:if test = "${not empty brandList }">
				<div class ="div2" align = "left">
			<div class="container-fluid">
				<div class="col-xl-6 col-lg-7">
					<nav class="header__menu">
						<ul>
							<c:forEach var="dto" items="${brandList }">
								<li><a href="prodList.admin?mode=brand&brand=${dto }">${dto }</a></li>
							</c:forEach>
						</ul>
					</nav>
				</div>
			</div>
			</div>
		</c:if>
		</header>
	
	</div>
	