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
			color:black;

  
  }
  .mouse:hover{
  			text-decoration: underline;
  
  
  
  }
  
  .bt{
  	width:200px;
  	font-size:1px;
   color: green;
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
      <h1 class="page-header" style="margin:50px auto;">펀딩한 내역 자세히보기</h1>      
      
      <div style="background-color:#e5e8ec; overflow:hidden; width:1100px; margin: auto; ">
      
      
      
    	
      	
    
				
			<div  style="margin: 0px 50px; margin-top:50px;">
			
				
				<c:set var="count" value="1" />
			
		
					<c:forEach items="${fundlist}" var="funddto"  >
					
						
							<table style="margin-bottom:50px;">
								<tr>
									<td><img src="/ot/resources/img/projectimage/${funddto.thumimage}" id="img${count}"  style="width:200px; cursor:pointer;  height:150px; margin-top:8px; "></td>
									<td  style="margin-top:20px; width: 630px;  padding:20px;">
											<a href="#"  class="mouse">${funddto.projectname}</a>
											<br>
											<br>
											<a style="margin-top:30px;" href="/ot/mypage/detailfund.action?projectSeq=${funddto.projectSeq}"  id ="button1" class="bt" >구매내역확인</a>
									
									
									
									</td>
									<td>${funddto.teamName}</td>
								</tr>
							</table>
							
							<%-- <span style="text-align: center; vertical-align: top;">
								<img src="/ot/resources/img/mypage/${likedto.thumimage}" id="img${count}"  style="width:200px; cursor:pointer;  height:150px; margin-top:8px;">
								<span class="mouse" id="content${count}"  style="margin-top:10px; cursor:pointer; padding:20px;">${likedto.projectname}</span>
								<span style="padding:5px; float:bottom; margin-left:20px; ">${likedto.teamname}</span>
							
							</span> --%>
	
							<c:set var="count" value="${count+1}" />
							
						
					</c:forEach>
					
				
				
				
				
			
		
				
			</div>
			
		</div>
		
		
		
      
   	<div style="margin-top:100px;"></div>
   <script>
     
   
   
 
		
  
	    
   </script>
