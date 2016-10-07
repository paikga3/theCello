<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/resources/template/header.jsp"/>

<div class="jumbotron" style="margin-top: 25px;color:black;">
	<div class="container" style="text-align: center;">
		<h1>가격정책</h1>
	</div>
</div>

<style>
	
	
	.no-left-padding {
		padding-left: 0;
	}
</style>

<div class="container">
	<div class="row">
		<div class="col-md-12 no-left-padding" style="padding-bottom:5px;">
			<span class="glyphicon glyphicon-map-marker"></span>
			대실
		</div>
	</div>
	<div class="row">
		<div class="col-md-12" style="background-color:#5849ca;color:white;font-weight: bold;padding-top:10px;padding-bottom:10px;">
			이용시간 : 4시간<br/>
			입실가능시간 : 09:00~21:00<br/>
			이용요금 : 2만원
		</div>
		
	</div>
	
	
	
	
	<div class="row" style="margin-top:40px;">
		<div class="col-md-12 no-left-padding" style="padding-bottom:5px;">
			<span class="glyphicon glyphicon-map-marker"></span>
			숙박
		</div>
	</div>
	<div class="row" style="background-color:#5849ca;color:white;font-weight: bold;">
		<div class="col-md-12" style="padding-top:10px;padding-bottom:10px;">
			- 이용시간에 대한 규정
		</div>
		
		<div class="col-md-12" style="padding-bottom:10px;">
			이용시간은 입실 후 12시간이 원칙입니다. 단 19:00 ~ 24:00 사이에 입실하였다면 24:00까지의 시간은 
			포함하지 않습니다.
		</div>
	</div>
	
	<div class="row" style="background-color:#5849ca;color:white;margin-top:20px;font-weight: bold;">
		<div class="col-md-12" style="padding-top:10px;padding-bottom:10px;">
			- 입실시간에 대한 규정
		</div>
		
		<div class="col-md-12" style="padding-bottom:10px;">
			입실시간에 대한 제한은 없습니다. 단 입실시간과 퇴실시간에 따라 추가요금이 발생할 수 있습니다.
		</div>
	</div>
	
	<div class="row" style="background-color:#5849ca;color:white;margin-top:20px;font-weight: bold;">
		<div class="col-md-12" style="padding-top:10px;padding-bottom:10px;">
			- 이용요금에 대한 규정
		</div>
		
		<div class="col-md-12" style="padding-bottom:10px;">
			일반실<br/>
			- 일,월,화,수,목 : 3만원<br/>
			- 금,토 : 3만5천원<br/>
			<br/>
			특실 <br/>
			- 요일관계없이 : 4만원
		</div>
	</div>
	
	<div class="row" style="background-color:#5849ca;color:white;margin-top:20px;font-weight: bold;">
		<div class="col-md-12" style="padding-top:10px;padding-bottom:10px;">
			- 입실시간에 따른 추가요금 규정
		</div>
		
		<div class="col-md-12" style="padding-bottom:10px;">
			입실시간에 관계없이 입실 후 12시간을 이용하시고 퇴실하시면 추가요금은 없습니다. 그러나 18:00이전에 입실하시고 다음날 12:00에 퇴실하시면 입실시간에 따른 추가요금이 있습니다.
			18:00~19:00 입장시 추가요금은 없으나 다음날 오전11시 퇴실입니다.<br/><br/>
			12:00~15:00 입실 : 2만원<br/>
			15:00~18:00 입실 : 1만원<br/>
		</div>
	</div>
	
	<div class="row" style="background-color:#5849ca;color:white;margin-top:20px;font-weight: bold;">
		<div class="col-md-12" style="padding-top:10px;padding-bottom:10px;">
			- 퇴실시간에 따른 추가요금 규정
		</div>
		
		<div class="col-md-12" style="padding-bottom:10px;">
			퇴실시간 1~2시간 연장 : 1만원<br/>
			퇴실시간 2~4시간 연장 : 2만원
		</div>
	</div>
	
	<div class="row" style="background-color:#5849ca;color:white;margin-top:20px;margin-bottom:50px;font-weight: bold;">
		<div class="col-md-12" style="padding-top:10px;padding-bottom:10px;">
			- 인원추가에 따른 추가요금 규정
		</div>
		
		<div class="col-md-12" style="padding-bottom:10px;">
			2인초과시 초과되는 1인당 5천원씩 추가요금이 발생합니다.
		</div>
	</div>
</div>



<jsp:include page="/resources/template/footer.jsp" />