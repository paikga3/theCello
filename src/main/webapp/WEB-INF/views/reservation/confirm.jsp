<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/resources/template/header.jsp"/>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/lib/ui/jquery-ui.css"/>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/lib/ui/jquery-ui.structure.css"/>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/lib/ui/jquery-ui.theme.css"/>

<script src="<%=request.getContextPath()%>/resources/lib/ui/jquery-ui.js"></script>

<style>
.search {
	background: rgba(241, 118, 122, 0.8);
}

.search:hover {
	background: rgba(241, 118, 122, 1);
}

</style>

<div class="jumbotron" style="margin-top: 25px;color:black;">
	<div class="container" style="text-align: center;">
		<h1>예약확인</h1>
	</div>
</div>

<div class="container" style="min-height: 550px;">

	<div class="input-group">
        <span class="input-group-addon"> <span class="glyphicon glyphicon-search"> </span> </span>            
        <input type="text" class="form-control" placeholder="문자로 전송되어진 예약번호로 검색해주세요." id="id">
        <input type="hidden" value="${pageContext.request.contextPath }" id="contextPath"/>
         <span class="input-group-btn" > <button class="btn search" style="color:white;"  type="button" id="search">검색</button> </span>  
    </div> 
	
	<div style="width:100%;padding:10px;background-color:#b0bdee;margin-top:30px;margin-bottom:30px;">
		<div>
			<span>예약자성함 : </span>
			<span id="revName"></span>
		</div>
		<div>
			<span>휴대폰번호 : </span>
			<span id="revPhone"></span>
		</div>
		<div>
			<span>입실인원수 : </span>
			<span id="revNum"></span>
		</div>
		<div>
			<span>입실시간 : </span>
			<span id="revFromTime"></span>
		</div>
		<div>
			<span>퇴실시간 : </span>
			<span id="revToTime"></span>
		</div>
		<div>
			<span>객실유형 : </span>
			<span id="revRoomType"></span>
		</div>
		<div>
			<span>조기입실추가금 : </span>
			<span id="revEarly"></span>
		</div>
		<div>
			<span>지연퇴실추가금 : </span>
			<span id="revLazy"></span>
		</div>
		<div>
			<span>금,토 일수 : </span>
			<span id="revHoliday"></span>
		</div>
		<div>
			<span>총 숙박일수 : </span>
			<span id="revStayDays"></span>
		</div>
		<div>
			<span>총 숙박요금 : </span>
			<span id="revPrice"></span>
		</div>
		<div>
			<span>입금여부 : </span>
			<span id="isPaid"></span>
		</div>
	</div>
</div>
<script>
	(function() {
		var contextPath = $("#contextPath").val();
		var ing = false;
		function ajaxFunc() {
			if(ing) {
				return;
			}
			ing = true;
			var id = $("#id").val();
			if(/^\d+$/.test(id)) {
				$.ajax({
					type: "GET",
					url: contextPath + "/reservation/getinfo",
					contentType:"application/json; charset=UTF-8",
					dataType: "json",
					data: {id: id},
					success: function(data) {
						if(data["null"] == true) {
							ing = false;
							alert("존재하지 않는 예약번호입니다.");
							return;
						}
						
						if(data["exceed"] == true) {
							ing = false;
							alert("퇴실시간이 현재보다 이전인 만료된 예약입니다.");
							return;
						}

						$("#revName").text(data["revName"]);
						$("#revPhone").text(data["revPhone"]);
						$("#revNum").text(data["revNum"] + "명");
						$("#revFromTime").text(data["revFromTime"]);
						$("#revToTime").text(data["revToTime"]);
						$("#revRoomType").text(data["revRoomType"]);
						$("#revEarly").text(data["revEarly"] + "원");
						$("#revLazy").text(data["revLazy"] + "원");
						$("#revHoliday").text(data["revHoliday"] + "일");
						$("#revStayDays").text(data["revStayDays"] + "일");
						$("#revPrice").text(data["revPrice"] + "원");
						$("#isPaid").text(data["isPaid"]);
						ing = false;
					}
				});
			} else {
				ing = false;
				alert("예약번호는 숫자입니다. 다시 확인부탁드립니다.");
				return false;
			}
		}
		
		$("#search").click(ajaxFunc);
		$("#id").keydown(function(e) {
			if(e.which == 13) {
				ajaxFunc();
			}
		});
			
	})();
	

</script>

<jsp:include page="/resources/template/footer.jsp" />