<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OT</title>

<tiles:insertAttribute name="asset"/>

<style>
    
</style>
</head>
<body>

	<tiles:insertAttribute name="header"/>
    <tiles:insertAttribute name="main"/>    
    <tiles:insertAttribute name="footer"/>
    
	    
	<script src="/ot/resources/js/jquery-1.11.0.min.js"></script>
	<script src="/ot/resources/js/jquery-migrate-1.2.1.min.js"></script>
	<script src="/ot/resources/js/bootstrap.bundle.min.js"></script>
	<script src="/ot/resources/js/templatemo.js"></script>
	<script src="/ot/resources/js/custom.js"></script>
    
</body>
</html>








