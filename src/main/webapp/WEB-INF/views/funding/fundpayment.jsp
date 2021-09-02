<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div id="fundPayment">
	<div id="payProject">
		<table class="table payProjectTable">
			<tr>
				<td rowspan="3"><img
					src="/ot/resources/img/projectimage/${project.thumImage}"
					alt="projectImage_${project.thumImage}"></td>
				<td>${project.categoryName}|<c:if
						test="${not empty project.teamName}">
						${project.teamName}(${project.userName})
					</c:if> <c:if test="${empty project.teamName}">
						${project.userName}
					</c:if>
				</td>
			</tr>
			<tr>
				<td id="projectTitle">${project.name}</td>
			</tr>
			<tr>
				<td><c:if test="${empty totalPrice}">
						<span>0원</span>
						<span>0%</span>
					</c:if> <c:if test="${not empty totalPrice}">
						<span> <fmt:formatNumber value="${totalPrice}"
								type="number" /> 원
						</span>
						<span> <fmt:formatNumber
								value="${totalPrice / project.target * 100}" pattern=".00" /> %
						</span>
					</c:if> <span>${project.meanTime}일 남음</span></td>
			</tr>
		</table>
	</div>

	<div id="payContentSection">
		<div id="payContent">
			<div id="packInfo" class="payContentInfo">
				<h4>패키지 정보</h4>
				<table class="table">
					<tr>
						<td>구성</td>
						<td>${projectPack.name}</td>
					</tr>
					<tr>
						<td></td>
						<td>◾ ${projectPack.content}</td>
					</tr>
					<tr>
						<td>금액</td>
						<td><fmt:formatNumber value="${projectPack.price}"
								type="number" />원</td>
					</tr>
					<tr>
						<td>예상 전달일</td>
						<td>${fn:substring(project.endDate,0,10)}</td>
					</tr>
				</table>
			</div>
			<div id="memberInfo" class="payContentInfo">
				<h4>후원자 정보</h4>
				<table class="table">
					<tr>
						<td>이름</td>
						<td>${member.name}</td>
					</tr>
					<tr>
						<td>연락처</td>
						<td>${member.phone}</td>
					</tr>
					<tr>
						<td>이메일</td>
						<td>${member.email}</td>
					</tr>
					<tr>
						<td>주소</td>
						<td>${member.address}</td>
					</tr>
					<tr>
						<td colspan="2">* 개인 정보 변경은 설정 > 계정 설정에서 가능합니다.</td>
					</tr>
				</table>
			</div>
		</div>
		<div id="payPriceInfo">
			<div id="payPrice">
				<table class="table payPrice">
					<tr>
						<td>프로젝트 패키지 금액</td>
						<td><fmt:formatNumber value="${projectPack.price}"
								type="number" /> 원</td>
					</tr>
					<tr>
						<td>배송비</td>
						<td><fmt:formatNumber value="3000" type="number" /> 원</td>
					</tr>
					<tr>
						<td>최종 후원 금액</td>
						<c:set var="payPrice" value="${projectPack.price + 3000}" />
						<td><fmt:formatNumber value="${payPrice}" type="number" /> 원</td>
					</tr>
				</table>
			</div>
			<button type="button" class="btn btn-default paybtn"
				onclick="requestPay()">후원하기</button>
		</div>
	</div>

</div>

<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>

<script>
	var IMP = window.IMP;
	IMP.init("imp30468146");
	
	function requestPay() {
		
		IMP.request_pay({ // param
			pg: "kakaopay",
          	pay_method: "card",
          	merchant_uid: "obthings_" + new Date().getTime(),
          	name: "ObThings 펀딩 후원 결제",
          	amount: ${payPrice},
          	buyer_email: "${member.email}",
          	buyer_name: "${member.name}",
          	buyer_tel: "${member.phone}",
          	buyer_addr: "${member.address}",
          	buyer_postcode: "06235"
		}, function (rsp) { // callback
			
			// 결제검증
			$.ajax({
				type : "POST",
	        	url : "/ot/funding/verifyIamport.action",
	        	data: {
	        		imp_uid: rsp.imp_uid
                }
			}).done(function(data) {
				
				// PG사 결과값과 아임포트 결과값이 동일한 경우 > 결제 진행
				if (rsp.paid_amount == data.response.amount){
					// 결제 성공 시 로직,
					$.ajax({
						url: "/ot/funding/paycomplete.action",
	                    type: 'POST',
	                    dataType: 'json',
	                    data: {
	                        packageSeq : ${projectPack.packageSeq},
	                        memberSeq : ${member.memberSeq}
	                    }
					});
	              
				//성공시 이동할 페이지
				alert("결제가 완료되었습니다. :)");
				location.href='/ot/funding/funding.action?projectseq=' + ${project.projectSeq};
				
				} else {
					// 결제 실패 시 로직,
					alert("결제에 실패하였습니다. 에러 내용: " +  rsp.error_msg);
				}
			});
		});
	}
</script>