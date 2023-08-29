<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="top.jsp"%>
<div class = "div_container">
	<div class="div1">
		<div class="container">
			<div class="row">
				<div class="col-lg-3 col-md-3">
					<div class="shop__sidebar">
						<div class="sidebar__categories">
							<div class="categories__accordion">
								<div class="accordion" id="accordionExample">
									<div class="card">
										<div class="card-heading active">
											<a data-toggle="collapse" data-target="#collapseOne">상품</a>
										</div>
										<div id="collapseOne" class="collapse show"
											data-parent="#accordionExample">
											<div class="card-body">
												<ul>
													<li><a href="prodCateInput.admin">카테고리 등록</a></li>
													<li><a href="prodCateList.admin">카테고리 목록</a></li>
													<li><a href="prodInput.admin">상품 등록</a></li>
													<li><a href="prodList.admin">상품 목록</a></li>
													<li><a href="prodList.admin?mode=Y">삭제상품목록</a></li>
												</ul>
											</div>
										</div>
									</div>
									<div class="card">
										<div class="card-heading">
											<a data-toggle="collapse" data-target="#collapseTwo">회원</a>
										</div>
										<div id="collapseTwo" class="collapse"
											data-parent="#accordionExample">
											<div class="card-body">
												<ul>
													<li><a href="#">회원 보기</a></li>
													<li><div class="accordion" id="accordionExample2">
															<div class="card">
																<div class="card-heading">
																	<a data-toggle="collapse" data-target="#collapseSeven">회원
																		신고내역</a>
																</div>
																<div id="collapseSeven" class="collapse show"
																	data-parent="#accordionExample2">
																	<div class="card-body">
																		<ul>
																			<li><a href="#">신고처리완료</a></li>
																			<li><a href="#">신고처리대기</a></li>
																		</ul>
																	</div>
																</div>
															</div>
														</div></li>
												</ul>
											</div>
										</div>
									</div>
									<div class="card">
										<div class="card-heading">
											<a data-toggle="collapse" data-target="#collapseThree">매출</a>
										</div>
										<div id="collapseThree" class="collapse"
											data-parent="#accordionExample">
											<div class="card-body">
												<ul>
													<li><a href="#">총매출</a></li>
													<li><a href="#">즉시판매</a></li>
													<li><a href="#">회원판매</a></li>
												</ul>
											</div>
										</div>
									</div>
									<div class="card">
										<div class="card-heading">
											<a data-toggle="collapse" data-target="#collapseFour">게시글</a>
										</div>
										<div id="collapseFour" class="collapse"
											data-parent="#accordionExample">
											<div class="card-body">
												<ul>
													<li><a href="#">공지사항</a></li>
													<li><div class="accordion" id="accordionExample1">
															<div class="card">
																<div class="card-heading">
																	<a data-toggle="collapse" data-target="#collapseFive">문의내역리스트</a>
																</div>
																<div id="collapseFive" class="collapse show"
																	data-parent="#accordionExample1">
																	<div class="card-body">
																		<ul>
																			<li><a href="#">문의 내역 처리완료</a></li>
																			<li><a href="#">문의 내역 처리대기</a></li>
																		</ul>
																	</div>
																</div>
															</div>
														</div></li>
													<li><a href="#">스타일</a></li>
												</ul>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="sidebar__filter"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.magnific-popup.min.js"></script>
    <script src="js/jquery-ui.min.js"></script>
    <script src="js/mixitup.min.js"></script>
    <script src="js/jquery.countdown.min.js"></script>
    <script src="js/jquery.slicknav.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/jquery.nicescroll.min.js"></script>
    <script src="js/main.js"></script>