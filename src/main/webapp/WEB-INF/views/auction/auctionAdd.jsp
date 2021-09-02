<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/auction.css">
<style>
	.auctionAddBtn-box{
		margin: 0px auto;
		margin-bottom: 20px;
		text-align: center;
	}
</style>

<h1>경매 품목 등록</h1>
<div id="auctionAddBody">
	<form method="POST" action="/ot/auction/auctionAddOk.action" enctype="multipart/form-data" class="addAuction">
		<div class="auctionAdd-box">
			<h4>경매 품목명</h4>
			<input name="name" type="text" placeholder="내용을 입력해주세요." class="form-control">
			
			<h4>경매 썸네일</h4>
			<input name="uploadFile" type="file" value="파일 등록" accept=".gif,.jpg,.png">
			
			<h4>경매 프로젝트 공개 일시 설정</h4>
			<input name="startTime" id = "startTime" type="date"  class="form-control startDate" class="form-control">
			
			<h4>경매 시작가격 설정 <span style="font-size:15px;">단위 : 원</span></h4>
			<input name="startPrice" type="number" min="10000" max="1000000" step="1000" value="10000" class="form-control">
			
			<h4>경매 호가단위 설정 <span style="font-size:15px;">단위 : 원</span></h4>
			<input name="unitPrice" type="number" min="1000" max="1000000" step="1000" value="1000" class="form-control">
			
			<h4>경매 품목 내용</h4>
			<textarea name="content" class="auctionAddContent form-control" placeholder="내용을 입력해주세요." ></textarea>
			<input name="uploadFile" type="file" value="파일 등록" accept=".gif,.jpg,.png">
			<!-- <input type="button" value="이미지 추가하기" class="btn btn-default" id="btnAdd"> -->
			<br>
		</div>
		<div class="auctionAddBtn-box">
			<input type="submit" class="btn btn-primary" value="등록하기">
			<input type="button" class="btn btn-danger" value="목록으로" onclick="location.href='/ot/auction/auction.action';">
		</div>
	</form>
</div>

<script src="/ot/resources/js/jquery-1.11.0.min.js"></script>
<script src="/ot/resources/js/jquery-migrate-1.2.1.min.js"></script>
<script src="/ot/resources/js/bootstrap.bundle.min.js"></script>
<script src="/ot/resources/js/templatemo.js"></script>
<script src="/ot/resources/js/custom.js"></script>

<script>

$("#btnAdd").click(function(){
	$(".auctionAdd-box").append("<input name=\"uploadFile\" type=\"file\" value=\"파일 등록\" accept=\".gif,.jpg,.png\">");
});

$("#startTime").change(function(){
	$.ajax({
		type: 'POST',
		url: '/ot/auction/dateComfirm.action',
		data: 'startTime=' + $('#startTime').val(),
		dataType:'json',
		success:function(result){
			console.log($('#startTime').val());
			console.log(result);
			if(result){
				alert("이미 경매가 있습니다. 다른 날 선택해주세요.");
				$('#startTime').val("");
			}
		},
		error: function(a,b,c) {
			console.log(a,b,c);
		}
	});
});

</script>