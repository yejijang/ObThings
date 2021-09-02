<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
/* .place-list { width: 100%; height: 200px; overflow: hidden; border: 1px solid #f0f1f2; text-align:left;} */
.place-img {width: 300px; height: 150px;   float:left; overflow: hidden;}
.place-img img {
	object-fit: cover;
	width: 100%;
	height: auto;
    text-aling: left; 
    -webkit-transform: scale 1;
    -moz-transform: scale 1;
    -ms-transform: scale 1;
    -o-transform: scale 1;
    transform: scale 1;
    transition: all 0.5s ease-out 0s;
  
}
#content {text-align: left;}
#content #title {font-weight: bold;}
table th:nth-child(1) {width: 10%;}
table th:nth-child(2) {width: 40%;}
table tbody td {vertical-align: middle;}

</style>
	<!-- startBanner -->
    <section class="bg-success py-5">
        <div class="container">
            <div class="row align-items-center py-5">
                <div class="col-md-8 text-white">
                    <h1>펀딩받기 페이지입니다</h1>
                    <p>
                        나만의 프로젝트를 신청하고 펀딩을 받아보아요!<br>
                        신청하기 버튼을 클릭하면 바로 신청 가능합니다. 
                    </p>
                    <button class="btn btn-primary btn-lg">신청하기</button>
                </div>
                
                <div class="col-md-4">
                    <img src="/ot/resources/img/recfunding/about-hero.svg" alt="About Hero">
                </div>
                
            </div>
        </div>
        
    </section>
    <!-- Close Banner -->

<section class="container py-5">
	<div class="text-left pt-5 pb-3">
		<div class="">
			<h3 class="h3" style="font-weight:bold;">${name}님의 프로젝트 목록</h3>
			<p>총 ${projlist.size()}개의 프로젝트를 진행했습니다.</p>
		</div>
	</div>
	<div class="place-list">
		<table class="table text-center table-hover">
				<thead class="table-dark text-center">
					<tr>
						<th></th>
						<th>프로젝트</th>
						<th>관리</th>
						<th>비고</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${projlist}" var="pjdto">
					<tr>
						<td name="thumImage" class="place-img">
							
							<img src="/ot/resources/img/projectimage/${pjdto.thumImage}" alt="sumnailImage" class="img">
							
						</td>
						<td id="content">
							<div name="title" id="title"><b>${pjdto.name}</b></div>
							<div name="detail">${pjdto.detail}</div>
						</td>
						<td>
							<button type="button" class="btn btn-secondary btn-sm" onclick="location.href='#!';">수정하기</button>
							<button type="button" class="btn btn-danger btn-sm" onclick="del()">삭제하기</button>
						</td>
						<td><button type="button" class="btn btn-primary" onclick="location.href='/ot/recfunding/recproject.action?projectSeq=${pjdto.projectSeq}';">프로젝트 관리하기</button></td>
					</tr>
					</c:forEach>
				
					
				</tbody>
			</table>
			
			
	</div>
		<nav aria-label="..." style="margin:40px 0;">
		  <ul class="pagination justify-content-center">
		    <li class="page-item disabled">
		      <a class="page-link" href="#" tabindex="-1">Previous</a>
		    </li>
		    <li class="page-item active"><a class="page-link" href="#">1</a></li>
		    <li class="page-item">
		      <a class="page-link" href="#">Next</a>
		    </li>
		  </ul>
		</nav>
	

</section>
