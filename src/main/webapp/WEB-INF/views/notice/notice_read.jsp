<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/resources/template/header.jsp"/>
<div class="jumbotron" style="margin-top: 25px;color:black;">
	<div class="container" style="text-align: center;">
		<h1>공지사항</h1>
	</div>
</div>

<div class="container">
	<div style="text-align: right;" class="row">
		<c:if test="${isADMIN }">
			<button style="border:1px solid black;padding:3px 10px;margin:0;" id="modify">수정하러가기</button>
		</c:if>
		<button style="border:1px solid black;padding:3px 10px;margin:0;" id="list">목록으로 돌아가기</button>
	</div>
	<div class="row" style="border:1px solid blue;padding:20px;margin-top:10px;">
		<div class="col-md-12" style="padding:0px;">${record.formattingRegDate }</div>
		<div class="col-md-12" style="padding:0px;">${record.title }</div>
		<div class="col-md-12" style="padding:0px;">${record.writer }</div>
		<div class="col-md-12" style="padding:0px;">조회수 : ${record.readCount }</div>
	</div>
	<div class="row" style="min-height: 500px;border:1px solid blue;padding:20px;margin-top:10px;overflow-y:scroll;">
		<pre>${record.content }</pre>
		
	</div>
</div>

<script type="text/javascript">

$('#list').click(function() {
	location.replace("<%=request.getContextPath()%>/notice?page=${noticeDto.currentPage}");
	return false;
});

$('#modify').click(function() {
	location.replace("<%=request.getContextPath()%>/notice/modify/${record.id}");
	return false;
});
</script>
<jsp:include page="/resources/template/footer.jsp" />