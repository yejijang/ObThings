<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<style>
 
  .tblLike td{
  	width:250px;
  	height:250px;
 	border: 1px solid #CFD6E1;

  }
  
    .tblOpen td{
  	width:250px;
  	height:250px;
 	border: 1px solid #CFD6E1;

  }
  
  .mouse {
			text-decoration: none;

  
  }
  .mouse:hover{
  			text-decoration: underline;
  
  
  
  }
  
/*   td{
  
   	border: 1px solid black;
  
  } */
</style>

</head>
<body>
   <!--  -->
   <div class="container">
      <h1 class="page-header" style="margin:50px auto; width:1100px">마이페이지</h1>      
      
      <div style="background-color:#e5e8ec; overflow:hidden; width:1100px; margin: auto; padding-bottom:50px; margin-bottom:100px; ">
      
      
      
    	
      	
      	<div  style="margin-left:50px; margin-top:50px;">
			<h3 style="margin-bottom:30px;">내 정보</h3>
      	
      		
      		<table style=" width:600px; height: 180px; ">
      			<tr >
      				<td rowspan="5" style="width:220px; text-align: center; ">
	      				<c:if test="${empty profileimage}"> 
 	      					<img src="/ot/resources/img/profile.png" style="width:130px; height:130px;  border-radius: 100%;">
	      				</c:if> 
	      				
	      				<c:if test="${not empty profileimage}"> 
	      					<img src="/ot/resources/img/${profileimage}" style="width:140px;  height:140px;  border-radius: 100%;">
	      				</c:if> 
      				</td>
      			</tr>
      		
      		
      			<tr >
      				<td>&nbsp&nbsp&nbsp&nbsp닉네임&nbsp:&nbsp &nbsp${nickName} </td>
      
      			</tr>
      			
      			<tr>
      				<td>&nbsp&nbsp&nbsp&nbsp이름&nbsp:&nbsp &nbsp${name}</td>
      			</tr>
      			<tr>
      				<td>&nbsp&nbsp&nbsp&nbsp잔여포인트&nbsp:&nbsp &nbsp${point} Point</td>
      
      			</tr>
      			<tr>
      				<td>&nbsp&nbsp&nbsp&nbsp이메일&nbsp:&nbsp &nbsp${email}</td>
      
      			</tr>
      			
      			
      		</table>
      		</div>
				
			<div  style="margin: 0px 50px; margin-top:50px;">
			<h3>찜한 프로젝트</h3>
			<table class="tblLike" style="margin-top:30px;" >
				
				<tr>
				<c:if test="${not empty likelist}">
				<c:set var="count" value="1" />
					<c:forEach items="${likelist}" var="likedto" begin="0" end="3" >
							
	
							<td style="text-align: center; vertical-align: top;">
								
								<img src="/ot/resources/img/projectimage/${likedto.thumimage}" id="img${count}"  style="width:200px; cursor:pointer;  height:150px; margin-top:8px; ">
								<div class="mouse" id="content${count}"  style="margin-top:10px; cursor:pointer; padding:20px;">${likedto.projectname}</div>
								<div style="padding:5px; float:right; margin-left:20px; ">${likedto.teamname}</div>
							</td>
							<c:set var="count" value="${count+1}" />
					</c:forEach>
					
					 	<c:if test= "${likelist.size() gt 4}">
						<td style="width:30px; text-align: center;">
							<a href="/ot/mypage/like.action" style="color:#bdc0c6;" >더보기</a>
						</td>
						</c:if> 
				</c:if>	
				
				<c:if test="${empty likelist}">
					<div>찜한 프로젝트가 없습니다.</div>
				</c:if>
				
					
				</tr>
				
				
			</table>	
			
			<h3 style="margin-top:50px;">펀딩한 프로젝트 목록</h3>
			
			<table class="tblOpen" style="margin-top:30px;" >
				
				<tr>
				
				<c:if test="${not empty fundlist}">
				
				
					<c:set var="count" value="5" />
					
					
					<c:forEach items="${fundlist}" var="fundlist" begin="0" end="3" >
							
	
							<td style="text-align: center; vertical-align: top;">
								
								<img src="/ot/resources/img/projectimage/${fundlist.thumimage}" id="img${count}"  style="width:200px; cursor:pointer;  height:150px; margin-top:8px; ">
								<div class="mouse" id="content${count}" style="margin-top:10px; cursor:pointer; padding:20px;">${fundlist.projectname}</div>
								<div style="padding:5px; float:right; margin-left:20px; ">${fundlist.teamName}</div>
								
							</td>
							
							<c:set var="count" value="${count+1}" />
							
					</c:forEach>
					
					 	<c:if test= "${fundlist.size() gt 4}">
						<td style="width:30px; text-align: center;">
							<a href="/ot/mypage/fund.action" style="color:#bdc0c6;">더보기</a>
						</td>
						</c:if> 
				</c:if>	
				
				<c:if test="${empty fundlist}">
					<div>펀딩한 프로젝트가 없습니다.</div>
				</c:if>
				
						
				</tr>
				
				
			</table>
				
			</div>
			
				
      </div>
    
      
      </div>
      
      
      <div>
      
      </div>
   
   <script>
      $('#img1').click(function(){
    	  
    	  location.href='#'
    	  
      });
      
		$('#content1').click(function(){
		    	  
		    	  location.href='#'
		    	  
		      });
    
		$('#img2').click(function(){
	  
	    	  location.href='#'

	  
		});
		
		$('#content2').click(function(){
	    	  
	    	  location.href='#'
	    	  
	      });


		$('#img3').click(function(){
	  
	    	  location.href='#'
	  
		});
		
		$('#content3').click(function(){
	    	  
	    	  location.href='#'
	    	  
	      });

		
		$('#img4').click(function(){
			  
	    	  location.href='#'
	  
		});
		
		$('#content4').click(function(){
	    	  
	    	  location.href='#'
	    	  
	      });

		
		 $('#img5').click(function(){
	    	  
	    	  location.href='#'
	    	  
	      });
		 
			$('#content5').click(function(){
		    	  
		    	  location.href='#'
		    	  
		      });
  
	    
		 $('#img6').click(function(){
	    	  
	    	  location.href='#'
	    	  
	      });
		 
			$('#content6').click(function(){
		    	  
		    	  location.href='#'
		    	  
		      });
  
	    
		 $('#img7').click(function(){
	    	  
	    	  location.href='#'
	    	  
	      });
		 
			$('#content7').click(function(){
		    	  
		    	  location.href='#'
		    	  
		      });
  
	    
		 $('#img8').click(function(){
	    	  
	    	  location.href='#'
	    	  
	      });
		 
			$('#content8').click(function(){
		    	  
		    	  location.href='#'
		    	  
		      });
			
			
			
  
	    
   </script>
