<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="style_top.jsp"%>
<!DOCTYPE html>
<html>
<head>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>

<script type="text/javascript">
	$(document).keypress(function(e) {
		if (e.keyCode == 13)
			e.preventDefault();
	});
	function checkSearch(num) {
		$('#searchResult *').remove();
		$('#moreShow *').remove();

		var co = Number(num);
		var search = $('#search').val();
		var searchStart = search.substr(0, 1);
		var searchCut = search.substr(1);
		$("#searchBt").attr("disabled", true);
		if (searchStart == "#") {
			$.ajax({
					url : './searchCheckHash', //Controller에서 요청 받을 주소
					type : 'post', //POST 방식으로 전달
					data : {
						search : searchCut
					},
					cache : false,
					success : function(list) {//컨트롤러에서 넘어온 cnt값을 받는다     
						if (list.length > co) {
							var bt = document.createElement('input');
							bt.type = 'button';
							bt.value = '더보기';
							bt.className = 'btn btn-outline-dark';
							bt.onclick = function() {
								checkSearch((co + 5))
							}
							document.getElementById('moreShow')
									.appendChild(bt);
					}
						var count = 0;
							if (list.length == 0) {
								$('#searchResult').append(
										'<p>' + "검색 결과 값이 없습니다." + '</p>');

							}
							for ( var i in list) {
								++count;
								var obj = list[i];
								var hashTag_name = obj.hashTag_name;
								var hashTag_count = obj.hashTag_count;

								if (hashTag_name == searchCut) {
									$("#searchBt").attr("disabled", false);
									var bt = document.getElementById('search');
									bt.addEventListener(
													"keyup",
													function(event) {
														if (event.keyCode == 13) {
															document
																	.getElementById(
																			'searchBt')
																	.click();
														}
													});

								}
								hashTag = '<div align=center><br><a href=styleBoardSearch.user?search='
										+ encodeURIComponent("#" + hashTag_name)
										+ '>'
										+ "#"
										+ hashTag_name
										+ "<pre><font size='2' color='black'>"
										+ hashTag_count
										+ "게시물"
										+ '</font></a></div>'

								$('#searchResult').append(hashTag);

								if (count == co)
									break
							}
						},
					});
		} else if (searchStart == "@") {
			$.ajax({
				url : './searchCheckNick', //Controller에서 요청 받을 주소
				type : 'post', //POST 방식으로 전달
				data : {
					search : searchCut
				},
				cache : false,
				success : function(list) {
					if (list.length > co) {
						var bt = document.createElement('input');
						bt.type = 'button';
						bt.value = '더보기';
						bt.className = 'btn btn-outline-dark';
						bt.onclick = function() {
							checkSearch((co + 5))
						}
						document.getElementById('moreShow').appendChild(bt);
					}
					var count = 0;
					if (list.length == 0) {
						$('#searchResult').append(
								'<p>' + "검색 결과 값이 없습니다." + '</p>');
						//$("#f button[type=submit]").addClass("disabled")
					}
					for ( var i in list) {
						++count;
						var obj = list[i];
						var profile_name = obj.profile_name;
						if (profile_name == searchCut) {
							$("#searchBt").attr("disabled", false);
							var bt = document.getElementById('search');
							bt.addEventListener("keyup",
									function(event) {
										if (event.keyCode == 13) {
											document.getElementById('searchBt')
													.click();
										}
									});
						}
						nick = '<br><a href=styleBoardSearch.user?search='
								+ "@" + profile_name + '>' + "@" + profile_name
								+ '</a>'
						$('#searchResult').append(nick);
						if (count == co)
							break;
					}
				},

			});
		}

	};
</script>
</head>
<body>
<div align="center" class="basicFont">
	<table>
		<tr>
			<td>
				<form id="searchForm" action="styleBoardSearch.user" method="post">
					<input class="form-control" type="text" name="search" id="search"
						style=" WIDTH: 150pt; HEIGHT: 30pt;"
						oninput="checkSearch('5')" />
					<button name="searchBt" id="searchBt" value="검색"
						style="font-size: 18pt; WIDTH: 150pt; HEIGHT: 30pt"
						class="btn btn-outline-dark " type="submit" disabled>검색</button>

				</form>
			</td>
		</tr>
	</table>
	<div id="searchResult" style="font-size:30px;"></div>
	<div id="moreShow"></div>
</div>	
</body>
</html>
<%@include file="../../bottom.jsp"%>