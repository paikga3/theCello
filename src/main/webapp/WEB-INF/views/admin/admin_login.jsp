<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>관리자 인증 페이지</title>

<link rel='stylesheet' id='miami_bootstrap_css-css'
	href='<%=request.getContextPath() %>/resources/lib/bootstrap/css/bootstrap.min.css' />
<script src='<%=request.getContextPath() %>/resources/lib/jQuery/jquery-2.2.3.js'></script>
<script src='<%=request.getContextPath() %>/resources/lib/bootstrap/js/bootstrap.min.js'></script>
<link rel="stylesheet"  href="<%=request.getContextPath() %>/resources/css/template/header.css" />
<link rel="shortcut icon" href="<%=request.getContextPath() %>/resources/imgs/asset/favicon.ico"/>
<script type="text/javascript">
	$(document).ready(function() {
		$('#admin_id').focus();
	});
</script>
<body>
	
	<c:if test="${!isADMIN}">
		<div>관리자 로그인</div>
		<form action="admin" method="post">
			<div style="margin: auto; width: 300px; height: 90px; position: absolute; left: 0; right: 0; top: 0; bottom: 0; border: 1px solid blue;">
				<div>
					<label style="width: 100px;">아이디</label> 
					<input type="text" style="width: 190px;" name="username" id="admin_id"/>
				</div>
				<div>
					<label style="width: 100px;">패스워드</label> 
					<input type="password" style="width: 190px;" name="password">
				</div>
				<div style="text-align: center;">
					<input type="submit" value="관리자로 접속하기" />
				</div>
				<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
			</div>
		</form>
	</c:if>
	<c:if test="${isADMIN}">
		<div>관리자 로그아웃</div>
		<form action="logout" method="post">
			<input type="submit" value="로그아웃" />
		</form>
	</c:if>
	
</body>
</html>