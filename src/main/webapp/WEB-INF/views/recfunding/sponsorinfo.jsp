<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<style>

	.row {
		margin: 50px;
	}
	
	#btn1{
		margin-bottom: 50px;
		size: 
	}

</style>

<div class="container py-5">
	<div class="row">
		<%@ include file="/WEB-INF/views/inc/rectemplate.jsp"%>
		<div class="col-lg-9">
			<div class="row">
		
			<h1>참여한 후원자 정보</h1>
			<div>프로젝트 후원자 정보를 확인하세요.</div>
			
			<div><input type="button" id="btn1" class="btn btn-success btn-sm" value="후원자 목록 자세히 보기"
					onclick="location.href='/ot/recfunding/sponsorlist.action?projectSeq=${projectSeq}&memberSeq=${memberSeq}';"></div>
		

		<!-- 차트 시작 -->
		<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
		<script type="text/javascript">
	
		  google.charts.load('current', {'packages':['corechart']});
		  
		  //다른데이터로 각각의 표를 그리고 싶다면, 콜백 함수를 여러개 사용
		  google.charts.setOnLoadCallback(drawChart1);
		  google.charts.setOnLoadCallback(drawChart2);
		
		  //성별 그래프
		  function drawChart1() {
		    var data = new google.visualization.DataTable();
		    data.addColumn('string', '성별');
		    data.addColumn('number', '인원수');
		    data.addRows([
		      ['여성', 11],
		      ['남성', 4]
		    ]);
	
		    var options = {'title':'후원자 성별 비율 및 인원수',
		                   'width':400,
		                   'height':300};
		    
		    var chart = new google.visualization.PieChart(document.getElementById('genderchart_div'));
		    chart.draw(data, options);
		  }
		    
		    
		   //연령별 그래프 
		  function drawChart2() {
		    var data = new google.visualization.DataTable();
		    data.addColumn('string', '연령대');
		    data.addColumn('number', '인원수');
		    data.addRows([
		      ['10대', 0],
		      ['20대', 2],
		      ['30대', 10],
		      ['40대', 3],
		      ['50대이상', 0]
		    ]);
	
		    var options = {'title':'후원자 연령대 비율 및 인원수',
		                   'width':400,
		                   'height':300};
	
		    var chart = new google.visualization.PieChart(document.getElementById('agechart_div'));
		    chart.draw(data, options);
		  }
		</script>
		<table class="columns">
			<tr>
				<td><div id="genderchart_div"></div></td>
				<td><div id="agechart_div" ></div></td>
			</tr>
		</table>
		<!-- 차트 끝 -->
		
		</div>
		
	</div>
</div>
</div>















