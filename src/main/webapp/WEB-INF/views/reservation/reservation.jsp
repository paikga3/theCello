<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/resources/template/header.jsp"/>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/lib/ui/jquery-ui.css"/>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/lib/ui/jquery-ui.structure.css"/>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/lib/ui/jquery-ui.theme.css"/>

<script src="<%=request.getContextPath() %>/resources/lib/ui/jquery-ui.js"></script>

<style>
	input[type=radio] + label {
		margin-left:5px;
		font-weight: normal;
		color: black;
	}
	
</style>

<div class="jumbotron" style="margin-top: 25px;color:black;">
	<div class="container" style="text-align: center;">
		<h1>예약하기</h1>
	</div>
</div>
<!-- 

예약 구성 내용

예약자이름, 연락처, 인원, 입실시간, 퇴실시간, 금액, 결제장소, 결제여부

-->

<div class="container">
	<form action="${pageContext.request.contextPath }/reservation/doRev" method="post" id="doRev">
	</form>
	<form method="post" id="form">
		<div class="panel">
			<h3 class="panel-header">예약 세부사항</h3>
		
			<div class="form-group">
				<label for="revName">예약자이름</label>
				<input type="text" id="revName" name="revName" class="form-control"/>
			</div>
		
			<div class="form-group">
				<label for="revPhone">연락처</label>
				<input type="text" id="revPhone" name="revPhone" class="form-control" placeholder="예: 01012341234" />
			</div>
			
			<div class="form-group">
				<div>
					<label>입실인원수</label>
				</div>
				<div class="form-control">
					<input type="radio" name="revNum" value="1" id="num1"/><label for="num1">1명</label>
					<input type="radio" name="revNum" value="2" id="num2"/><label for="num2">2명</label>
					<input type="radio" name="revNum" value="3" id="num3"/><label for="num3">3명</label>
					<input type="radio" name="revNum" value="4" id="num4"/><label for="num4">4명</label>
				</div>
			</div>
			
			<div class="form-group">
				<label>입실 날짜</label>
				<input type="text" placeholder="입실 날짜를 선택해주세요" class="form-control" id="from" name="revFromDate"/>
			</div>
			
			<div class="form-group">
				<label>입실 시간</label>
				<select name="revFromHour" id="fromHour">
					<option value="0" selected="selected">0시</option>
					<option value="1">1시</option>
					<option value="2">2시</option>
					<option value="3">3시</option>
					<option value="4">4시</option>
					<option value="5">5시</option>
					<option value="6">6시</option>
					<option value="7">7시</option>
					<option value="8">8시</option>
					<option value="9">9시</option>
					<option value="10">10시</option>
					<option value="11">11시</option>
					<option value="12">12시</option>
					<option value="13">13시</option>
					<option value="14">14시</option>
					<option value="15">15시</option>
					<option value="16">16시</option>
					<option value="17">17시</option>
					<option value="18">18시</option>
					<option value="19">19시</option>
					<option value="20">20시</option>
					<option value="21">21시</option>
					<option value="22">22시</option>
					<option value="23">23시</option>
				</select>
				<select name="revFromMin" id="fromMin">
					<option value="0">0분</option>
					<option value="30">30분</option>
				</select>
			</div>
			
			<div class="form-group">
				<label>퇴실 날짜</label>
				<input type="text" placeholder="퇴실 날짜를 선택해주세요" class="form-control" id="to" name="revToDate"/>
			</div>
			
			<div class="form-group">
				<label>퇴실 시간</label>
				<select name="revToHour" id="toHour">
					<option value="0" selected="selected">0시</option>
					<option value="1">1시</option>
					<option value="2">2시</option>
					<option value="3">3시</option>
					<option value="4">4시</option>
					<option value="5">5시</option>
					<option value="6">6시</option>
					<option value="7">7시</option>
					<option value="8">8시</option>
					<option value="9">9시</option>
					<option value="10">10시</option>
					<option value="11">11시</option>
					<option value="12">12시</option>
					<option value="13">13시</option>
					<option value="14">14시</option>
					<option value="15">15시</option>
					<option value="16">16시</option>
					<option value="17">17시</option>
					<option value="18">18시</option>
					<option value="19">19시</option>
					<option value="20">20시</option>
					<option value="21">21시</option>
					<option value="22">22시</option>
					<option value="23">23시</option>
				</select>
				<select name="revToMin" id="toMin">
					<option value="0">0분</option>
					<option value="30">30분</option>
				</select>
			</div>
			
			<div class="form-group">
				<label>객실선택</label>
				<select name="revRoomType">
					<option value="general">일반실</option>
					<option value="special">특실</option>
				</select>
			</div>
			
			<div class="form-group">
				<label>객실요금</label>
				<div style="background-color: #5141ea; color: white;">
					<div style="padding-top:10px;padding-left:10px;padding-right:10px;padding-bottom:10px;">
						<table class="table table-bordered table-condensed" style="margin:0px;text-align: center;">
							<tr>
								<td style="width:50%;">조기입실 추가요금</td>
								<td style="width:50%;" id="early"></td>
							</tr>
							<tr>
								<td>지연퇴실 추가요금</td>
								<td id="lazy"></td>
							</tr>
							<tr>
								<td>금,토 일수</td>
								<td id="holiday"></td>
							</tr>
							<tr>
								<td>총 숙박 일수</td>
								<td id="staydays"></td>
							</tr>
							<tr>
								<td>인원추가금(3명이상시 1명당)</td>
								<td id="num"></td>
							</tr>
							<tr>
								<td>총 금액</td>
								<td id="price"></td>
							</tr>
						</table>
					</div>

				</div>
				
				<div style="margin-top:20px;">
					<input type="button" class="ui-button ui-corner-all" value="계산하기" id="cal">
					<input type="button" class="ui-button ui-corner-all" value="다시계산" id="retry">
					<input type="button" class="ui-button ui-corner-all" value="예약확정" id="confirm">
					<input type="hidden" value="${pageContext.request.contextPath }" id="contextPath"/>
				</div>
				
			</div>

		</div>
	</form>
