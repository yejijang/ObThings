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
					<td colspan="4">
						<button class="categoryBtn" onclick="location.href='/ot/funding/fundmain.action?categoryseq=${project.categorySeq}'">${project.categoryName}</button>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<c:set var="searchTag" value="${fn:split(project.searchTag,',')}" />
						<c:forEach var="tag" items="${searchTag}">
							#${tag}
						</c:forEach>
					</td>
				</tr>
				<tr>
					<td colspan="4">${project.name}</td>
				</tr>
				<tr>
					<td rowspan="5">
						<img src="/ot/resources/img/projectimage/${project.thumImage}" alt="projectImage_${project.thumImage}">
					</td>
					<td colspan="3">
						<c:if test="${not empty project.teamName}">
							${project.teamName} /
						</c:if> ${project.userName}</td>
				</tr>
				<tr>
					<!-- 프로젝트 펀딩받은 총 금액 유무에 따라 출력 -->
					<c:if test="${empty totalPrice}">
						<td colspan="3">
							<span class="infoBold">0</span>원 후원 + <span class="infoBold">0</span>% 달성
						</td>
					</c:if>
					<c:if test="${not empty totalPrice}">
						<td colspan="3">
							<span class="infoBold"><fmt:formatNumber value="${totalPrice}" type="number" /></span> 원 후원 + <span class="infoBold"><fmt:formatNumber value="${totalPrice / project.target * 100}" pattern=".00" /></span>% 달성
						</td>
					</c:if>
				</tr>
				<tr>
					<td colspan="3">
						<fmt:formatDate value="${startDate}" type="date" pattern="yyyy-MM-dd" /> ~ <fmt:formatDate value="${endDate}" type="date" pattern="yyyy-MM-dd" /> <span class="infoBold">(D - ${project.meanTime})</span>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<span class="infoBold">${projectTotalMember}</span>명의 후원자
					</td>
				</tr>
				<tr>
					<c:if test="${empty memberSeq}">
						<td id="projectLike" class="nonLike" title="찜하기">&#128420;</td>
					</c:if>
					<c:if test="${not empty memberSeq}">
						<td id="projectLike" class="like" title="찜하기"><c:if test="${projectLike == 0}">&#128420;</c:if><c:if test="${projectLike == 1}">&#128152;</c:if></td>
					</c:if>
					<td>
						<button type="button" class="btn btn-primary" onclick="scrollPack();">펀딩하기</button>
					</td>
					<td>
						<button type="button" class="btn btn-default" onclick="loginCheck();">&#128680;신고</button>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="warnModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">신고하기</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<form method="post" action="/ot/funding/sendwarn.action" name="warnform" onsubmit="return warncheck()">
					<div class="modal-body">
						<div class="form-group">
							<label for="warnCategory">신고사유</label>
							<select id="warnCategory" class="form-control" name="warnCategory">
								<option value="프로젝트 연관성">프로젝트 연관성</option>
								<option value="욕설/비방">욕설/비방</option>
								<option value="허위사실유포">허위사실유포</option>
								<option value="기타">기타</option>
							</select>
						</div>

						<textarea id="warnContent" name="content" class="form-control"></textarea>
						
						<input type="hidden" name="sMemberSeq" value="${memberSeq}"> <!-- 신고자: 신고자 시퀀스 -->
						<input type="hidden" name="rMemberSeq" value="${project.memberSeq}"> <!-- 신고대상: 프로젝트 창작자 시퀀스 -->
						<input type="hidden" name="projectSeq" value="${project.projectSeq}"> <!-- 프로젝트 시퀀스 -->
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
						<button type="submit" class="btn btn-primary">신고하기</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<div id="projectContent">
		<div id="projectContentLeft">
			<div id="main">
				<input type="radio" id="content" name="rb" checked>
					<label for="content">상세 설명</label>
				<input type="radio" id="notice" name="rb">
					<label for="notice">공지사항</label>
				<input type="radio" id="qa" name="rb">
					<label for="qa">창작자에게 문의하기</label>
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
					<form method="POST" action="/ot/funding/sendqa.action" name="qaform" onsubmit="return qacheck()">

						<textarea name="content" id="qatext" class="form-control" placeholder="창작자에게 문의할 내역을 입력해 주세요."></textarea>
						
						<input type="hidden" name="sMemberSeq" value="${memberSeq}"> <!-- 보낸사람: 문의사항 작성자 시퀀스 -->
						<input type="hidden" name="rMemberSeq" value="${project.memberSeq}"> <!-- 받는사람: 프로젝트 창작자 시퀀스 -->
						<input type="hidden" name="projectSeq" value="${project.projectSeq}"> <!-- 프로젝트 시퀀스 -->
					
						<button type="submit" class="form-control">문의하기</button>
						
					</form>
				</div>
			</div>
		</div>
		<div id="projectContentRight">
			<c:if test="${projectTotalMember > 0}">
				<div class="chart" id="genderChart"></div>
				<div class="chart" id="ageGroupChart"></div>
			</c:if>
			<c:forEach items="${projectPackList}" var="dto">
				<div class="projectPack" onclick="paycheck(${project.projectSeq}, ${dto.packageSeq})">
					<div class="projectPackName">
						<fmt:formatNumber value="${dto.price}" type="number" /> 원 펀딩
					</div>
					<div class="projectPackPrice">${dto.name}</div>
					<div class="projectPackContent">${dto.content}</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<!-- 로그인 유무에 따른 멤버 시퀀스 가공 -->
	<c:set var="member" value="${memberSeq}" />
	<c:if test="${empty member}"><c:set var="member" value="0" /></c:if>
	<c:if test="${not empty member}"><c:set var="member" value="${member}" /></c:if>
	
