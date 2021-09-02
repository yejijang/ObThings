<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="./../inc/banner.jsp"%>

<!-- 인기 프로젝트 -->
<section class="container py-5">
	<div class="row text-center pt-3">
		<div class="col-lg-6 m-auto">
			<h1 class="h1">인기 프로젝트</h1>
			<p>오브띵즈 오늘의 인기 프로젝트입니다.</p>
		</div>
	</div>

	<div class="row fundList otmain">
		<c:forEach items="${populList}" var="dto">
			<div class="col-12 col-md-3 mb-4 fundItem">
				<div class="card h-80" data-projectseq="${dto.projectSeq}">
					<div class="card-image">
						<img src="/ot/resources/img/projectimage/${dto.thumImage}" class="card-img-top"
							alt="projectImage_${dto.thumImage}">
					</div>
					<div class="card-body">
						<!-- 프로젝트 제목 길이에 따라 잘라서 출력 -->
						<div class="fundName">
							<c:if test="${fn:length(dto.name) > 15}">
								${fn:substring(dto.name, 0, 15)}..
							</c:if>
							<c:if test="${fn:length(dto.name) <= 15}">
								${dto.name}
							</c:if>
						</div>
						<div class="fundMember">${dto.teamName}/${dto.userName}</div>
						<div class="card-info">
							<!-- 프로젝트 펀딩받은 총 금액 유무에 따라 출력 -->
							<c:if test="${empty dto.totalPrice}">
								<div>0원</div>
								<div>0%</div>
							</c:if>
							<c:if test="${not empty dto.totalPrice}">
								<div>
									<fmt:formatNumber value="${dto.totalPrice}" type="number" />
									원
								</div>
								<c:if test="${dto.totalPrice / dto.target * 100 >= 100}">
									<div style="color: #59AB6E;">
										<fmt:formatNumber value="${dto.totalPrice / dto.target * 100}"
											pattern=".00" />
										%
									</div>
								</c:if>
								<c:if test="${dto.totalPrice / dto.target * 100 < 100}">
									<div>
										<fmt:formatNumber value="${dto.totalPrice / dto.target * 100}"
											pattern=".00" />
										%
									</div>
								</c:if>
							</c:if>
							<div>D - ${dto.meanTime}</div>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</section>
<!-- End 인기 프로젝트 -->

<!-- 성공임박 프로젝트 -->
<section class="container py-5">
	<div class="row text-center pt-3">
		<div class="col-lg-6 m-auto">
			<h1 class="h1">성공 임박 프로젝트</h1>
			<p>오브띵즈 오늘의 성공 임박 프로젝트입니다.</p>
		</div>
	</div>

	<div class="row fundList otmain">
		<c:forEach items="${succList}" var="dto">
			<div class="col-12 col-md-3 mb-4 fundItem">
				<div class="card h-80" data-projectseq="${dto.projectSeq}">
					<div class="card-image">
						<img src="/ot/resources/img/projectimage/${dto.thumImage}" class="card-img-top"
							alt="projectImage_${dto.thumImage}">
					</div>
					<div class="card-body">
						<!-- 프로젝트 제목 길이에 따라 잘라서 출력 -->
						<div class="fundName">
							<c:if test="${fn:length(dto.name) > 15}">
								${fn:substring(dto.name, 0, 15)}..
							</c:if>
							<c:if test="${fn:length(dto.name) <= 15}">
								${dto.name}
							</c:if>
						</div>
						<div class="fundMember">${dto.teamName}/${dto.userName}</div>
						<div class="card-info">
							<!-- 프로젝트 펀딩받은 총 금액 유무에 따라 출력 -->
							<c:if test="${empty dto.totalPrice}">
								<div>0원</div>
								<div>0%</div>
							</c:if>
							<c:if test="${not empty dto.totalPrice}">
								<div>
									<fmt:formatNumber value="${dto.totalPrice}" type="number" />
									원
								</div>
								<c:if test="${dto.totalPrice / dto.target * 100 >= 100}">
									<div style="color: #59AB6E;">
										<fmt:formatNumber value="${dto.totalPrice / dto.target * 100}"
											pattern=".00" />
										%
									</div>
								</c:if>
								<c:if test="${dto.totalPrice / dto.target * 100 < 100}">
									<div>
										<fmt:formatNumber value="${dto.totalPrice / dto.target * 100}"
											pattern=".00" />
										%
									</div>
								</c:if>
							</c:if>
							<div>D - ${dto.meanTime}</div>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</section>