</div>


<script>

	(function() {
		jQuery.fn.serializeObject = function () {
		    var obj = null;
		    try {
		        if(this[0].tagName && this[0].tagName.toUpperCase() == "FORM") {
		            var arr = this.serializeArray();
		            if(arr) {
		                obj = {};
		                jQuery.each(arr, function() {
		                    obj[this.name] = this.value;
		                });
		            }
		        }
		    } catch (e) {
		        alert(e.message);
		    } finally {

		    }
		    return obj;
		};
		
		function eqDate(date1, date2) {
			if(date1 == null || date2 == null) {
				return false;
			}
			
			
			if(date1.getFullYear() == date2.getFullYear() &&
					date1.getMonth() == date2.getMonth() &&
					date1.getDate() == date2.getDate()) {
				return true;
			} else {
				return false;
			}
		}
		
		function diffOneDate(date1, date2) {
			if(date1 == null || date2 == null) {
				return false;
			}
			
			var time1 = date1.getTime();
			var time2 = date2.getTime();
			
			time1 += 24 * 60 * 60 * 1000;
			var diff = new Date();
			diff.setTime(time1);
			
			if(eqDate(diff, date2)) {
				return true;
			} else {
				return false;
			}
		}
		
		$("input[name=revNum]").each(function() {
			var val = $(this).val() * 1;
			if(val == 2) {
				$(this)[0].defaultChecked = true;
			}
		});

	    var dateFormat = "mm/dd/yy";

	    var fromOptions = {
	    		
	            changeMonth: true,
	            numberOfMonths: 1,
	            monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	    		monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	    		dayNamesMin: [ "일","월","화","수","목","금","토" ],
	    		onSelect: function(dateText, inst) {
	    			var selDate = $(this).datepicker("getDate");
	    			
	    			var toDate = $("#to").datepicker("getDate");
	    			var toDay = new Date();
					
	    			var fromHour = $("#fromHour")[0].selectedIndex;
	    			
	    	    	if(eqDate(selDate, toDay)) {
						
	    	    		$("#fromHour > option").each(function() {
	    	    			var selHour = $(this).val() * 1;
	    	    			var toDayHour = toDay.getHours();
	    	    			
	    	    			if(toDayHour + 1 >= selHour) {
	    	    				$(this).attr("disabled", "disabled");
	    	    			}
	    	    			
	    	    			if(toDayHour + 2 == selHour) {
	    	    				$("#fromHour")[0].selectedIndex = selHour;
	    	    			}
	    	    		});
	    	    	} else if(eqDate(selDate, toDate)) {
	    	    		
	    	    		$("#fromHour > option").removeAttr("disabled");
	    	    		$("#toHour > option")
	    	    		.removeAttr("disabled")
	    	    		.each(function() {
	    	    			var selHour = $(this).val() * 1;
	    	    			if(selHour < 12) {
	    	    				$(this).attr("disabled", "disabled");
	    	    			}
	    	    		});
	    	    		
	    	    		
	    	    		$("#fromHour")[0].selectedIndex = 0;
	    	    		$("#toHour")[0].selectedIndex = 12;
	    	    	} else if(diffOneDate(selDate, toDate)) {
	    	    		
	    	    		if(fromHour > 11) {
	    	    			
	    	    			var extra = fromHour + 12 - 24;
	    	    			
	    	    			$("#toHour > option")
	    					.removeAttr("disabled")
	    					.each(function() {
	    						var selHour = $(this).val() * 1;
	    						if(extra > selHour) {
	    							$(this).attr("disabled", "disabled");
	    						} else {
	    							if(extra == selHour) {
	    								$("#toHour")[0].selectedIndex = selHour;
	    							}
	    						}
	    					});
	    	    		}
	    	    	} else {
	    	    		
	    	    		$("#fromHour > option").removeAttr("disabled");
	    	    		$("#fromHour")[0].selectedIndex = 0;
	    	    	}
	    	    	$('#to').datepicker( "option", "minDate", selDate );
	    		}	
	    };
	    
	    var toOptions = {
	    		minDate: 0,
	            changeMonth: true,
	            numberOfMonths: 1,
	            monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	    		monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	    		dayNamesMin: [ "일","월","화","수","목","금","토" ],
	    		onSelect: function(dateText, inst) {
	    			var selDate = $(this).datepicker("getDate");
					var fromDate = $("#from").datepicker("getDate");
					var toDay = new Date();
					
					var fromHour = $("#fromHour")[0].selectedIndex;
					$("#toHour > option").removeAttr("disabled");
					if(eqDate(selDate, fromDate)) {
						var fromHour = $("#fromHour").val() * 1;
						$("#fromHour > option").removeAttr("disabled");
						$("#toHour > option").removeAttr("disabled");
						if(fromHour >= 12) {
							var date = $(this).datepicker("getDate");
							var time = date.getTime();
							time += 24 * 60 * 60 * 1000;
							date.setTime(time);
							$(this).datepicker("setDate", date);
							
							var extra = fromHour - 12;
							$("#toHour > option").each(function() {
								var selHour = $(this).val() * 1;
								if(selHour < extra) {
									$(this).attr("disabled", "disabled");
								}
							});
							
							$("#toHour")[0].selectedIndex = extra;
							
						} else {
							$("#toHour > option").each(function() {
		    	    			var selHour = $(this).val() * 1;
		    	    			if(selHour < fromHour + 12) {
		    	    				$(this).attr("disabled", "disabled");
		    	    			}
		    	    			
		    	    			if(selHour == fromHour + 12) {
		    	    				$("#toHour")[0].selectedIndex = selHour;
		    	    			}
		    	    		});
						}

					} else if(diffOneDate(fromDate, selDate)) {
						
						if(fromHour > 11) {
			    			var extra = fromHour + 12 - 24;
			    			
			    			$("#toHour > option")
							.each(function() {
								var selHour = $(this).val() * 1;
								if(extra > selHour) {
									$(this).attr("disabled", "disabled");
								} else {
									if(extra == selHour) {
										$("#toHour")[0].selectedIndex = selHour;
									}
								}
							});
			    		} else {
			    			$("#toHour")[0].selectedIndex = 0;
			    		}

					} else {
						
						$("#toHour")[0].selectedIndex = 0;
					}

					$('#from').datepicker( "option", "maxDate", selDate );
	    		}
	    }
	    
	    
	    function getDate(date, hour) {
	    	var setTime = date.getTime();
	    	setTime += hour * 60 * 60 * 1000;
	    	date.setTime(setTime);
	    	return date;
	    }
	    
	    $('#from')
	    .datepicker(fromOptions)
	    .keydown(function() {
	    	alert("키보드를 통해 입력할 수는 없습니다. datepicker를 이용해주세요.");
	    	$(this).val('');
	    	return false;
	    });
	    $("#to")
	    .datepicker(toOptions)
	    .keydown(function() {
	    	alert("키보드를 통해 입력할 수는 없습니다. datepicker를 이용해주세요.");
	    	$(this).val('');
	    	return false;
	    });
	    
		
	    $('#from').datepicker("option", "minDate", getDate(new Date(), 2));
	    $('#to').datepicker("option", "minDate", getDate(new Date(), 14));
	    
	    $("#fromHour").change(function() {
			
	    	var fromDate = $("#from").datepicker("getDate");
	    	var toDate = $("#to").datepicker("getDate");
	    	
	    	var fromHour = $(this).val() * 1;
	    	
	    	if(eqDate(fromDate, toDate)) {
	    		
				$("#toHour > option")
					.removeAttr("disabled")
					.each(function() {
						var selHour = $(this).val() * 1;
						if(fromHour + 12 == selHour) {
							$("#toHour")[0].selectedIndex = selHour;
						} else if(fromHour + 12 > selHour) {
							$(this).attr("disabled", "disabled");
						}
					});
				
				if ($("#toHour > option[disabled=disabled]").length == 24) {
					var toDate = $("#to").datepicker("getDate");
					var date = getDate(toDate, 24);
					$("#to").datepicker("setDate", date);
					
					var extra = fromHour - 12;
					
					$("#toHour > option")
						.removeAttr("disabled")
						.each(function() {
							var selHour = $(this).val() * 1;
							if(extra > selHour) {
								$(this).attr("disabled", "disabled");
							} else {
								if(extra == selHour) {
									$("#toHour")[0].selectedIndex = selHour;
								}
							}
						});
					
				}
	    	} else if(diffOneDate(fromDate, toDate)) {
	    		
	    		if(fromHour > 11) {
	    			var extra = fromHour + 12 - 24;
	    			
	    			$("#toHour > option")
					.removeAttr("disabled")
					.each(function() {
						var selHour = $(this).val() * 1;
						if(extra > selHour) {
							$(this).attr("disabled", "disabled");
						} else {
							if(extra == selHour) {
								$("#toHour")[0].selectedIndex = selHour;
							}
						}
					});
	    		} else {
	    			$("#toHour > option").removeAttr("disabled");
	    			$("#toHour")[0].selectedIndex = 0;
	    		}
	    	}
	
		});
	    
	    $("#toHour").change(function() {
	    	var fromDate = $("#from").datepicker("getDate");
	    	var toDate = $("#to").datepicker("getDate");
	    	
	    	var fromHour = $("#fromHour").val() * 1;
	    	var toHour = $(this).val() * 1;
	    	
	    	if(eqDate(fromDate, toDate)) {
	  			if(fromHour + 12 > toHour) {
	  				alert("같은 날짜에서 퇴실시간이 " + fromHour + 12 + "시보다 빨라서는 안됩니다.");
	  				$("#toHour")[0].selectedIndex = fromHour + 12;
	  				return;
	  			}
	    	} else if(diffOneDate(fromDate, toDate)) {
	    		if(fromHour >= 12) {
	    			var extra = fromHour - 12;
	    			if(toHour < extra) {
	    				alert("퇴실시간은 " + extra + "시 이후여야 합니다.");
	    				$("#toHour")[0].selectedIndex = extra;
	    				return;
	    			}
	    		}
	    	}
	    });
	    
	    var isCal = false;
	    
	    
	    
	    $('#cal').click(function() {
			
	    	if(isCal) {
	    		alert("다시 계산하려면 다시계산하기를 누르세요.");
	    		return false;
	    	}
	    	
			// 유효성검증
			var revName = $("#revName").val();
			var revPhone = $("#revPhone").val();
			var revFromDate = $("#from").val();
			var revToDate = $("#to").val();

			if(revName.trim().length == 0) {
				alert("예약자이름은 필수사항입니다.");
				
				return false;
			} else if(revName.trim().length < 2) {
				alert("예약자이름은 2글자 이상이어야 합니다.");
				$("#revName").val('');
				$(this).button("enable");
				return false;
			}
			
			if(revName.match(/[0-9]/) != null) {
				alert("예약자이름에 숫자가 올수는 없습니다.");
				$("#revName").val('');
				
				return false;
			}
			
			if(revName.match(/[`~!@#$%^&*()\\/-_=+]/) != null) {
				alert("예약자이름에 특수문자가 올 수 없습니다.");
				$("#revName").val('');
				
				return false;
			}
			
			if(revName.match(/[\ ]/) != null) {
				alert("예약자이름에 공백이 있어서는 안됩니다.");
				$("#revName").val('');
				
				return false;
			}
			
			if(revName.match(/[a-zA-Z]/) != null) {
				alert("예약자이름은 한글이어야 합니다.");
				$("#revName").val('');
				
				return false;
			}
			
			
	        var verifiedArray = /^(\d{3,3})(\d{3,4})(\d{4,4})$/.exec(revPhone);
	        
	        if (verifiedArray != null) {
	            
	            var startPart = /^01[0|1|6-9]/.exec(verifiedArray[1]);
	            if (startPart == null) {
	                alert(verifiedArray[1] + "은 시작번호로 적합하지 않은 번호입니다.");
	                $("#revPhone").val('');
	                
	                return false;
	            } else {
	                if (verifiedArray[1] == '010' && verifiedArray[2].length == 3) {
	                    alert("010으로 시작하는 번호는 가운데 번호가 4자리여야 합니다.");
	                    $("#revPhone").val('');
	                    
	                    return false;
	                } else if (verifiedArray[1] != '010' && verifiedArray[1] != '011' && verifiedArray[2].length == 4) {
	                    alert("010, 011을 제외한 나머지는 가운데 번호가 3자리여야 합니다.");
	                    $("#revPhone").val('');
	                    
	                    return false;
	                }
	            }
	        } else {
	        	if(revPhone.trim().length == 0) {
	        		alert("휴대폰번호를 입력해주세요.");
	        		$("#revPhone").val('');
	        		
	        		return false;
	        	} else {
	        		alert("휴대폰번호는 11자리(010) 또는 10자리여야 합니다.");
	                $("#revPhone").val('');
	                
	                return false;
	        	}
	            
	        }
			
			if(revFromDate.trim().length == 0) {
				alert("입실날짜를 입력해주세요");
				$("#from").focus();
				
				return false;
			}
			
			if(revToDate.trim().length == 0) {
				alert("퇴실날짜를 입력해주세요.");
				$("#to").focus();
				
				return false;
			}
			
			var contextPath = $("#contextPath").val();
			var jsonData = $('#form').serializeObject();
			$.ajax({
				type: "POST",
				url: contextPath +"/reservation/cal",
				contentType:"application/json; charset=UTF-8",
				dataType: "json",
				data: JSON.stringify(jsonData),
				success: function(data) {
					if(data["error"]) {
						alert(data["error"]);
						
					} else {
						$("#early").text(data["early"] + "원");
						$("#lazy").text(data["lazy"] + "원");
						$("#holiday").text(data["holiday"] + "일");
						$("#staydays").text(data["staydays"] + "일");
						$("#num").text(data["num"] + "원");
						$("#price").text(data["price"] + "원");
						
						
						$("input, select").not("input[type=button]").attr("disabled", "disabled");
						isCal = true;
					}
				}
			});
			
		});
	    
	    $("#retry").click(function() {
	    	if(!isCal) {
	    		alert("아직 계산되어진 것이 없습니다.");
	    		return false;
	    	}
	    	
	    	$("input, select").not("input[type=button]").removeAttr("disabled");
	    	$("#early").text("");
			$("#lazy").text("");
			$("#holiday").text("");
			$("#staydays").text("");
			$("#num").text("");
			$("#price").text("");
	    	isCal = false;
	    });
	    
	    
	    $("#confirm").click(function() {
	    	if(!isCal) {
	    		alert("아직 계산되어진 것이 없습니다.");
	    		return false;
	    	}
	    	
	    	if(confirm("예약 완료하시겠습니까?")) {
	    		$("#doRev").submit();
	    	} else {
	    		return false;
	    	}
	    });
	    
	    
	})();
	
	
	
	

</script>
<jsp:include page="/resources/template/footer.jsp" />