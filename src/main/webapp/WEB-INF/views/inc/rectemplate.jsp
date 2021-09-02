<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<div class="col-lg-3">
	<div class="border">
		<div style="margin: 20px;">
			<h1>이영욱님의</h1>
			<h2 style="padding-bottom: 20px;">프로젝트</h2>
		</div>
	</div>
	<ul class="list-unstyled">
		<li class="pb-3  border"><a
			class="h3 font-monospace text-decoration-none text-dark"
			href="/ot/recfunding/noticelist.action?projectSeq=${projectSeq}&memberSeq=${memberSeq}">
				공지사항 관리하기 </a></li>
		<li class="pb-3  border"><a
			class="h3 font-monospace text-decoration-none text-dark"
			href="/ot/recfunding/processlist.action?projectSeq=${projectSeq}&memberSeq=${memberSeq}">
				진행상황 발송하기 </a></li>
		<li class="pb-3  border"><a
			class="h3 font-monospace text-decoration-none text-dark"
			href="/ot/recfunding/message_list.action?projectSeq=${projectSeq}&memberSeq=${memberSeq}">
				전체 문의함 </a></li>
		<li class="pb-3  border"><a
			class="h3 font-monospace text-decoration-none text-dark" href="#">
				프로젝트정보 수정하기 </a></li>
		<li class="pb-3  border"><a
			class="h3 font-monospace text-decoration-none text-dark" href="#">
				펀딩결제기능 </a></li>
		<li class="pb-3  border"><a
			class="h3 font-monospace text-decoration-none text-dark"
			href="/ot/recfunding/sponsorinfo.action?projectSeq=${projectSeq}&memberSeq=${memberSeq}">
				참여한 후원자 정보 </a></li>
		<li class="pb-3  border"><a
			class="h3 font-monospace text-decoration-none text-dark"
			href="/ot/recfunding/ledger.action?projectSeq=${projectSeq}&memberSeq=${memberSeq}">
				가계부 </a></li>
	</ul>
</div>