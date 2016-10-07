<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/resources/template/header.jsp"/>

<div class="jumbotron" style="margin-top: 25px;color:black;">
	<div class="container" style="text-align: center;">
		<h1>공지사항</h1>
	</div>
</div>
<style>
	td {
		border: 1px solid black;
	}
	
	input[type="checkbox"] {
		margin: 0;
		height:10px;
	}
	
	.title {
		font-size: 12px;
		color: #000;
	}
	
	.title:HOVER {
		color: blue;
		text-decoration: underline;
	}
	
	.pagination  a {
		color: black;
	}
	
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$('#write').click(function() {
			location.replace("<%=request.getContextPath()%>/notice/write");
			return false;
		});
		
		$('#delete').click(function() {
			var deleteList = [];
			$('.id[type=checkbox]').each(function() {
				if($(this).is(':checked')) {
					deleteList.push($(this).val());
				}
			});
			
			if(deleteList.length != 0) {
				$.ajax({
					type: 'POST',
					url: 'notice/remove',
					data: {list: deleteList},
					success: function() {
						location.reload();
					}
				});
			}
			return false;
		});
	});


</script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/notice/notice.css" />
<div class="container">
	<div class="table-responsive" style="min-height: 500px;">
		<table class="table table-condensed" style="text-align: center;border-top:1px solid black;font-size:12px;">
			<thead>
				<tr>
					<td style="width:10%">글번호
					</td>
					<td style="width:60%">공지제목</td>
					<td style="width:10%">조회수</td>
					<td style="width:10%">등록일</td>
					<td style="width:10%">작성자</td>
				</tr>
			</thead>
			<c:forEach items="${noticeDto.noticeList }" var="record">
				<tr>
					<td>${record.id }
						<c:if test="${isADMIN }">
							<input type="checkbox"  value="${record.id }" name="id" class="id"/>
						</c:if></td>
					<td><a href="<%=request.getContextPath()%>/notice/read/${record.id }" class="title">${record.title }</a></td>
					<td>${record.readCount }</td>
					<td>${record.formattingRegDate }</td>
					<td>${record.writer }</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div class="row" style="text-align: center;">
	<ul class="pagination pagination-sm">
		<c:if test="${noticeDto.prev }">
			<li><a href="${pageContext.request.contextPath }/notice?page=${noticeDto.startPage - 1}">&laquo;</a></li>
		</c:if>
		<c:if test="${!noticeDto.prev }">
			<li class="disabled"><a href="#">&laquo;</a></li>
		</c:if>
		
		<c:forEach begin="${noticeDto.startPage }" end="${noticeDto.endPage }" step="1" var="i">
			<c:choose>
				<c:when test="${noticeDto.currentPage == i }">
					<li class="active"><a href="${pageContext.request.contextPath }/notice?page=${noticeDto.currentPage}">${i }</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="${pageContext.request.contextPath }/notice?page=${i}">${i }</a></li>
				</c:otherwise>
			</c:choose>
		
		</c:forEach>
		
		
		<c:if test="${noticeDto.next }">
			<li><a href="${pageContext.request.contextPath }/notice?page=${noticeDto.endPage + 1}">&raquo;</a></li>
		</c:if>
		<c:if test="${!noticeDto.next }">
			<li class="disabled"><a href="#">&raquo;</a></li>
		</c:if>
	</ul>
	</div>
	
	<c:if test="${isADMIN }">
		<div style="text-align: right;">
			<button style="border:1px solid black;padding:3px 10px;margin:0;" id="write">글쓰기</button>
			<button style="border:1px solid black;padding:3px 10px;margin:0;" id="delete">글삭제</button>
		</div>
	</c:if>
	
</div>

<jsp:include page="/resources/template/footer.jsp" />