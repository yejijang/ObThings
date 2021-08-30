<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container" style="margin: 60px auto;">
	<div style="height: 400px;">
		<form method="POST" action="/ot/main/signin.action">
			<input type="text" name="id" class="form-control" required autofocus
				placeholder="passoword" style="width: 200px;"> <input
				type="password" name="password" class="form-control" required
				autofocus placeholder="passoword" style="width: 200px;"> <input
				type="submit" class="btn btn-primary" value="로그인">
		</form>
	</div>
</div>