<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

  <!-- Start Content -->
<div class="container py-5">
	<div class="row">

		<%@ include file="/WEB-INF/views/inc/rectemplate.jsp"%>
		<div class="col">
			<div class="row">
				<h1>공지사항 관리하기</h1>
				 	<span class="col"><small>총 ${noticelist.size()}건의 내역이 있습니다.</small></span>
					<button type="button" 
							class="col-lg-2 btn btn-primary" style="margin-bottom:15px;"
							onclick="location.href='/ot/recfunding/noticeadd.action?projectSeq=${projectSeq}'">공지사항 작성하기</button>
				 	
				<table class="table table-hover">
					<thead class="table-dark text-center">
						
						<tr>
							<th class="col-lg-1">번호</th>
							<th class="col-lg-4">내용</th>
							<th class="col-lg-1">날짜</th>
						</tr>
					</thead>
					<tbody>
						
					
						
						<c:forEach items="${noticelist}" var="noticedto" varStatus="status">
						
						<tr>
								<td class="text-center"><c:out value="${noticelist.size() - status.count + 1}" /></td>
								<td  data-bs-toggle="modal" data-bs-target="#modal${noticedto.noticeSeq}" style="cursor:pointer;">${noticedto.subject}</td>
								<td class="text-center">${noticedto.regdate}</td>
						</tr>
						
							<!-- Modal -->
							<div class="modal fade" id="modal${noticedto.noticeSeq }" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
							  <div class="modal-dialog modal-dialog-centered">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h5 class="modal-title" id="exampleModalLabel">${noticedto.subject}</h5>
							        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							      </div>
							      <div class="modal-body">
							        ${noticedto.content}
							      </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">수정하기</button>
							        <button type="button" class="btn btn-danger">삭제하기</button>
							      </div>
							    </div>
							  </div>
							</div>
						</c:forEach>
						
					
						
					</tbody>
				</table>

			</div>
		</div>

	</div>
</div>
<!-- End Content -->