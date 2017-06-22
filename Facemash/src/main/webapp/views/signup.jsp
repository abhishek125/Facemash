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
 rel="stylesheet">
<!--[if lt IE 9]>
          <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
<link href="${pageContext.request.contextPath}/resources/css/facebook.css"
 rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/main.css"
 rel="stylesheet">
 <script>
 var context = "${pageContext.request.contextPath}"
</script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
<script
 src="${pageContext.request.contextPath}/resources/js/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>

<script
 src="${pageContext.request.contextPath}/resources/js/searchbox.js"></script>
</head>

<body>
 <div id="wrap">
  <div class="row">
   <div class="col-md-6 col-md-offset-3">
    <form action="${pageContext.request.contextPath}/register" method="post" accept-charset="utf-8"
     class="form" role="form">
     <legend>Sign Up</legend>
     <h4>It's free and always will be.</h4>
     <input type="text" name="firstname" value=""
      class="form-control input-lg" placeholder="Your firstname" data-toggle="tooltip" onfocus="theFocus(this);"  data-placement="top" title="dont use special symbols" />
     <input type="text" name="lastname" class="form-control input-lg"
      placeholder="Your lastname" data-toggle="tooltip" onfocus="theFocus(this);"  data-placement="top" title="dont use special symbools" />
     <input type="text" name="mail" class="form-control input-lg"
      placeholder="Your Email" data-toggle="tooltip" onfocus="theFocus(this);"  data-placement="top" title="enter valid email"/>
     <input type="password" name="password" value=""
      class="form-control input-lg" placeholder="Password" data-toggle="tooltip" onfocus="theFocus(this);"  data-placement="top" title="at least 8 characters"/>
     <input type="password" name="confirm" value=""
      class="form-control input-lg" placeholder="Confirm Password" data-toggle="tooltip" onfocus="theFocus(this);"  data-placement="top" title="same as password" />
     <label>Birth Date</label>
     <input type="date" name="dob" value=""
      class="form-control input-lg" placeholder="mm/dd/yyyy" />
     <label>Gender : </label> <label class="radio-inline"> <input
       type="radio" name="gender" value="MALE" id=male /> Male
     </label> <label class="radio-inline"> <input type="radio"
       name="gender" value="FEMALE" id=female /> Female
     </label> <br /> <span class="help-block">By clicking Create my
      account, you agree to our Terms and that you have read our Data
      Use Policy, including our Cookie Use.</span>
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
     <button class="btn btn-lg btn-primary btn-block signup-btn"
      type="submit">Create my account</button>
    </form>
   </div>
  </div>
 </div>
</body>
</html>
