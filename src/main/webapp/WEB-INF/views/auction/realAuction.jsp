<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/auction.css">
<div id="auctionBody">
	<h1>실시간경매장 입니다.</h1>
	<div class="realAuction-detail">
		<div>
			<div class="thumImage" id="thumImage" style="background-image:url(/ot/resources/img/projectimage/${dto.thumImage });"></div> 
			
			<div class="thumText">
				<h4>${dto.name }</h4>
				<ul>
					<li style="display:flex;">
						<h5>시작 시간</h5>&nbsp;:&nbsp;<div>${dto.startTime }</div>
					</li>
					<li style="display:flex;">
						<h5>종료 시간</h5>&nbsp;:&nbsp;<div id="endTime">${dto.endTime }</div>
					</li>
					<li style="display:flex;">
						<h5>시작 가격</h5>&nbsp;:&nbsp;<div>${dto.startPrice }원</div>
					</li>
					<li>
						<h5>상품 내용</h5><div>${dto.content }</div>
					</li>
					<li>
						<input type="hidden" name="memberSeq" id="memberSeq" value="${mdto.memberSeq }">
					</li>
				</ul>
			</div>
		</div>
		<div>
			<table class="table table-bordered" id="auctionChat">
				<tr>
					<td>
						<input type="text" name="user" id="user" class="form-control" value="${mdto.nickName}" readonly>
						<button type="button" class="btn btn-primary" id="btnConnect">참가하기</button>
						<button type="button" class="btn btn-danger" id="btnDisConnect" disabled>나가기</button>
						<br>
						입찰가 : <span id="presentPrice">${biddingPrice}</span>
					</td>
					<!-- <td>
						<div id="btn-box">
							
						</div>
					</td> -->
				</tr>
				<tr>
					<td colspan="2">
						<div id="auctionChatList"></div>
					</td>
				</tr>
				<!-- <tr>
					<td colspan="2"><input type="text" name="msg" id="msg"
						placeholder="대화 내용을 입력하세요." class="form-control" disabled></td>
				</tr> -->
			</table>

			<!-- <form method="POST" action="/ot/auction/bidding.action" id="bidding"> -->
				<div id="unitPrice-box">단위 :<span id="unitPrice"> ${dto.unitPrice } </span>원</div>
				<div class="unitPrice-box">
					<input id="biddingPrice" name="biddingPrice" type="text" class="form-control" value="${biddingPrice}"
						readonly> <input id="bid" name="bid" type="button" class="btn btn-primary"
						value="입찰하기" disabled>
					<input id="auctionSeq" name="auctionSeq" type="hidden" value="${dto.auctionSeq}">
				</div>
			<!-- </form> -->
		</div>
	</div>
	<input type="button" class="btn btn-primary" value="목록으로" id="back" onclick="location.href='/ot/auction/auction.action';">
