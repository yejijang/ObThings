<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>

</style>
 <c:forEach var="tmp" items="${messagelist}">
 
	<div class="chat_list_box${tmp.room} chat_list_box">
		<div type="button" class="chat_list" room="${tmp.room}" other-nick="${tmp.otherMember}">
			<!-- active-chat -->
			<div class="chat_people">
				<div class="chat_img" >
					<c:if test="${empty tmp.profileImage}">
					
						<img src="/ot/resources/img/profile.png" alt="sunil" >
						
					</c:if>
					<c:if test="${not empty tmp.profileImage}">
					
							<img src="/ot/resources/img/${tmp.profileImage}" alt="sunil" >
					
					</c:if>
					
					
				</div>
				<div class="chat_ib">
					<div class="row">
						<div class="col-8">
							<p>${tmp.content}</p>
						</div>
						<%-- 만약 현재사용자가 안읽은 메세지 갯수가 0보다 클때만 badge를 표시한다. --%>
						<c:if test="${tmp.unread > 0 }">
							<div class="col-2 unread${tmp.room }">
								<span class="badge bg-danger">${tmp.unread }</span>
							</div>
						</c:if>
						<span class="time">${tmp.sendTime }</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</c:forEach>