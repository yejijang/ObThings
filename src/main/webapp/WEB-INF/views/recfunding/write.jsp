<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

  <!-- Start Content -->
<div class="container py-5">
	<div class="row">

		<%@ include file="/WEB-INF/views/inc/rectemplate.jsp"%>
		<div class="col">
			<div class="row">
				<h1>진행상황 발송하기</h1>
				<form method="post" action="/ot/recfunding/send.action"> 
				<!-- post방식으로 자료를 컨트롤러로 보냄 -->
				 <div class="form-group row" style="margin: 10px 0 10px 0;">
				    <label for="inputEmail" class="col-sm-2 col-form-label">받는사람 이메일</label>
				    <div class="col-sm-4">
				      <input type="text" name="receiveMail" class="form-control" id="inputEmail" placeholder="Email" required>
				    </div>
				  </div>
				  
				  <div class="form-group row" style="margin: 10px 0 10px 0;">
				    <label for="title" class="col-sm-2 col-form-label">글제목</label>
				    <div class="col-sm-10">
				      <input type="text" name="subject" class="form-control" id="title" placeholder="글제목을 입력하세요" required>
				    </div>
				  </div>
				 
					
				
					<div style="margin: 10px 0 10px 0;">				
					<textarea rows="16" cols="90" name="message" class="form-control" placeholder="글내용을 입력해주세요" style="resize: none;" required></textarea>
					</div>
					
					<input type="hidden" name="senderName" value="${name}">
					<input type="hidden" name="senderMail" value="teamwebproject1111@gmail.com">
					
					<div class="row justify-content-between">
						<button class="btn btn-secondary col-sm-2" onclick="location.href='/ot/recfunding/processlist.action?projectSeq=${projectSeq}&memberSeq=${memberSeq}';">뒤로가기</button>
						<input type="submit" class="btn btn-primary col-sm-2" value="전송하기">
					</div>
				</form>
				<span style="color:red;">${message}</span>
				 		 	
				
			</div>
		</div>

	</div>
</div>
<!-- End Content -->