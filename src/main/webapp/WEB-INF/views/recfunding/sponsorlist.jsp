<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
	
	.row{
		margin: 50px;
	}
	
	body > div.container.py-5 > div > div.col-lg-9 > div > table > tbody > tr:nth-child(1) {
		background-color: #B7CD99;
		text-align: center;
	}
	
	body > div.container.py-5 > div > div.col-lg-9 > div > table > tbody > tr > td{
		background-color: #EDECE9;
		text-align: center;		
	}
	
	#list{
		margin-bottom: 50px;
	}

</style>

<div class="container py-5">
	<div class="row">
		<%@ include file="/WEB-INF/views/inc/rectemplate.jsp"%>
		<div class="col-lg-9">
			<div class="row">

				<h1>후원자리스트</h1>
				<div id="list">프로젝트 후원자 정보를 확인하세요.</div>

				<table class="table table-bordered">
					<tr>
						<th>닉네임</th>
						<th>패키지</th>
						<th>금액</th>
						<th>결제날짜</th>
					</tr>
					<tr>
						<td>작은판다</td>
						<td>99,000원 펀딩패키지</td>
						<td>99,000</td>
						<td>21/08/07</td>
					</tr>
					<tr>
						<td>당당뱀뱀</td>
						<td>99,000원 펀딩패키지</td>
						<td>99,000</td>
						<td>21/08/09</td>
					</tr>
					<tr>
						<td>후훗여우</td>
						<td>99,000원 펀딩패키지</td>
						<td>99,000</td>
						<td>21/08/09</td>
					</tr>
					<tr>
						<td>귀엽기린</td>
						<td>99,000원 펀딩패키지</td>
						<td>99,000</td>
						<td>21/08/11</td>
					</tr>
					<tr>
						<td>기분나쁜늑대</td>
						<td>99,000원 펀딩패키지</td>
						<td>99,000</td>
						<td>21/08/17</td>
					</tr>
					<tr>
						<td>잘생긴물소</td>
						<td>99,000원 펀딩패키지</td>
						<td>99,000</td>
						<td>21/08/17</td>
					</tr>
					<tr>
						<td>기분나쁜돼지</td>
						<td>99,000원 펀딩패키지</td>
						<td>99,000</td>
						<td>21/08/18</td>
					</tr>
					<tr>
						<td>작은쥐</td>
						<td>99,000원 펀딩패키지</td>
						<td>99,000</td>
						<td>21/08/20</td>
					</tr>
					<tr>
						<td>당당기린</td>
						<td>99,000원 펀딩패키지</td>
						<td>99,000</td>
						<td>21/08/25</td>
					</tr>		
					<tr>
						<td>배부른강아지</td>
						<td>99,000원 펀딩패키지</td>
						<td>99,000</td>
						<td>21/08/28</td>
					</tr>
					<tr>
						<td>신바람나는너구리</td>
						<td>99,000원 펀딩패키지</td>
						<td>99,000</td>
						<td>21/08/28</td>
					</tr>
					<tr>
						<td>당당한염소</td>
						<td>99,000원 펀딩패키지</td>
						<td>99,000</td>
						<td>21/08/31</td>
					</tr>
					<tr>
						<td>짜릿한여우</td>
						<td>99,000원 펀딩패키지</td>
						<td>99,000</td>
						<td>21/08/31</td>
					</tr>
					<tr>
						<td>깜찍치타</td>
						<td>99,000원 펀딩패키지</td>
						<td>99,000</td>
						<td>21/09/01</td>
					</tr>
					<tr>
						<td>최강원숭이</td>
						<td>99,000원 펀딩패키지</td>
						<td>99,000</td>
						<td>21/09/02</td>
					</tr>		
				</table>
				
			</div>
		</div>
	</div>
</div>
					
