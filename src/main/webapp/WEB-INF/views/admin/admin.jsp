<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ADMIN</title>
<link rel='stylesheet' id='miami_bootstrap_css-css'
	href='<%=request.getContextPath() %>/resources/lib/bootstrap/css/bootstrap.min.css' />
<script src='<%=request.getContextPath() %>/resources/lib/jQuery/jquery-2.2.3.js'></script>
<script src='<%=request.getContextPath() %>/resources/lib/bootstrap/js/bootstrap.min.js'></script>
<link rel="shortcut icon" href="<%=request.getContextPath() %>/resources/imgs/asset/favicon.ico"/>
<style>
.adminmenu > a {
	display: block;
}

input[type=text] {
	width: 100%;
}

.btn:HOVER, .btn:ACTIVE {
	background-color: #5164ec;
	color: #fff;
}
</style>
</head>
<body style="overflow: hidden;">
	
	<div class="row adminWrapper">
		<div class="col-md-2 col-xs-2 adminmenu" style="text-align: left; border-right: 1px solid #000;height:100%;">
			<h2>관리자 메뉴</h2>
			<a href="#" onclick="logoutForm.submit(); return false;">로그아웃하고 홈으로 가기</a>
			<a href="<%=request.getContextPath() %>/notice">공지사항으로 가기</a>
			<a href="#" id="list">예약목록보기</a>
			<a href="#" id="cleanExpired">만료처리하기</a>
		</div>
		<div class="col-md-2 col-xs-2" id="revlist" style="border-right:1px solid #000;height:100%;overflow: scroll;">
			
		</div>
		<div class="col-md-8 col-xs-8" id="revdetail"></div>
	</div>

<form action="logout" method="post" name="logoutForm"></form>


<!-- 
관리자페이지에서 처리해야될 것

예약에 대한 수정 삽입 삭제 조회가 가능해야 한다.
 -->
 
<script type="text/javascript">
	$(document).ready(function() {
		var contextPath = "<%=request.getContextPath()%>";
		function h () {
			var windowHeight = $(window).height();
			$('.adminWrapper').css("height", windowHeight + 'px');
		}
		
		h();
		
		$(window).resize(function() {
			h();
		});
		
		$("#list").click(function() {
			$.ajax({
				type: "POST",
				url: contextPath +"/admin/revList",
				contentType:'application/x-www-form-urlencoded; charset=UTF-8',
				dataType: "html",
				success: function(html) {
					$("#revlist").empty();
					$("#revdetail").empty();
					var htmlSource = html.match(/<html>(.|\s)*<\/html>/g) + '';
					$(htmlSource).filter(function() {
						if($(this).attr("id") == 'list') {
							return true;
						} else {
							return false;
						}
					}).appendTo("#revlist");
					
				}
			});
			return false;
		});
		
		$('#revlist').on('click', function(e) {
			
			var a = $(e.target).closest('a');
			if(a.attr("class") == 'item') {
				$.ajax({
					type: "GET",
					url: a.attr('href'),
					contentType:'application/x-www-form-urlencoded; charset=UTF-8',
					dataType: "html",
					success: function(html) {
						$("#revdetail").empty();
						var htmlSource = html.match(/<html>(.|\s)*<\/html>/g) + '';
						$(htmlSource).filter(function() {
							if($(this).attr("id") == 'detail') {
								return true;
							} else {
								return false;
							}
						}).appendTo("#revdetail");
					}
				});
				
			}
			
			return false;
		});
		
		$("#cleanExpired").click(function() {
			$.ajax({
				type: "POST",
				url: contextPath + "/admin/cleanExpired",
				contentType:'application/json; charset=UTF-8',
				dataType: "json",
				success: function(data) {
					$("#revdetail").empty();
					$("#list").trigger("click");
					alert(data["count"] + "건이 만료처리되었습니다.");
				},
				error: function() {
					alert("만료처리 중 에러가 발생하였습니다.");
				}
				
			});
			
			return false;
		});
		
	});
</script>

</body>
</html>