</div>
<script>
	
	let url = "ws://localhost:8090/ot/otauctionchatserver"
	let ws;
	
	console.log("${pageContext.request.contextPath }/resources/img/${dto.thumImage }");
	
	$("#btnConnect").click(function() {
		
		if($('#user').val().trim() != '') {
			console.log("start");
			url = "ws://localhost:8090/ot/otauctionchatserver"
			ws = new WebSocket(url);
			
			ws.onopen = function(evt) {
				
				print('[',']',$('#user').val(), '입장했습니다.');
				
				ws.send('1#' + $('#user').val()+'#');
	
				$('#user').attr('readonly', true);
				$('#btnConnect').attr('disabled', true);
				$('#btnDisConnect').attr('disabled', false);
				$('#bid').attr('disabled', false);
				
			};
			
			ws.onmessage = function(evt){
				
				/* console.log(evt); */
				let index = evt.data.indexOf("#",2);
				let no = evt.data.substring(0,1);
				let user = evt.data.substring(2,index);
				let txt = evt.data.substring(index + 1);
				
				if(no == '1'){
					print('[',']',user,'이(가) 접속했습니다.');
				} else if(no=='2'){
					var newBiddingPrice = parseInt($('#biddingPrice').val()) + parseInt($('#unitPrice').text());
					print("'","'",user,txt);
					$('#presentPrice').text(parseInt($('#biddingPrice').val()));
					$('#biddingPrice').val(newBiddingPrice); 
				} else if(no=='3'){
					print("'","'",user,'이(가) 나갔습니다.');
				}
				
				$('#auctionChatList').scrollTop($('#auctionChatList').prop('scrollHeight'));
				
			}
			
			ws.onclose = function(evt) {
		    	console.log(evt);
				console.log('소켓이 닫힙니다.');
			};
	
			ws.onerror = function(evt) {
				console.log(evt.data);
			};
		}

	});
	
	
	
	/* $('#msg').keyup(function(){
		if(event.keyCode == 13){
			
			//서버에게 메시지 전달
			//2#유저명#메시지
			ws.send('2#' + $('#user').val() + '#' + $(this).val());	//서버 전송
			print('[',']',$('#user').val(), $(this).val());	//본인 대화창
		    $('#msg').val('');
			$('#msg').focus(); 
			
		}
	}); */
	
	$("#bid").click(function(){
			
		var result = confirm("입찰하시겠습니까?");
		if(result){
			var newBiddingPrice = parseInt($('#biddingPrice').val()) + parseInt($('#unitPrice').text());
			ws.send('2#' + $('#user').val() + '#' + $('#biddingPrice').val() + '원을 입찰하였습니다.');
			print('[',']',$('#user').val(), $('#biddingPrice').val() + '원을 입찰하였습니다.' );
			$.ajax({
				type: 'POST',
				url: '/ot/auction/bidding.action',
				data: 'biddingPrice=' + $('#biddingPrice').val() + '&auctionSeq=' + $('#auctionSeq').val() + '&memberSeq=' + $('#memberSeq').val(),
				dataType:'json',
				success:function(result){
					if(result != null){
						$('#presentPrice').text(parseInt($('#biddingPrice').val()));
						$('#biddingPrice').val(newBiddingPrice);
					} else{
						alert("다른 사용자가 입찰하였습니다.");
					}
				},
				error: function(a,b,c) {
					console.log(a,b,c);
				}
			});
			
		}

	});  
		
	

	function print(symbolStart,symbolEnd,user, txt) {

		let temp = '';
		temp += '<div style="margin-bottom:3px; font-size: 15px; text-align:left;">';
		temp += symbolStart + user + symbolEnd;
		temp += txt;
		temp += ' <span style="font-size: 11px; color: #777;">'
				+ new Date().toLocaleTimeString() + '</span>';
		temp += '</div>';

		$('#auctionChatList').append(temp);

	}
	
	$('#btnDisConnect').click(function(){
		ws.send('3#' + $('#user').val() + '#');
		ws.close();
		
		$('#user').attr('readonly',false);
		
		$('#btnConnect').attr('disabled',false);
		$('#btnDisConnect').attr('disabled',true);
		$('#bid').attr('disabled', true);
		
		/* $('#msg').val('');
		$('#msg').attr('disabled',true); */
	});
	
	/* function price(price, unitPrice){
		var inprice = Number(price)+Number(unitPrice)
		$("#presentPrice").text("입찰가 :" + inprice);
	} */
	
	let today = new Date();   

	let year = today.getFullYear(); // 년도
	let month = ("0"+(today.getMonth() + 1)).slice(-2);  // 월
	let date = today.getDate();  // 날짜
	let endDay = year + '-' + month + '-' + date;
	
	var endTime = $("#endTime").text().substring(0,10);
	
	if(endDay == endTime){
		alert("경매가 종료되었습니다.");
		location.href='/ot/auction/auction.action';
	}

</script>

<script src="/ot/resources/js/jquery-1.11.0.min.js"></script>
<script src="/ot/resources/js/jquery-migrate-1.2.1.min.js"></script>
<script src="/ot/resources/js/bootstrap.bundle.min.js"></script>
<script src="/ot/resources/js/templatemo.js"></script>
<script src="/ot/resources/js/custom.js"></script>

<!-- <script src="/ot/resources/js/auction.js"></script> -->

