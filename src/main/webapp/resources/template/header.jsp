<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>the Cello</title>

<link rel='stylesheet' id='miami_bootstrap_css-css'
	href='<%=request.getContextPath() %>/resources/lib/bootstrap/css/bootstrap.min.css' />
<script src='<%=request.getContextPath() %>/resources/lib/jQuery/jquery-2.2.3.js'></script>
<script src='<%=request.getContextPath() %>/resources/lib/bootstrap/js/bootstrap.min.js'></script>
<link rel="stylesheet"  href="<%=request.getContextPath() %>/resources/css/template/header.css" />
<link rel="shortcut icon" href="<%=request.getContextPath() %>/resources/imgs/asset/favicon.ico"/>
<style>
		.menu > li {
			list-style-type: none;
			float: left;
			color: black;
			margin-right: 30px;
		}
		
		.menu > li > a {
			color: black;
		}
		
		.mobile-btn {
			font-size: 20px;
			margin-top: 20px;
			cursor: default;
		}
		
		

</style>
<STYLE>
BODY { scrollbar-3dlight-color:#FFFFFF;
scrollbar-arrow-color:#666666;
scrollbar-track-color:#FFFFFF;
scrollbar-darkshadow-color:#FFFFFF;
scrollbar-face-color:#FFFFFF;
scrollbar-highlight-color:#C9C9C9;
scrollbar-shadow-color:#C9C9C9;
}
</STYLE>
</head>

<body>
	<div class="navbar-fixed-top nav" style="background: #E5E3E1;padding-top:2px;padding-bottom:2px;">
		<div class="container hidden-xs" style="min-width: 800px;">
			<ul class="menu">
				<li style="margin-right: 100px;">
					<a href="<%=request.getContextPath()%>/home" >
						<img src="http://paikga5.cdn3.cafe24.com/resources/favicon/favicon.png"/>첼로
					</a>
				</li>
				<li class="s_menu"><a href="<%=request.getContextPath()%>/room" class="link">객실보기</a></li>
				<li class="s_menu"><a href="<%=request.getContextPath()%>/price" class="link">가격정책</a></li>
				<li class="s_menu"><a href="<%=request.getContextPath()%>/notice" class="link">공지사항</a></li>
				<li class="s_menu"><a href="<%=request.getContextPath()%>/reservation" class="link" id="dorev">예약하기</a></li>
				<li class="s_menu"><a href="<%=request.getContextPath()%>/revconfirm" class="link">예약확인</a></li>
				<li class="s_menu" style="margin-right:0px;"><a href="<%=request.getContextPath()%>/map" class="link">오시는길</a></li>
			</ul>
		</div>
		<div class="visible-xs" style="text-align: center;font-size:14px;margin-bottom:2px;">
			<span style="cursor: default;" class="mobile-menu-btn">모바일메뉴</span>
		</div>
	</div>
	
	<div style="background-color: rgba(0,0,0,1);color:white;left:0;top:0;z-index:2000; position:fixed;" class="mobile-nav visible-xs" align="center">
		<div class="mobile-menu-set" style="position:absolute;">
			<div class="mobile-btn" data-href="<%=request.getContextPath()%>/home">홈</div>
			<div class="mobile-btn" data-href="<%=request.getContextPath()%>/room">객실보기</div>
			<div class="mobile-btn" data-href="<%=request.getContextPath()%>/price">가격정책</div>
			<div class="mobile-btn" data-href="<%=request.getContextPath()%>/notice">공지사항</div>
			<div class="mobile-btn" data-href="<%=request.getContextPath()%>/reservation">예약하기</div>
			<div class="mobile-btn" data-href="<%=request.getContextPath()%>/revconfirm">예약확인</div>
			<div class="mobile-btn" data-href="<%=request.getContextPath()%>/map">오시는길</div>
			<div class="mobile-btn">메뉴나가기</div>
		</div>
		
	</div>
	
	<script type="text/javascript">
		$(document).ready(function() {
			
			$('.mobile-nav').css({
				left: $(document).width() * -1 + 'px',
				top: '0px',
				width: $(document).width(),
				height: $(document).height()
			});
			$('.mobile-menu-set').css({
				top:  ( $(window).height() - $('.mobile-menu-set').height() ) / 2 + 'px',
				left : ( $(window).width() - $('.mobile-menu-set').width() ) / 2 + 'px'
			});
			
			$(window).resize(function() {
				$('.mobile-nav').css({
					left: $(document).width() * -1 + 'px',
					top: '0px',
					width: $(document).width(),
					height: $(document).height()
				});
				$('.mobile-menu-set').css({
					top:  ( $(window).height() - $('.mobile-menu-set').height() ) / 2 + 'px',
					left : ( $(window).width() - $('.mobile-menu-set').width() ) / 2 + 'px'
				});
			});
			
			$('.mobile-menu-btn').click(function() {
				$('.mobile-nav').show().animate({
					left: '0px'
				}, 500);
				$('body').css('overflow', 'hidden');
			});

			$('.mobile-btn').click(function() {
				var href = $(this).data('href');
				
				$('.mobile-nav').animate({
					left: $(document).width() * -1 + 'px'
				}, 500, function() {
					$('body').css('overflow-y', 'scroll');
					$(this).hide();
					if(href != undefined) {
						location.replace(href);
					} 
					
				});
				
			});
		});
	</script>

	<!-- 현재페이지에 메뉴 매칭, 메뉴 롤오버시 -->
	<script type="text/javascript">
		$(document).ready(function() {
			var idx = location.href.lastIndexOf('\/');
			var link = location.href.substring(idx);
			
			$('.link').each(function() {
				var href = $(this).attr('href');
				var idx2 = href.lastIndexOf('\/');
				var link2 = href.substring(idx2);
				
				if(link == link2 || location.href.indexOf(link2) != -1) {
					$(this).parent('li').css('backgroundColor', '#4C40ED');
					$(this).css('color', '#fff');
					$(this).parent('li').addClass('act');
				}
			});
			
			
			
			$('.menu > .s_menu:not(.act)').hover(function() {
				$(this).css('backgroundColor', '#4C40ED');
				$(this).find('a').css({
					color: '#fff'
				});
			}, 
			function() {
				$(this).css('backgroundColor', '#E5E3E1');
				$(this).find('a').css({
					color: '#000'
				});

			});
			
		});
	</script>