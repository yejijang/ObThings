<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="./../inc/banner.jsp"%>

<div id="categoryListArea">
	<div id="categoryList">
		<div id="categoryPack">
			<span class="category"
				onclick="location.href='/ot/funding/fundmain.action';">전체보기</span>
			<c:forEach items="${categoryList}" var="dto" end="5">
				<span class="category"
					onclick="location.href='/ot/funding/fundmain.action?categoryseq=${dto.categorySeq}';">${dto.name}</span>
			</c:forEach>
			<span class="next" id="next1">&#62;</span>
			<br>
			<span class="prev" id="prev1">&#60;</span>
			<c:forEach items="${categoryList}" var="dto" begin="6" end="12">
				<span class="category"
					onclick="location.href='/ot/funding/fundmain.action?categoryseq=${dto.categorySeq}';">${dto.name}</span>
			</c:forEach>
			<span class="next" id="next2">&#62;</span>
			<br>
			<span style="margin-left: -387px;">
				<span class="prev" id="prev2">&#60;</span>
				<c:forEach items="${categoryList}" var="dto" begin="13">
					<span class="category"
						onclick="location.href='/ot/funding/fundmain.action?categoryseq=${dto.categorySeq}';">${dto.name}</span>
				</c:forEach>
			</span>
		</div>
	</div>
</div>

<c:if test="${empty categoryseq}">
	<!-- 인기 프로젝트 -->
	<section class="container py-5">
		<div class="row text-center pt-3">
			<div class="col-lg-6 m-auto">
				<h1 class="h1">인기 프로젝트</h1>
				<p>오브띵즈 오늘의 인기 프로젝트입니다.</p>
			</div>
		</div>

		<div class="row fundList">
			<c:forEach items="${populList}" var="dto">
				<div class="col-12 col-md-3 mb-4 fundItem">
					<div class="card h-80" data-projectseq="${dto.projectSeq}">
						<div class="card-image">
							<img src="/ot/resources/img/${dto.thumImage}"
								class="card-img-top" alt="projectImage_${dto.thumImage}">
						</div>
						<div class="card-body">
							<!-- 프로젝트 제목 길이에 따라 잘라서 출력 -->
							<div class="fundName">
								<c:if test="${fn:length(dto.name) > 20}">
								${fn:substring(dto.name, 0, 20)}..
							</c:if>
								<c:if test="${fn:length(dto.name) <= 20}">
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
											<fmt:formatNumber
												value="${dto.totalPrice / dto.target * 100}" pattern=".00" />
											%
										</div>
									</c:if>
									<c:if test="${dto.totalPrice / dto.target * 100 < 100}">
										<div>
											<fmt:formatNumber
												value="${dto.totalPrice / dto.target * 100}" pattern=".00" />
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

		<div class="row fundList">
			<c:forEach items="${succList}" var="dto">
				<div class="col-12 col-md-3 mb-4 fundItem">
					<div class="card h-80" data-projectseq="${dto.projectSeq}">
						<div class="card-image">
							<img src="/ot/resources/img/${dto.thumImage}"
								class="card-img-top" alt="projectImage_${dto.thumImage}">
						</div>
						<div class="card-body">
							<!-- 프로젝트 제목 길이에 따라 잘라서 출력 -->
							<div class="fundName">
								<c:if test="${fn:length(dto.name) > 20}">
								${fn:substring(dto.name, 0, 20)}..
							</c:if>
								<c:if test="${fn:length(dto.name) <= 20}">
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
											<fmt:formatNumber
												value="${dto.totalPrice / dto.target * 100}" pattern=".00" />
											%
										</div>
									</c:if>
									<c:if test="${dto.totalPrice / dto.target * 100 < 100}">
										<div>
											<fmt:formatNumber
												value="${dto.totalPrice / dto.target * 100}" pattern=".00" />
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

		<div class="row fundList">
			<c:forEach items="${newList}" var="dto">
				<div class="col-12 col-md-3 mb-4 fundItem">
					<div class="card h-80" data-projectseq="${dto.projectSeq}">
						<div class="card-image">
							<img src="/ot/resources/img/${dto.thumImage}"
								class="card-img-top" alt="projectImage_${dto.thumImage}">
						</div>
						<div class="card-body">
							<!-- 프로젝트 제목 길이에 따라 잘라서 출력 -->
							<div class="fundName">
								<c:if test="${fn:length(dto.name) > 20}">
								${fn:substring(dto.name, 0, 20)}..
							</c:if>
								<c:if test="${fn:length(dto.name) <= 20}">
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
											<fmt:formatNumber
												value="${dto.totalPrice / dto.target * 100}" pattern=".00" />
											%
										</div>
									</c:if>
									<c:if test="${dto.totalPrice / dto.target * 100 < 100}">
										<div>
											<fmt:formatNumber
												value="${dto.totalPrice / dto.target * 100}" pattern=".00" />
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
</c:if>

<c:if test="${not empty categoryseq}">
	<!-- 카테고리 해당 프로젝트 -->
	<section class="container py-5">
		<div class="row text-center pt-3">
			<div class="col-lg-6 m-auto">
				<h1 class="h1">${categoryName}프로젝트</h1>
				<p>오브띵즈 ${categoryName} 프로젝트입니다.</p>
			</div>
		</div>

		<div class="row fundList">
			<c:forEach items="${projectList}" var="dto">
				<div class="col-12 col-md-3 mb-4 fundItem">
					<div class="card h-80" data-projectseq="${dto.projectSeq}">
						<div class="card-image">
							<img src="/ot/resources/img/${dto.thumImage}"
								class="card-img-top" alt="projectImage_${dto.thumImage}">
						</div>
						<div class="card-body">
							<!-- 프로젝트 제목 길이에 따라 잘라서 출력 -->
							<div class="fundName">
								<c:if test="${fn:length(dto.name) > 20}">
								${fn:substring(dto.name, 0, 20)}..
							</c:if>
								<c:if test="${fn:length(dto.name) <= 20}">
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
											<fmt:formatNumber
												value="${dto.totalPrice / dto.target * 100}" pattern=".00" />
											%
										</div>
									</c:if>
									<c:if test="${dto.totalPrice / dto.target * 100 < 100}">
										<div>
											<fmt:formatNumber
												value="${dto.totalPrice / dto.target * 100}" pattern=".00" />
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
	<!-- END 카테고리 해당 프로젝트 -->
</c:if>

<script>
	$('.card').click(function(){
		location.href = '/ot/funding/funding.action?projectseq=' + $(this).data('projectseq');
	});
	
	$('#next1').click(function() {
		$('#categoryPack').css({'transform':'translateY(-28px)'});
	});
	
	$('#next2').click(function() {
		$('#categoryPack').css({'transform':'translateY(-56px)'});
	});
	
	$('#prev1').click(function() {
		$('#categoryPack').css({'transform':'translateY(0px)'});
	});
	
	$('#prev2').click(function() {
		$('#categoryPack').css({'transform':'translateY(-28px)'});
	});

</script>