<!-- End 성공임박 프로젝트 -->

<!-- 신규 프로젝트 -->
<section class="container py-5">
	<div class="row text-center pt-3">
		<div class="col-lg-6 m-auto">
			<h1 class="h1">신규 프로젝트</h1>
			<p>오브띵즈 오늘의 신규 프로젝트입니다.</p>
		</div>
	</div>

	<div class="row fundList otmain">
		<c:forEach items="${newList}" var="dto">
			<div class="col-12 col-md-3 mb-4 fundItem">
				<div class="card h-80" data-projectseq="${dto.projectSeq}">
					<div class="card-image">
						<img src="/ot/resources/img/projectimage/${dto.thumImage}" class="card-img-top"
							alt="projectImage_${dto.thumImage}">
					</div>
					<div class="card-body">
						<!-- 프로젝트 제목 길이에 따라 잘라서 출력 -->
						<div class="fundName">
							<c:if test="${fn:length(dto.name) > 15}">
								${fn:substring(dto.name, 0, 15)}..
							</c:if>
							<c:if test="${fn:length(dto.name) <= 15}">
								${dto.name}
							</c:if>
						</div>
						<div class="fundMember">${dto.teamName}/${dto.userName}</div>
						<div class="card-info">
							<!-- 프로젝트 펀딩받은 총 금액 유무에 따라 출력 -->
							<c:if test="${empty dto.totalPrice}">
								<div>0원</div>
								<div>0%</div>
							</c:if>
							<c:if test="${not empty dto.totalPrice}">
								<div>
									<fmt:formatNumber value="${dto.totalPrice}" type="number" />
									원
								</div>
								<c:if test="${dto.totalPrice / dto.target * 100 >= 100}">
									<div style="color: #59AB6E;">
										<fmt:formatNumber value="${dto.totalPrice / dto.target * 100}"
											pattern=".00" />
										%
									</div>
								</c:if>
								<c:if test="${dto.totalPrice / dto.target * 100 < 100}">
									<div>
										<fmt:formatNumber value="${dto.totalPrice / dto.target * 100}"
											pattern=".00" />
										%
									</div>
								</c:if>
							</c:if>
							<div>D - ${dto.meanTime}</div>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</section>
<!-- End 신규 프로젝트 -->

<!-- Start Featured Product -->
<!-- <section class="bg-light">
	<div class="container py-5">
		<div class="row text-center py-3">
			<div class="col-lg-6 m-auto">
				<h1 class="h1">Featured Product</h1>
				<p>Reprehenderit in voluptate velit esse cillum dolore eu fugiat
					nulla pariatur. Excepteur sint occaecat cupidatat non proident.</p>
			</div>
		</div>
		<div class="row"></div>
	</div>
</section> -->
<!-- End Featured Product -->

<script src="/ot/resources/js/jquery-1.11.0.min.js"></script>
<script src="/ot/resources/js/jquery-migrate-1.2.1.min.js"></script>
<script src="/ot/resources/js/bootstrap.bundle.min.js"></script>
<script src="/ot/resources/js/templatemo.js"></script>
<script src="/ot/resources/js/custom.js"></script>

<script>
	$('.card').click(function(){
		location.href = '/ot/funding/funding.action?projectseq=' + $(this).data('projectseq');
		/* alert($(this).data('projectseq')); */
	});
</script>