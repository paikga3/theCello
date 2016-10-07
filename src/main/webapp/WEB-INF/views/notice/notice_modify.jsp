<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/resources/template/header.jsp"/>

<c:if test="${!isADMIN }">
	<c:redirect url="${pageContext.request.contextPath }/notice"/>
</c:if>

<div class="container" style="margin-top:40px;">
	<div style="text-align: right;" class="row">
		<button style="border:1px solid black;padding:3px 10px;margin:0;" id="back" data-back="${pageContext.request.contextPath}/notice/read/${record.id}?read=true">다시 글로 가기</button>
		<button style="border:1px solid black;padding:3px 10px;margin:0;" id="complete">수정완료하기</button>
	</div>
	<div class="row" style="border:1px solid blue;padding:20px;margin-top:10px;">
		<div class="col-md-12" style="padding:0px;">${record.formattingRegDate }</div>
		<div class="col-md-12" style="padding:0px;">${record.title }</div>
		<div class="col-md-12" style="padding:0px;">${record.writer }</div>
		<div class="col-md-12" style="padding:0px;">조회수 : ${record.readCount }</div>
	</div>
	<div class="row" style="min-height: 500px;border:1px solid blue;padding:20px;margin-top:10px;overflow-y:scroll;">
		<textarea style="width:100%;min-height: 460px;" id="content" data-id="${record.id }" ></textarea>
	</div>
	<textarea id="hiddenContent" style="display: none;">${record.content }</textarea>
</div>

<script type="text/javascript">
$(document).ready(function() {
	$('#content').val($('#hiddenContent').val());
	
	
	$('#back').click(function() {
		var back = $(this).data('back');
		location.replace(back);
		return false;
	});
	
	$('#complete').click(function() {
		$.ajax({
			type: 'POST',
			data: {id:$('#content').data('id'), content: $('#content').val()},
			url: 'complete',
			success: function() {
				var back = $('#back').data('back');
				location.replace(back);
			}
		});
		return false;
	});
});

</script>
<jsp:include page="/resources/template/footer.jsp" />