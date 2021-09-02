<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

 <!-- Start Top Nav -->
    <nav class="navbar navbar-expand-lg bg-dark navbar-light d-none d-lg-block" id="templatemo_nav_top">
        <div class="container text-light">
            <div class="w-100 d-flex justify-content-between">
                <div>
                   
                </div>
                
                <c:if test="${empty id}">
                <div>
                    <a href="/ot/main/signin.action">로그인</a>
                    &nbsp;&nbsp;
                    <a>회원가입</a>
                </div>
                </c:if>
                
                <c:if test="${not empty id}">
                <div>
                    <a href="/ot/main/signout.action">로그아웃</a>
                    &nbsp;&nbsp;
                    <a>${name}님 환영합니다</a>
                </div>
                </c:if>
                
            </div>
        </div>
    </nav>
    <!-- Close Top Nav -->


    <!-- Header -->
    <!-- Header -->
    <nav class="navbar navbar-expand-lg navbar-light shadow">
        <div class="container d-flex justify-content-between align-items-center">

            <a class="navbar-brand text-success logo h1 align-self-center" href="/ot/main/main.action">
                ObThings 
            </a>

            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#templatemo_main_nav" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="align-self-center collapse navbar-collapse flex-fill  d-lg-flex justify-content-lg-between" id="templatemo_main_nav">
                <div class="flex-fill">
                    <ul class="nav navbar-nav d-flex justify-content-between mx-lg-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="/ot/funding/fundmain.action">펀딩하기</a>
                        </li>
                        <c:if test="${not empty id}">
                        <li class="nav-item">
                            <a class="nav-link" href="/ot/recfunding/recmain.action">펀딩받기</a>
                        </li>
                        </c:if>
                        <c:if test="${empty id}">
                        	<li class="nav-item">
                        		<a class="nav-link" href="/ot/main/signin.action">펀딩받기</a>
                        	</li>
                        </c:if>
                        <li class="nav-item">
                            <a class="nav-link" href="/ot/auction/auction.action">경매</a>
                        </li>
                    </ul>
                </div>
                <div class="navbar align-self-center d-flex">
                    <div class="d-lg-none flex-sm-fill mt-3 mb-4 col-7 col-sm-auto pr-3">
                        <div class="input-group">
                            <input type="text" class="form-control" id="inputMobileSearch" placeholder="Search ...">
                            <div class="input-group-text">
                                <i class="fa fa-fw fa-search"></i>
                            </div>
                        </div>
                    </div>
                    <a class="nav-icon d-none d-lg-inline" href="#" data-bs-toggle="modal" data-bs-target="#templatemo_search">
                        <i class="fa fa-fw fa-search text-dark mr-2"></i>
                    </a>
                    <c:if test="${not empty id}">
	                    <a class="nav-icon position-relative text-decoration-none" href="/ot/mypage/mpmain.action">
	                       마이페이지
	                    </a>
                    </c:if>
                    <c:if test="${empty id}">
	                    <a class="nav-icon position-relative text-decoration-none" href="/ot/main/signin.action">
	                       마이페이지
	                    </a>
                    </c:if>
                    <a class="nav-icon position-relative text-decoration-none" href="/ot/schedule/schedule.action">
                        <i class="fa fa-fw fa-user text-dark mr-3"></i>
                        <span class="position-absolute top-0 left-100 translate-middle badge rounded-pill bg-light text-dark"></span>
                    </a>
                </div>
            </div>

        </div>
    </nav>
    <!-- Close Header -->

    <!-- Modal -->
    <div class="modal fade bg-white" id="templatemo_search" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="w-100 pt-1 mb-5 text-right">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="" method="get" class="modal-content modal-body border-0 p-0">
                <div class="input-group mb-2">
                    <input type="text" class="form-control" id="inputModalSearch" name="q" placeholder="Search ...">
                    <button type="submit" class="input-group-text bg-success text-light">
                        <i class="fa fa-fw fa-search text-white"></i>
                    </button>
                </div>
            </form>
        </div>
    </div>
    <!-- Close Header -->