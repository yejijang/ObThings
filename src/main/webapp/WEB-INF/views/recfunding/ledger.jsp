<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>

	.row {
		margin: 50px;
	}

	.insertData{
		float: left;
		margin-bottom: 50px;
	}
	
	.form{
		border: 1px solid #59AB6E; 
	}
	
	#pay{
		width: 150px;
		height: 30px;
	}
	
	.con{
		margin-bottom: 10px;
	}
	
	#btn{
		margin-top: 10px;
	}
	
	.head{
		text-align: center;
		background-color: #B7CD99;
	}
	
	
</style>

<div class="container py-5">
	<div class="row">
		<%@ include file="/WEB-INF/views/inc/rectemplate.jsp"%>
		<div class="col-lg-9">
			<div class="row">
			
			<h1>프로젝트 가계부</h1>
			<div style="margin-bottom: 50px;">진행 중인 프로젝트의 지출과 비용을 한 눈에 관리하세요.</div>
		
		<!-- 가계부 내용입력 -->	
		<div class="insertData">			
			<form id="form"> 
		      	<div>유형: 
		      		<select name="isProfit" id="isProfit">
						<option value="수입">수입</option>
						<option value="지출">지출</option>
					</select>
				</div>
		      	<div>비용: <input type="text" name="pay" id="pay" class="form-control" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"></div>
		      	<div>내용: <textarea id="content" class="form-control" placeholder="상세 사용 내역을 입력하세요"></textarea></div>
		      	<div>날짜: <input type="date" name="date" id="date" class="form-control" value="xxx" min="yyy" max="zzz"></div>
		      	<div><input type="button" id="btn" class="btn btn-success btn-sm" value="입력" ></div>
      		 </form> 
		</div>
		
<!-- 		<script>
		$('#btn').click(function(){	
			$.ajax({
				type: 'POST',
				url: '/ajax/recfunding/btn.action',
				data: 'isProfit=' + $('#isProfit').val() + "&pay=" + $('#pay').val() + '&content=' +
						$('#content').val() + '&date=' + $('#date').val(),
				dataType: 'json', //성공하면 1 실패하면 0 돌려주니까 dataType O
				success: function(result){
					if (result == '1'){
						alert('성공');	
					} else {
						alert('실패');
					}
				},
				error: function(a,b,c){
					consol.log(a, b, c);
				}
			})
		});
		</script> -->
		
<!-- 	
		<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
		<script type="text/javascript">
	
		google.charts.load('current', {'packages':['bar']});
		  
		//다른데이터로 각각의 표를 그리고 싶다면, 콜백 함수를 여러개 사용
		google.charts.setOnLoadCallback(drawChart);
		
		function drawChart() {
	        var data = google.visualization.arrayToDataTable([
	          ['날짜', '수입', '지출', '수입-지출'],
	          ['08-20', 1800000, 0, 1800000],
	          ['08-20', 1600000, 0, 3400000],
	          ['08-22', 0, 1000000, 2400000],
	          ['08-22', 0, 900000, 1500000],
	          ['08-23', 0, 300000, 1200000],
	          ['08-23', 0, 500000, 700000]
	        ]);
	
	        var options = {
	                chart: { title: '프로젝트 수입/지출'}
	              };
		    
	        var chart = new google.charts.Bar(document.getElementById('columnchart'));
	        chart.draw(data, google.charts.Bar.convertOptions(options));
		  }

		</script>
		<table class="columns">
			<tr>
				<td><div id="columnchart" style="border: 3px solid yellow;"></div></td>
			</tr>
		</table> -->
			
		<!-- 수입 테이블 -->
		<table class="table table-bordered" style="margin-top: 50px;">
					<tr class="head"><th colspan="4">수입</th></tr>
					<tr style="background-color: #CDD8D2;">																										
						<th>금액</th>												
						<th>내용</th>												
						<th>날짜</th>												
					</tr>
					<c:set var="intotal" value="0" />
					<c:forEach items="${inlist}" var="indto">
					<tr style="background-color: #EDECE9;">
						<td>${indto.price}</td>
						<td>${indto.content}</td>
						<td>${indto.regdate}</td>
					</tr>
					<c:set var="intotal" value="${intotal + indto.price}" />
					</c:forEach>
					<tr style="background-color: #CDD8D2;">
						<th colspan="4">총 수입</th>
					</tr>
					<tr style="background-color: #EDECE9;">
						<td colspan="4" style="color: blue;"><c:out value="${intotal}"/>원</td>					
					</tr>
			</table>
			
			<!-- 지출 테이블 -->
			<table class="table table-bordered" style="margin-top: 50px;">
					<tr class="head"><th colspan="4">지출</th></tr>
					<tr style="background-color: #CDD8D2;">			
						<th>금액</th>												
						<th>내용</th>												
						<th>날짜</th>												
					</tr>
					<c:set var="outtotal" value="0" />
					<c:forEach items="${outlist}" var="outdto">
					<tr style="background-color: #EDECE9;">
						<td>${outdto.price}</td>
						<td>${outdto.content}</td>
						<td>${outdto.regdate}</td>
					</tr>
					<c:set var="outtotal" value="${outtotal + outdto.price}" />
					</c:forEach>
					<tr style="background-color: #CDD8D2;">
						<th colspan="4">총 지출</th>
					</tr>
					<tr style="background-color: #EDECE9;">
						<td colspan="4" style="color: red;"><c:out value="${outtotal}"/>원</td>
					</tr>
				</table>
				
				<!-- 영업이익 테이블 -->
				<table class="table table-bordered" style="margin-top: 50px;">
					<tr class="head"><th colspan="5">영업이익</th></tr>
					<tr style="background-color: #CDD8D2;">															
						<th>총 수입</th>												
						<th>총 지출</th>												
						<th>부가가치세(10%)</th>												
						<th>플랫폼 수수료(5%)</th>												
						<th>결제 수수료(5%)</th>												
					</tr>
					<tr style="background-color: #EDECE9;">
						<td><c:out value="${intotal}"/></td>
						<td><c:out value="${outtotal}"/></td>
						<td><c:out value="${intotal * 0.1}"/></td>
						<td><c:out value="${intotal * 0.05}"/></td>
						<td><c:out value="${intotal * 0.05}"/></td>
					</tr>
					<tr style="background-color: #CDD8D2;">
						<th colspan="5">영업이익</th>
					</tr>
					<tr style="background-color: #EDECE9;">
						<td colspan="5" style="color: green;">
						<c:out value="${intotal - outtotal - (intotal * 0.1) - (intotal * 0.05) - (intotal * 0.05) }"/>원</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>










