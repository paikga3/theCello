<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>예약 세부사항</title>
</head>
<body>

	<div id="detail" style="margin:10px;" class="table-responsive">
		<table class="table table-bordered table-condensed">
			<tr>
				<td>예약번호 : </td>
				<td>
					<input type="hidden" value="${detail.id }" id="id"/>
					<input type="hidden" value="${detail.expired }" id="isExpired"/>
					${detail.id }
				</td>
			</tr>
			<tr>
				<td>이름 : </td>
				<td><input type="text" value="${detail.revName }" id="revName"/></td>
			</tr>
			<tr>
				<td>휴대폰번호 : </td>
				<td><input type="text" value="${detail.revPhone }" id="revPhone"/></td>
			</tr>
			<tr>
				<td>인원 수 : </td>
				<td><input type="text" value="${detail.revNum }" id="revNum"/></td>
			</tr>
			<tr>
				<td>입실날짜 : </td>
				<td><input type="text" value="${from }" id="revFromTime"/></td>
			</tr>
			<tr>
				<td>퇴실날짜 : </td>
				<td><input type="text" value="${to }" id="revToTime"/></td>
			</tr>
			<tr>
				<td>방종류 : </td>
				<td><input type="text" value="${detail.revRoomType }" id="revRoomType"/></td>
			</tr>
			<tr>
				<td>지불여부 :</td>
				<td><input type="text" value="${detail.paid }" id="isPaid"/></td>
			</tr>
			<tr>
				<td>조기입실추가금 : </td>
				<td><input type="text" value="${detail.revEarly }" id="revEarly"/></td>
			</tr>
			<tr>
				<td>지연퇴실추가금 : </td>
				<td><input type="text" value="${detail.revLazy }" id="revLazy"/></td>
			</tr>
			<tr>
				<td>금,토 일수 : </td>
				<td><input type="text" value="${detail.revHoliday }" id="revHoliday"/></td>
			</tr>
			<tr>
				<td>총 숙박일수 : </td>
				<td><input type="text" value="${detail.revStayDays }" id="revStayDays"/></td>
			</tr>
			<tr>
				<td>숙박요금 : </td>
				<td><input type="text" value="${detail.revPrice }" id="revPrice"/></td>
			</tr>
			<tr>
				<td>만료처리여부 : </td>
				<td><input type="text" value="${detail.expired }" id="isExpired"/></td>
			</tr>
		</table>
		<button class="btn" id="admin_modify">수정</button>
		<button class="btn" id="admin_delete">삭제</button>
		
		<script type="text/javascript">
			(function() {
				var contextPath = '<%=request.getContextPath()%>';
				
				$("#admin_modify").click(function() {
					if(confirm("정말로 수정하시겠습니까?")) {
						$.ajax({
							type: "POST",
							url: contextPath +"/admin/revUpdate",
							contentType:'application/x-www-form-urlencoded; charset=UTF-8',
							data: {
								"id" : $("#id").val(),
								"revName" : $("#revName").val(),
								"revNum" : $("#revNum").val(),
								"revPhone" : $("#revPhone").val(),
								"revFromTime" : $("#revFromTime").val(),
								"revToTime" : $("#revToTime").val(),
								"revRoomType" : $("#revRoomType").val(),
								"isPaid" : $("#isPaid").val(),
								"isExpired" : $("#isExpired").val(),
								"revEarly" : $("#revEarly").val(),
								"revLazy" : $("#revLazy").val(),
								"revHoliday" : $("#revHoliday").val(),
								"revStayDays" : $("#revStayDays").val(),
								"revPrice" : $("#revPrice").val()
							},
							success: function() {
								alert("수정 성공하였습니다.");
								
							},
							error: function(jqXHR, textStatus, errorThrown ) {
								alert("textStatus=" + textStatus + "\nerrorThrown=" + errorThrown);
							}
						});
					}
					return false;
				});
				
				$("#admin_delete").click(function() {
					if(confirm("정말로 삭제하시겠습니까?")) {
						$.ajax({
							type: "POST",
							url: contextPath + "/admin/revDelete",
							contentType:'application/x-www-form-urlencoded; charset=UTF-8',
							data: {
								"id" : $("#id").val()
							},
							success: function() {
								alert("삭제 성공하였습니다.");
								$("#list").trigger("click");
								$("#revdetail").empty();
							},
							error: function() {
								alert("삭제 실패하였습니다.");
							}
							
						});
					}
					return false;
					
				});
			})();
			
			
		</script>
	</div>
</body>
</html>