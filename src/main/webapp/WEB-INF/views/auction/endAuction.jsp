<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<link href='https://fonts.googleapis.com/css?family=Anton' rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Neucha' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/auction.css">
<!-- Start Content -->
<div class="container py-5">
	<div class="row">

		<%@ include file="/WEB-INF/views/inc/auctionRectemplate.jsp"%>
		<div class="col-lg-9">
			<div class="row">
				<div id="auctionBody">
					<h1>최근 종료된 경매입니다.</h1>
					<div class="realAuction">
						<div class="realAuction-box">
							<div class="thumImage"
								style="background-image:url(../resources/img/projectimage/${dto[0].thumImage });"></div>
							<div class="thumText">
								<h4>${dto[0].name }</h4>
								<hr>
								<ul>
									<li style="display:flex;">
										<h5>시작 시간</h5>&nbsp;:&nbsp;<div id="startTime">${dto[0].startTime }</div>
									</li>
									<li style="display:flex;">
										<h5>시작 가격</h5>&nbsp;:&nbsp;<div>${dto[0].startPrice }</div>
									</li>
									<li>
										<h5>상품 내용</h5><div>${dto[0].content }</div>
									</li>
								</ul>
							</div>
						</div>
						<form method="GET" action="/ot/auction/endDetailAuction.action">
							<input type="hidden" name="auctionSeq"
								value="${dto[0].auctionSeq }"> <input type="submit"
								id="enter" class="btn btn-primary" value="입장하기" disabled>
						</form>
					</div>
					<h1>종료된 경매 입니다.</h1>
					<div class="preAuction">
						<div class="preAuction-box">
							<div id="wrapper">
								<div id="slider-wrap">
									<ul id="slider">
										<c:forEach var="dto" items="${dto}" begin="1">
											<li>
												<div id=prebox>
													<div class="thumImage"
														style="background-image:url(../resources/img/projectimage/${dto.thumImage});"></div>
													<div class="thumText">
														<h4>${dto.name}</h4>
														<hr>
														<div>${dto.startTime }</div>
														<div>${dto.content }</div>
													</div>
												</div>
											</li>
										</c:forEach>
									</ul>
									<!--controls-->
									<div class="btns" id="next">
										<i class="fa fa-arrow-right"></i>
									</div>
									<div class="btns" id="previous">
										<i class="fa fa-arrow-left"></i>
									</div>
									<div id="counter"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<script>
	let today = new Date();   
	
	let year = today.getFullYear(); // 년도
	let month = ("0"+(today.getMonth() + 1)).slice(-2);  // 월
	let date = today.getDate();  // 날짜
	let startDay = year + '-' + month + '-' + date;
	
	var startTime = $("#startTime").text().substring(0,10);
	
	if(startDay >= startTime) {
		$("#enter").attr('disabled',false);
	}



//current position
 var pos = 0;
 //number of slides
 var totalSlides = $('#slider-wrap ul li').length;
 //get the slide width
 var sliderWidth = $('#slider-wrap').width();

 $(document).ready(function(){
   /*****************
    BUILD THE SLIDER
   *****************/
   //set width to be 'x' times the number of slides
   $('#slider-wrap ul#slider').width(sliderWidth*totalSlides);
   
     //next slide  
   $('#next').click(function(){
     slideRight();
   });
   
   //previous slide
   $('#previous').click(function(){
     slideLeft();
   });
   
   
   
   /*************************
    //*> OPTIONAL SETTINGS
   ************************/
   //automatic slider
   var autoSlider = setInterval(slideRight, 3000);
   
   //for each slide 
   $.each($('#slider-wrap ul li'), function() { 

      //create a pagination
      var li = document.createElement('li');
      $('#pagination-wrap ul').append(li);    
   });
   
   //counter
   countSlides();
   
   //pagination
   pagination();
   
   //hide/show controls/btns when hover
   //pause automatic slide when hover
   $('#slider-wrap').hover(
     function(){ $(this).addClass('active'); clearInterval(autoSlider); }, 
     function(){ $(this).removeClass('active'); autoSlider = setInterval(slideRight, 3000); }
   );
   
   

 });//DOCUMENT READY
   


 /***********
  SLIDE LEFT
 ************/
 function slideLeft(){
   pos--;
   if(pos==-1){ pos = totalSlides-1; }
   $('#slider-wrap ul#slider').css('left', -(sliderWidth*pos));  
   
   //*> optional
   countSlides();
   pagination();
 }


 /************
  SLIDE RIGHT
 *************/
 function slideRight(){
   pos++;
   if(pos==totalSlides){ pos = 0; }
   $('#slider-wrap ul#slider').css('left', -(sliderWidth*pos)); 
   
   //*> optional 
   countSlides();
   pagination();
 }

   
 /************************
  //*> OPTIONAL SETTINGS
 ************************/
 function countSlides(){
   $('#counter').html(pos+1 + ' / ' + totalSlides);
 }

 function pagination(){
   $('#pagination-wrap ul li').removeClass('active');
   $('#pagination-wrap ul li:eq('+pos+')').addClass('active');
 }
 
 </script>
 
 
 
<script src="/ot/resources/js/jquery-1.11.0.min.js"></script>
<script src="/ot/resources/js/jquery-migrate-1.2.1.min.js"></script>
<script src="/ot/resources/js/bootstrap.bundle.min.js"></script>
<script src="/ot/resources/js/templatemo.js"></script>
<script src="/ot/resources/js/custom.js"></script>
 
 