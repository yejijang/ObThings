<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:parseDate value="${project.startDate}"
	pattern="yyyy-MM-dd HH:mm:ss" var="startDate" />
<fmt:parseDate value="${project.endDate}" pattern="yyyy-MM-dd HH:mm:ss"
	var="endDate" />

<script src="/ot/resources/js/highcharts.js"></script>

<div id="projectMain">
	<div id="projectInfo">
		<div id="projectInfoTable">
			<table class="table">
				<tr>
					<td colspan="3"><button class="categoryBtn"
							onclick="location.href='/ot/funding/fundmain.action?categoryseq=${project.categorySeq}'">${project.categoryName}</button></td>
				</tr>
				<tr>
					<td colspan="3"><c:set var="searchTag"
							value="${fn:split(project.searchTag,',')}" /> <c:forEach
							var="tag" items="${searchTag}">
							#${tag}
						</c:forEach></td>
				</tr>
				<tr>
					<td colspan="3">${project.name}</td>
				</tr>
				<tr>
					<td rowspan="5"><img
						src="/ot/resources/img/${project.thumImage}"
						alt="projectImage_${project.thumImage}"></td>
					<td colspan="2"><c:if test="${not empty project.teamName}">
							${project.teamName} /
						</c:if> ${project.userName}</td>
				</tr>
				<tr>
					<!-- 프로젝트 펀딩받은 총 금액 유무에 따라 출력 -->
					<c:if test="${empty totalPrice}">
						<td colspan="2"><span class="infoBold">0</span>원 후원 + <span
							class="infoBold">0</span>% 달성</td>
					</c:if>
					<c:if test="${not empty totalPrice}">
						<td colspan="2"><span class="infoBold"><fmt:formatNumber
									value="${totalPrice}" type="number" /></span> 원 후원 + <span
							class="infoBold"><fmt:formatNumber
									value="${totalPrice / project.target * 100}" pattern=".00" /></span>%
							달성</td>
					</c:if>
				</tr>
				<tr>
					<td colspan="2"><fmt:formatDate value="${startDate}"
							type="date" pattern="yyyy-MM-dd" /> ~ <fmt:formatDate
							value="${endDate}" type="date" pattern="yyyy-MM-dd" /> <span
						class="infoBold">(D - ${project.meanTime})</span></td>
				</tr>
				<tr>
					<td colspan="2"><span class="infoBold">${projectTotalMember}</span>명의
						후원자</td>
				</tr>
				<tr>
					<td id="projectLike">&#128154; &#128420;</td>
					<td><button type="button" class="btn btn-primary">펀딩하기</button></td>
				</tr>
			</table>
		</div>
	</div>
	<div id="projectContent">
		<div id="projectContentLeft">
			<div id="projectDetail">${project.detail}</div>
			<div id="projectImage">
				<c:forEach items="${projectImageList}" var="contentImg">
					<img src="/ot/resources/img/${contentImg}"
						alt="contentImage_${contentImg}">
				</c:forEach>
			</div>
			<div id="projectContent">${project.content}</div>
		</div>
		<div id="projectContentRight">
			<c:if test="${projectTotalMember > 0}">
				<div class="chart" id="genderChart"></div>
				<div class="chart" id="ageGroupChart"></div>
			</c:if>
			<c:forEach items="${projectPackList}" var="dto">
				<div class="projectPack">
					<div class="projectPackName">
						<fmt:formatNumber value="${dto.price}" type="number" />
						원 펀딩
					</div>
					<div class="projectPackPrice">${dto.name}</div>
					<div class="projectPackContent">${dto.content}</div>
				</div>
			</c:forEach>
		</div>
	</div>

</div>

<script>
	<c:if test="${projectTotalMember > 0}">
		Highcharts.chart('genderChart', {
			colors: ['#8CBE99', '#B0CDB7'],
		    chart: {
		        plotBackgroundColor: null,
		        plotBorderWidth: null,
		        plotShadow: false,
		        type: 'pie'
		    },
		    title: {
		        text: '[ 후원자 성비 ]'
		    },
		    tooltip: {
		        pointFormat: '{series.name}: <b>{point.y} 명</b>'
		    },
		    accessibility: {
		        point: {
		            valueSuffix: '%'
		        }
		    },
		    plotOptions: {
		        pie: {
		            allowPointSelect: true,
		            cursor: 'pointer',
		            dataLabels: {
		                enabled: true,
		                format: '<b>{point.name}</b>: {point.y} 명'
		            }
		        }
		    },
		    series: [{
		        name: '후원자수',
		        colorByPoint: true,
		        data: [
			        {
			            name: '남성',
			            y: ${genderList[0]}
			        },
			        {
			            name: '여성',
			            y: ${genderList[1]}
			        }
		        ]
		    }]
		});
		
		Highcharts.chart('ageGroupChart', {
			colors: ['#59AB6E', '#8CBE99', '#B0CDB7', '#D3E0D6', '#E8EDE9'],
		    chart: {
		        type: 'bar'
		    },
		    title: {
		        text: '[ 후원자 연령대 ]'
		    },
		    xAxis: {
		        categories: ['연령대'],
		        title: {
		            text: null
		        }
		    },
		    yAxis: {
		        min: 0,
		        title: {
		            text: null,
		            align: 'high'
		        },
		        labels: {
		            overflow: 'justify'
		        }
		    },
		    tooltip: {
		        valueSuffix: ' 명'
		    },
		    plotOptions: {
		        bar: {
		            dataLabels: {
		                enabled: true
		            }
		        }
		    },
		    legend: {
		        layout: 'vertical',
		        align: 'right',
		        verticalAlign: 'top',
		        x: 10,
		        y: 140,
		        floating: true,
		        borderWidth: 1,
		        backgroundColor:
		            Highcharts.defaultOptions.legend.backgroundColor || '#FFFFFF',
		        shadow: true
		    },
		    credits: {
		        enabled: false
		    },
		    series: [
		    	<c:forEach items="${ageGroupList}" var="dto">
		    {
		        name: '${dto.ageGroup}',
		        data: [${dto.ageGroupCnt}]
		    },
		    	</c:forEach>
		    ]
		});
	</c:if>
</script>