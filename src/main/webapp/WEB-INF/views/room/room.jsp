<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/resources/template/header.jsp"/>

<script src="<%=request.getContextPath() %>/resources/lib/slide/jquery.slides.js"></script>
<style>
	.row {
		margin:0px 10px;
		padding:0px;
	}
	body {
		-webkit-font-smoothing: antialiased;
	}
#slides {
      display: none
    }

    #slides .slidesjs-navigation {
      margin-top:5px;
    }

    a.slidesjs-next,
    a.slidesjs-previous,
    a.slidesjs-play,
    a.slidesjs-stop {
      background-image: url(http://paikga5.cdn3.cafe24.com/resources/lib/slide/img/btns-next-prev.png);
      background-repeat: no-repeat;
      display:block;
      width:12px;
      height:18px;
      overflow: hidden;
      text-indent: -9999px;
      float: left;
      margin-right:5px;
    }
    
    .slidesjs-pagination li a {
      display: block;
      width: 13px;
      height: 0;
      padding-top: 13px;
      background-image: url(http://paikga5.cdn3.cafe24.com/resources/lib/slide/img/pagination.png);
      background-position: 0 0;
      float: left;
      overflow: hidden;
    }

    a.slidesjs-next {
      margin-right:10px;
      background-position: -12px 0;
    }

    a:hover.slidesjs-next {
      background-position: -12px -18px;
    }

    a.slidesjs-previous {
      background-position: 0 0;
    }

    a:hover.slidesjs-previous {
      background-position: 0 -18px;
    }

    a.slidesjs-play {
      width:15px;
      background-position: -25px 0;
    }

    a:hover.slidesjs-play {
      background-position: -25px -18px;
    }

    a.slidesjs-stop {
      width:18px;
      background-position: -41px 0;
    }

    a:hover.slidesjs-stop {
      background-position: -41px -18px;
    }

    .slidesjs-pagination {
      margin: 7px 0 0;
      float: right;
      list-style: none;
    }

    .slidesjs-pagination li {
      float: left;
      margin: 0 1px;
    }

    

    .slidesjs-pagination li a.active,
    .slidesjs-pagination li a:hover.active {
      background-position: 0 -13px
    }

    .slidesjs-pagination li a:hover {
      background-position: 0 -26px
    }

    #slides a:link,
    #slides a:visited {
      color: #333
    }

    #slides a:hover,
    #slides a:active {
      color: #9e2020
    }

    .navbar {
      overflow: hidden
    }
    
    
   /*  반응형 */
   #slides {
      display: none
    }

    .container {
      margin: 0 auto
    }

    /* For tablets & smart phones */
    @media (max-width: 767px) {
      body {
        padding-left: 20px;
        padding-right: 20px;
      }
      .container {
        width: auto
      }
    }

    /* For smartphones */
    @media (max-width: 480px) {
      .container {
        width: auto
      }
    }

    /* For smaller displays like laptops */
    @media (min-width: 768px) and (max-width: 979px) {
      .container {
        width: 724px
      }
    }

    /* For larger displays */
    @media (min-width: 1200px) {
      .container {
        width: 1170px
      }
    }
</style>
<div class="jumbotron" style="margin-top: 25px;color:black;">
	<div class="container" style="text-align: center;">
		<h1>객실보기</h1>
	</div>
</div>

<div class="container">
	<div style="width:100%;padding-top:20px;padding-bottom:20px;background-color:#c0caee;">
		<div style="text-align: center;font-size:20px;margin-bottom: 20px;"><span>옵션</span></div>
		<div style="text-align: center;">
			42인치 PDP TV, PC(초고속 인터넷), WIFI, 에어컨, 커피포트, 씨네호텔 영화서비스
		</div>
		
	</div>
	<div style="background-color: pink;text-align: center;padding:5px 0px;margin:10px 0px;">
		<h4>객실 전경입니다.. ^^</h4>
	</div>
    <div id="slides01" style="margin-bottom:30px;">
      <img src="http://paikga5.cdn3.cafe24.com/resources/imgs/room/room_01.jpg" alt="Photo">
      <img src="http://paikga5.cdn3.cafe24.com/resources/imgs/room/room_02.jpg" alt="Photo">
      <img src="http://paikga5.cdn3.cafe24.com/resources/imgs/room/room_03.jpg" alt="Photo">
      <img src="http://paikga5.cdn3.cafe24.com/resources/imgs/room/room_04.jpg" alt="Photo">
      <img src="http://paikga5.cdn3.cafe24.com/resources/imgs/room/room_05.jpg" alt="Photo">
      <img src="http://paikga5.cdn3.cafe24.com/resources/imgs/room/room_06.jpg" alt="Photo">
      <img src="http://paikga5.cdn3.cafe24.com/resources/imgs/room/room_07.jpg" alt="Photo">
      <img src="http://paikga5.cdn3.cafe24.com/resources/imgs/room/room_08.jpg" alt="Photo">
      <img src="http://paikga5.cdn3.cafe24.com/resources/imgs/room/room_09.jpg" alt="Photo">
      <img src="http://paikga5.cdn3.cafe24.com/resources/imgs/room/room_10.jpg" alt="Photo">
      <img src="http://paikga5.cdn3.cafe24.com/resources/imgs/room/room_11.jpg" alt="Photo">
      <img src="http://paikga5.cdn3.cafe24.com/resources/imgs/room/room_12.jpg" alt="Photo">
      <img src="http://paikga5.cdn3.cafe24.com/resources/imgs/room/room_13.jpg" alt="Photo">
      <img src="http://paikga5.cdn3.cafe24.com/resources/imgs/room/room_14.jpg" alt="Photo">
      <img src="http://paikga5.cdn3.cafe24.com/resources/imgs/room/room_15.jpg" alt="Photo">
      <img src="http://paikga5.cdn3.cafe24.com/resources/imgs/room/room_16.jpg" alt="Photo">
      <img src="http://paikga5.cdn3.cafe24.com/resources/imgs/room/room_17.jpg" alt="Photo">
    </div>
    
</div>



<script>
$(function() {
    $('#slides01').slidesjs({
      width: 940,
      height: 528,
      play: {
        active: true,
        auto: true,
        interval: 4000,
        swap: true
      }
    });
  });
</script>

<jsp:include page="/resources/template/footer.jsp" />