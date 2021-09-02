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
      <h2 class="page-header" style="margin:50px auto; width:1100px; ">${name}님이 찜한 내역</h2>      
      
      <div style="background-color:#e5e8ec; overflow:hidden; width:1100px; margin: auto; ">
      
      
      
    	
      	
    
				
			<div  style="margin: 0px 50px; margin-top:50px;">
			
				
				<c:set var="count" value="1" />
			
		
					<c:forEach items="${likelist}" var="likedto"  >
							<table style="margin-bottom:50px;">
								<tr>
									<td><img src="/ot/resources/img//projectimage/${likedto.thumimage}" id="img${count}"  style="width:200px; cursor:pointer;  height:150px; margin-top:8px; "></td>
									<td class="mouse" id="content${count}"  style="margin-top:20px; width: 630px; cursor:pointer; padding:20px;">${likedto.projectname}</td>
									<td>${likedto.teamname}</td>
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
    
      
      </div>
   	<div style="margin-top:100px;"></div>
   <script>
     
 
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
</body>
</html>