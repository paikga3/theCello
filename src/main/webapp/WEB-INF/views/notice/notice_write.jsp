<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/resources/template/header.jsp"/>

<style>
	input {
		margin:0;
		height: 20px;
	}
</style>

<div class="container" style="margin-top:40px;">
<form action="<%=request.getContextPath() %>/notice/add" method="post" id="form">
	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-md-1">
			<span>글제목</span>
		</div>
		<div class="col-md-5">
			<input type="text" style="width:100%" name="title"/>
		</div>
		<div class="col-md-3"></div>
	</div>
	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-md-1">
			<span>글내용</span>
		</div>
		
		<div class="col-md-8"></div>
	</div>
	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-md-6">
			<textarea style="width:100%;" rows="30" name="content" id="content"></textarea>
		</div>
		<div class="col-md-3"></div>
	</div>
	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-md-6" style="text-align: right;">
			<button style="border:1px solid black;padding:3px 10px;margin:0;" id="register">등록</button>
			<button style="border:1px solid black;padding:3px 10px;margin:0;" id="cancel">취소</button>
		</div>
		<div class="col-md-3"></div>
	</div>
</form>
</div>

<script type="text/javascript">

$(document).ready(function() {
	$('#content').val('');
	
	$('#register').click(function() {
		$('#form').submit();
		return false;
	});
	
	$('#cancel').click(function() {
		location.replace("<%=request.getContextPath()%>/notice");
		return false;
	});
	
});


</script>


<jsp:include page="/resources/template/footer.jsp" />