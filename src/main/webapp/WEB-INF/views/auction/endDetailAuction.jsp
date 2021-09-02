<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/auction.css">
<style>
	.resultTable{
		width: 600px;
	}
	.thumText, .thumImage{
		margin: 0px auto;
		
	}
	.thumImage{
	margin-top : 30px;
	}

</style>

<div id="auctionBody">
	<h1>최근 종료된 경매입니다.</h1>
	<div class="realAuction-detail">
		<div>
			<div class="thumImage" id="thumImage" style="background-image:url(/ot/resources/img/projectimage/${dto.thumImage });"></div> 
			<br>
			<div class="thumText">
				<h4>${dto.name }</h4>
				상품 내용<br><div>${dto.content }</div>
				<input type="hidden" name="memberSeq" id="memberSeq" value="${mdto.memberSeq }">
			</div>
			<br>
			<table class="table resultTable">
				<tr>
					<th>진행 기간</th>
					<td>${dto.startTime } ~ ${dto.endTime }</td>
					<th>참여 인원</th>
					<td>${idto.totalCount }</td>
				</tr>
				<tr>
					<th>시작 금액</th>
					<td>${dto.startPrice }</td>
					<th>호가 단위</th>
					<td>${dto.unitPrice }</td>
				</tr>
				<tr>
					<th>낙찰자</th>
					<td>${nickName }</td>
					<th>낙찰금액</th>
					<td>${idto.finalPrice }</td>
				</tr>
			</table>
		</div>
	</div>
	<input type="button" class="btn btn-primary" value="목록으로" id="back" onclick="location.href='/ot/auction/endauction.action';">
</div>


<script src="/ot/resources/js/jquery-1.11.0.min.js"></script>
<script src="/ot/resources/js/jquery-migrate-1.2.1.min.js"></script>
<script src="/ot/resources/js/bootstrap.bundle.min.js"></script>
<script src="/ot/resources/js/templatemo.js"></script>
<script src="/ot/resources/js/custom.js"></script>

<!-- <script src="/ot/resources/js/auction.js"></script> -->

