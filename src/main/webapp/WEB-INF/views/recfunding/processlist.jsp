<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

  <!-- Start Content -->
<div class="container py-5">
	<div class="row">

		<%@ include file="/WEB-INF/views/inc/rectemplate.jsp"%>
		<div class="col">
			<div class="row">
				<h1>진행상황 발송내역</h1>
				 	<span class="col"><small>총 ${proclist.size()}건의 내역이 있습니다.</small></span>
					<button type="button" 
							class="col-lg-2 btn btn-primary" style="margin-bottom:15px;"
							onclick="location.href='/ot/recfunding/write.action?projectSeq=${projectSeq}'">진행상황 발송하기</button>
				 	
				<table class="table table-hover">
					<thead class="table-dark text-center">
						
						<tr>
							<th class="col-lg-1">번호</th>
							<th class="col-lg-4">내용</th>
							<th class="col-lg-1">날짜</th>
						</tr>
					</thead>
					<tbody>
						
					<c:forEach items="${proclist}" var="pdto" varStatus="status">
						
						<tr>
								<td class="text-center"><c:out value="${proclist.size() - status.count + 1}" /></td>
								<td>${pdto.title}</td>
								<td class="text-center">${pdto.regDate}</td>
						</tr>
						
					</c:forEach>
						
					</tbody>
				</table>

			</div>
		</div>

	</div>
</div>
<!-- End Content -->