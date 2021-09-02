<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>일정관리</title>
    <!-- <meta name='viewport' content='width=device-width, initial-scale=1'> -->
    <!-- jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <!-- bootstrap 4 -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:400,500,600">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

    <!-- fullcalendar -->
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/main.min.css' rel='stylesheet' />
  	<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/main.min.js'></script>
  	
  	<style>   
	#calendar{
		width: 65%;
		margin: 50px auto;
	}
	
    </style>

    <script>
    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');

        var calendar = new FullCalendar.Calendar(calendarEl, {
          headerToolbar: {
            left: 'prev,next',
            center: 'title',
            right: 'today'
          },
          initialDate: '2021-09-01',
          navLinks: false,
          selectable: true,
          selectMirror: true,
          eventColor: 'gold',
          select: function(arg) {
        	// 일정 추가  
            var title = prompt('일정내용:');
            if (title) {
              calendar.addEvent({
                title: title,
                start: arg.start,
                end: arg.end,
                allDay: arg.allDay,
                color: 'gold',
                textColor: 'black'
              })
            }
            calendar.unselect()
          },
          // 일정 삭제 -> 있는 일정 클릭 시 발생
          eventClick: function(arg) {
        	
        	//console.log("등록된 일정 클릭");
        	//console.log(arg.event);
        	
            if (confirm('일정을 삭제하시겠습니까?')) {
              arg.event.remove()
            }
          },
          editable: true,
          dayMaxEvents: true,
          events: [
        	  {
        		  title: '1차 배송 시작기간',
        		  start: '2021-09-15',
        		  end: '2021-09-22T23:59:59',
        		  color: 'lavender',
        		  textColor: 'black'
        	  },
        	  {
        		  title: '상품준비',
        		  start: '2021-09-05',
        		  end: '2021-09-07T23:59:59',
        		  color: 'lightpink',
        		  textColor: 'black'
        	  },
        	  {
        		  title: '2차 상품준비',
        		  start: '2021-10-15',
        		  end: '2021-10-29T23:59:59',
        		  color: 'cornflowerblue',
        		  textColor: 'black'
        	  },
        	  {
        		  title: '펀딩연장',
        		  start: '2021-08-25',
        		  end: '2021-08-28T23:59:59',
        		  color: 'gold',
        		  textColor: 'black'
        	  },
        	  {
        		  title: '2차 배송시작 배송 준비',
        		  start: '2021-10-06',
        		  end: '2021-10-08T23:59:59',
        		  color: 'green',
        		  textColor: 'black'
        	  }

          ]
        });

        calendar.render();
      });

    </script>
    
</head>

<body>

	<div id="calendar"></div>

</body>

</html>