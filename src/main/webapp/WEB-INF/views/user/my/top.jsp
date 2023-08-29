<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../top.jsp"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User.My.Main</title>
</head>
<body>
	<div align="center" class="shopTop">
	<table border="1" width="800">
		<tr>
			<td width="20%" valign="top" align="left">
				<table  width="100%" style="text-align:center;">					
					<tr><td>
					<input type="button" value="마이페이지" onclick="location.href='my.user?user_num=${sessionUser_num}'"
						class="btn btn-outline-secondary" style="width:100%;">
					</td></tr>	
					<tr><td>
					<input type="button" value="구매내역" onclick="location.href='buyList.user'"
						class="btn btn-outline-secondary" style="width:100%;">
					</td></tr>		
					<tr><td>
					<input type="button" value="판매내역" onclick="location.href='sellList.user'"
						class="btn btn-outline-secondary" style="width:100%;">
					</td></tr>	
					<tr><td>
					<input type="button" value="관심상품" onclick="location.href='cartList.user'"
						class="btn btn-outline-secondary" style="width:100%;">
					</td></tr>
					<tr><td>
					<input type="button" value="프로필" onclick="location.href='myProfile.user?user_num=${sessionUser_num}&mode=my'"
						class="btn btn-outline-secondary" style="width:100%;">
					</td></tr>
					<tr><td>
					<input type="button" value="로그인 정보" onclick="location.href='loginInfo.user?user_num=${sessionUser_num}'"
						class="btn btn-outline-secondary" style="width:100%;">
					</td></tr>
					<tr><td>
					<input type="button" value="주소록" onclick="location.href='address.user?user_num=${sessionUser_num}'"
						class="btn btn-outline-secondary" style="width:100%;">
					</td></tr>
					<tr><td>
					<input type="button" value="결제정보" onclick="location.href='card.user?user_num=${sessionUser_num}'"
						class="btn btn-outline-secondary" style="width:100%;">
					</td></tr>
					<tr><td>
					<input type="button" value="판매정산 계좌" onclick="location.href='account.user?user_num=${sessionUser_num}'"
						class="btn btn-outline-secondary" style="width:100%;">
					</td></tr>
					<tr><td>
					<input type="button" value="포인트" onclick="location.href='point.user?user_num=${sessionUser_num}'"
						class="btn btn-outline-secondary" style="width:100%;">
					</td></tr>
				</table>
			</td>
			<td width="80%">