</div>

<script>
	/* 로그인이 되어있는 경우 > 프로젝트 찜하기 */
	$('#projectLike.like').click(function() {
		
		let btn = event.srcElement;
		
		if ($(this).html() == '💘') {
			/* 찜하기 취소 */
	
			$.ajax({
				type: 'POST',
				url: '/ot/funding/dellike.action',
				data: 'projectSeq=' + ${project.projectSeq} + '&memberSeq=' + ${member},
				dataType: 'json',
				success: function(result) {
					if (result == 1) {
						$(btn).html('&#128420;');
					}
				},
				error: function(a,b,c) {
					console.log(a,b,c);
				}
			});
			
		} else {
			/* 찜하기 */
			
			$.ajax({
				type: 'POST',
				url: '/ot/funding/addlike.action',
				data: 'projectSeq=' + ${project.projectSeq} + '&memberSeq=' + ${member},
				dataType: 'json',
				success: function(result) {
					if (result == 1) {
						$(btn).html('&#128152;');
					}
				},
				error: function(a,b,c) {
					console.log(a,b,c);
				}
			});
		}	
	});
	
	/* 후원하기 버튼 클릭시 프로젝트 패키지 부분으로 이동 */
	function scrollPack() {
		var location = document.querySelector(".projectPack").offsetTop;
		window.scrollTo({top:location - 100, behavior:'smooth'});
	}
	
	/* 신고 모달 뜨기전 로그인 체크 */
	function loginCheck() {
		if (${empty memberSeq}) {
			alert("로그인 이후에 이용해 주세요. :)");
		} else {
			$('#warnModal').modal('show');
		}
	}

	/* 공지사항 아코디언 형식 */
	$(".sub").click(function() {
		$(this).next(".con").stop().slideToggle(300);
		$(this).toggleClass('on').siblings().removeClass('on');
		$(this).next(".con").siblings(".con").slideUp(300); // 1개씩 펼치기
	});
	
	/* 문의하기 폼 전송 전에 체크 */
	var q = document.qaform;
	
	function qacheck() {
		if (q.sMemberSeq.value == '' || q.sMemberSeq.value == null) {
			alert("로그인 이후에 이용해 주세요. :)");
			return false;
		} else if (q.content.value == '' || q.content.value == null) {
			alert("문의 내용을 입력해 주세요. :)");
			return false;
		} else
			return true;
	}
	
	/* 신고하기 폼 전송 전에 체크 */
	var w = document.warnform;
	
	function warncheck() {
		if (w.content.value == '' || w.content.value == null) {
			alert("신고 내용을 입력해 주세요. :)");
			return false;
		} else
			return true;
	}
	
	/* 후원자 성비에 따른 그래프 출력 */
	<c:if test="${projectTotalMember > 0}">
	
		Highcharts.chart('genderChart', {
			colors: ['#666666', '#999999'],
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
		        	<c:forEach items="${genderList}" var="dto">
			        {
			            name: '${dto.genderGroup}',
			            y: ${dto.groupCnt}
			        },
			        </c:forEach>
		        ]
		    }]
		});
		
		/* 후원자 연령대에 따른 그래프 출력 */
		Highcharts.chart('ageGroupChart', {
			colors: ['#333333', '#666666', '#999999', '#dddddd'],
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
		        data: [${dto.groupCnt}]
		    },
		    	</c:forEach>
		    ]
		});
	</c:if>
	
	function paycheck(projectSeq, packageSeq) {
		if (${empty memberSeq}) {
			alert("로그인 이후에 이용해 주세요. :)");
			return false;
		} else {
			location.href='/ot/funding/fundpayment.action?projectSeq=' + projectSeq + '&packageSeq=' + packageSeq;
		}
	}
</script>