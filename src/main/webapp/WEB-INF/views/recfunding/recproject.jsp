<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- Start Content -->
<div class="container py-5">
	<div class="row">
		<%@ include file="/WEB-INF/views/inc/rectemplate.jsp"%>
		<div id="projectContent" style="width: 60%;">
			<div id="projectContentLeft">
				<div><h3>${project.name }</h3></div>
				<div style="margin: 30px 10px;"><img src="/ot/resources/img/projectimage/${project.thumImage }"
									alt="contentImage_${project.thumImage }"></div>
				<div id="main">
					<input type="radio" id="content" name="rb" checked> <label
						for="content">상세 설명</label> <input type="radio" id="notice"
						name="rb"> <label for="notice">공지사항</label> <input
						type="radio" id="qa" name="rb"> 
					<div style="clear: both;"></div>

					<div id="contentinfo">
						<div id="projectDetail">${project.detail}</div>
						<div id="projectImage">
							<c:forEach items="${projectImageList}" var="contentImg">
								<img src="/ot/resources/img/projectimage/${contentImg}"
									alt="contentImage_${contentImg}">
							</c:forEach>
						</div>
						<div id="projectContent">${project.content}</div>
					</div>

					<div id="noticeinfo">
						<div id="Accordion_wrap">
							<c:if test="${empty noticeList}">
								<div class="sub">
									<span>공지사항이 존재하지 않습니다.</span>
								</div>
							</c:if>
							<c:if test="${not empty noticeList}">
								<c:forEach items="${noticeList}" var="dto">
									<div class="sub">
										<span>${dto.subject}</span> <span style="font-size: 12px;">[${fn:substring(dto.regdate,0,10)}]</span>
									</div>
									<div class="con">
										<span>${dto.content}</span>
									</div>
								</c:forEach>
							</c:if>
						</div>
					</div>

					<div id="qainfo">
						<form method="POST" action="/ot/funding/sendqa.action"
							name="qaform" onsubmit="return qacheck()">

							<textarea name="content" id="qatext" class="form-control"
								placeholder="창작자에게 문의할 내역을 입력해 주세요."></textarea>

							<input type="hidden" name="sMemberSeq" value="${memberSeq}">
							<!-- 보낸사람: 문의사항 작성자 시퀀스 -->
							<input type="hidden" name="rMemberSeq"
								value="${project.memberSeq}">
							<!-- 받는사람: 프로젝트 창작자 시퀀스 -->
							<input type="hidden" name="projectSeq"
								value="${project.projectSeq}">
							<!-- 프로젝트 시퀀스 -->

							<button type="submit" class="form-control">문의하기</button>

						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- End Content -->

