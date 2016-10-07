<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>예약목록</title>
</head>
<body>
	<div id="list">
		<div style="margin-bottom:10px;">예약목록리스트</div>
		<c:forEach items="${list }" var="item">
			<a href="<%=request.getContextPath()%>/admin/revDetail?id=${item.id }" style="display: block;" class="item">${item.id }</a>
		</c:forEach>
	</div>
	
</body>
</html>