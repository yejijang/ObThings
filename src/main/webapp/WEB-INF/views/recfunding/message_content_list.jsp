<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<c:forEach items="${clist}" var="tmp">
	
		<c:if test="${tmp.fromMemberSeq ne memberSeq}">

			<div style="margin-bottom: 5px;">
				<b style="font-size: .8em;">${tmp.nickName} </b>
			</div>
			<!-- 받은 메세지 -->
			<div class="incoming_msg">
				<div class="incoming_msg_img">

					<c:if test="${empty tmp.profileImage}">

						<img src="/ot/resources/img/profile.png" alt="보낸사람 프로필">

					</c:if>
					<c:if test="${not empty tmp.profileImage}">

						<img src="/ot/resources/img/${tmp.profileImage}" alt="보낸사람 프로필">

					</c:if>



				</div>
				<div class="received_msg">
					<div class="received_withd_msg">
						<p id="content">${tmp.content }</p>
						<span class="time_date"> ${tmp.sendTime }</span>
					</div>
				</div>
			</div>
		</c:if>
</c:forEach>

<c:forEach items="${clist}" var="smp">
	<c:if test="${memberSeq eq smp.fromMemberSeq}">
			<!-- 보낸 메세지 -->
			<div class="outgoing_msg">
				<div class="sent_msg">
					<p>${smp.content }</p>
					<span class="time_date"> ${smp.sendTime }</span>
				</div>
			</div>
	</c:if>
</c:forEach>


