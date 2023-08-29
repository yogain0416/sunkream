<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<header class="header">
		<div class="container-fluid" align="center">
			<div class="col-xl-6 col-lg-7">
				<nav>
					<ul>
						<li>상품 검색:<input type="text" id="search"
							oninput="searchList('${upPath}','5')" onkeypress="search(event)"
							placeholder="상품명을 입력하세요." value = "${searchString}" size="30">
							<div id="searchResult"></div>
							<div id="moreShow"></div>
						</li>
					</ul>
				</nav>
			</div>
		</div>
		
		<!-- 브랜드 넣어주세요 -->
		 <div class="container-fluid" align="center">
         <div class="col-xl-9 col-lg-9">
            <nav class="header__menu">
               <ul>
               <c:forEach var = "dto" items = "${brandList}">
                  <li><a href = "javascript:sendBrand('${dto}')">${dto}</a></li>
                </c:forEach>
               </ul>
            </nav>
         </div>
      </div>
		
	</header>
<div class="div3" align="left">
		<section class="shop spad">
			<div class="container">
				<div class="row">
					<div class="col-lg-3 col-md-3">
						<div class="shop__sidebar">
							<div class="sidebar__categories">
								<div class="categories__accordion">
									<div class="accordion" id="accordionEx">
										<!-- 카테고리 -->
										<c:forEach var="cate" items="${cate_kr_type_list}">
											<div class="card">
												<div class="card-heading">
													<!-- 카테고리 대분류 -->
													<a data-toggle="collapse" data-target="${'#' += cate} " ><b>${cate}</b></a>
												</div>
												<div id="${cate}" class="collapse show"	data-parent="#accordionEx">
													<div class="card-body">
														<ul>
															<c:forEach var="dto" items="${two}">
																<c:if test="${cate  eq dto.cate_kr_type }">
																	<!-- 카테고리 소분류 -->
																	<li><a href="javascript:sendSubCate('${dto.cate_kr_subType}')">${dto.cate_kr_subType}</a></li>
																</c:if>
															</c:forEach>
														</ul>
													</div>
												</div>
											</div>
										</c:forEach>
										
										<!-- 브랜드 -->
										<div class="card">
											<div class="card-heading">
												<a data-toggle="collapse" data-target="#brand"><b>브랜드</b></a>
											</div>
											<c:forEach var = "dto" items = "${brandList}">
											<div id="brand" class="collapse show"	data-parent="#accordionEx">
												<div class="card-body">
													<ul>
                  											<li><a href = "javascript:sendBrand('${dto}')">${dto}</a></li>
                										
													</ul>
													</div>
											</div>
													</c:forEach>
												
										</div>
										
										<!-- 성별 -->
										<div class="card">
											<div class="card-heading">
												<a data-toggle="collapse" data-target="#gender"><b>성별</b></a>
											</div>
											<div id="gender" class="collapse show"	data-parent="#accordionEx">
												<div class="card-body">
													<ul>
                  										<li><a href = "javascript:sendGender('All')">전체</a></li>
                  										<li><a href = "javascript:sendGender('M')">남성</a></li>
                  										<li><a href = "javascript:sendGender('F')">여성</a></li>
													</ul>
												</div>
											</div>
										</div>
										
										<!-- 사이즈 -->
										<div class="card">
											<div class="card-heading">
												<a data-toggle="collapse" data-target="#size"><b>사이즈</b></a>
											</div>
											<div id="size" class="collapse show"	data-parent="#accordionEx">
												<div class="card-body">
													<!-- 신발 -->
													<font>신발</font><br>
													<c:forEach var="i" begin="220" end="300" step="5">
                  										<input type="button" value="${i}" 
                  										class="btn btn-outline-dark" onclick="sendSize('${i}')">
                  									</c:forEach>
                  									<!-- 상의/하의/아우터-->
                  									<br><br><font>상의/하의/아우터</font><br>
                  									<input type="button" value="XS" 
                  										class="btn btn-outline-dark" onclick="sendSize('XS')">
                  									<input type="button" value="S" 
                  										class="btn btn-outline-dark" onclick="sendSize('S')">
                  									<input type="button" value="M" 
                  										class="btn btn-outline-dark" onclick="sendSize('M')">
                  									<input type="button" value="L" 
                  										class="btn btn-outline-dark" onclick="sendSize('L')">
                  									<input type="button" value="XL" 
                  										class="btn btn-outline-dark" onclick="sendSize('XL')">
                  									<input type="button" value="XXL" 
                  										class="btn btn-outline-dark" onclick="sendSize('XXL')">
                  									<!-- 나머지 -->
                  									<br><br><font>나머지</font><br>
                  									<input type="button" value="ONESIZE" 
                  										class="btn btn-outline-dark" onclick="sendSize('ONESIZE')">	
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="sidebar__filter"></div>
						</div>
					</div>
