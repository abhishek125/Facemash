<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://abhishek/custom-functions.tld" prefix="myfn" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<title>Facebook Theme Demo</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css"
	rel="stylesheet" >

<link href="${pageContext.request.contextPath}/resources/css/facebook.css"
	rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/resources/css/main.css"
	rel="stylesheet"/>
</head>

<body>
	<div class="container">

		<div class="row" id="pwd-container">
			<div class="col-md-4"></div>

			<div class="col-md-4">
				<section class="login-form">
					<form name="f" method="post" action="${pageContext.request.contextPath}/"
						role="login">
						<img src="http://i.imgur.com/RcmcLv4.png" class="img-responsive"
							alt="" /> <input type="email" name="username"
							placeholder="Email" required class="form-control input-lg" /> <input
							type="password" name="password" class="form-control input-lg"
							id="password" placeholder="Password" required="" />


						<div class="pwstrength_viewport_progress"></div>


						<button type="submit" name="go"
							class="btn btn-lg btn-primary btn-block">Sign in</button>
						<div>
							<a href="${pageContext.request.contextPath}/signup">Create account</a> or <a href="#">reset password</a>
						</div>
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</form>

					
				</section>
			</div>

			<div class="col-md-4"></div>
		</div>
	</div>
</body>
</html>
