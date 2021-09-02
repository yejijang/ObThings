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
			font-size:30px;

  
  }
  .mouse:hover{
  			text-decoration: underline;
  
  
  
  }
  
  .bt{
  	width:200px;
  	font-size:1px;
   color: white;
   background-color: #a8aaac; 
   border: none;"
  }
  
  
  
/*   td{
  
   	border: 1px solid black;
  
  } */
</style>

</head>
<body>
   <!--  -->
   <div class="container">
      <h1 class="page-header" style="margin:50px auto;">${name}님이 펀딩한 상품내역</h1>      
      
      <div style="background-color:#e5e8ec; overflow:hidden; width:1100px; margin: auto; ">
      
      
      
    	
      	
    
				
			<div  style="margin: 50px 100px; ">
			
			<%-- 	<c:set var = "project" value= "${projectSeq}" /> --%>
				
<%-- 					<c:forEach items="${fundlist}" var="funddto"  >
 --%>
							<table>
							<tr>
							<td><img src="/ot/resources/img/projectimage/${fundlist[0].thumimage}"  style="width:300px; cursor:pointer;  height:200px; margin-top:8px; margin-right:40px; "></td>	
							<td style="margin-left:30px;">
								<a href="#" style="color:black; font-weight:bold; font-size:30px;" class="mouse" >${fundlist[0].projectname}</a>
								<div style="margin-top:30px;">${fundlist[0].packname}</div>
								
								
							</td>
							
							</tr>
							</table>
							<br>
							<br>
							<div style="font-size:20px; font-weight:bold;">배송지 정보</div>
							<hr>
							<div style="margin-left:10px;">${fundlist[0].address}</div>					
							<br>
							<br>
							<div style="font-size:20px; font-weight:bold;">결제 정보</div>
							
							<hr>
							<div style="margin-left:10px;">결제상태 :&nbsp 결제완료</div>
							<br>
							<div style="margin-left:10px;">결제일자 :&nbsp ${fundlist[0].regdate}</div>
							<br>
							<div style="margin-left:10px;">결제카드 :&nbsp ${fundlist[0].cardNum}</div>
							<br>
							<div style="margin-left:10px;">상품가격 :&nbsp ${fundlist[0].price}</div>
							<br>
							<div style="margin-left:10px;">사용한 포인트:&nbsp ${fundlist[0].usePoint}</div>
							<br>
							<h3 style="margin-left:5px;">총 금액: &nbsp  ${fundlist[0].price - fundlist[0].usePoint} 원</h3>
							
							<span style="margin-left:50px;  vertical-align: top; font-size:20px;"></span>
					<%-- 	 </c:forEach> --%>
				
					
				
				
				
				
			
		
				
			</div>
			
			</div>	
      </div>
   	<div style="margin-top:100px;"></div>
   <div class="container">
      <h1 class="page-header"></h1>      
      
   </div>   
   
   <script>
      
   </script>
