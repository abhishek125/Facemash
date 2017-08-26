<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://abhishek/custom-functions.tld" prefix="myfn"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<title>edit your profile</title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/font-awesome.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/jquery-ui.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/facebook.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/main.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/chat.css" rel="stylesheet">
<script>
	var context = "${pageContext.request.contextPath}"
</script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/searchbox.js"></script>
</head>
<body>
	<div class="row ">
		<div class="col-sm-12 col-md-12" id="main">
			<!-- top nav -->
			<div class="navbar navbar-blue navbar-static-top">
				<div class="navbar-header">
					<button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".navbar-collapse">
						<span class="sr-only">Toggle</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a href="${pageContext.request.contextPath}/home" class="navbar-brand logo">f</a>
				</div>
				<nav class="collapse navbar-collapse" role="navigation">
					<form class="navbar-form navbar-left" method="GET" action="${pageContext.request.contextPath}/searchallusers">
						<div class="input-group input-group-sm" style="max-width: 360px;">
							<input class="form-control city" placeholder="Search" name="username" id="tagQuery" type="text" onFocus="inputFocus(this)" onBlur="inputBlur(this)">
							<div class="input-group-btn">
								<button class="btn btn-default" type="submit">
									<i class="glyphicon glyphicon-search"></i>
								</button>
							</div>
						</div>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
					</form>
					<ul class="nav navbar-nav navbar-right">
						<li id="message_li">
							<span id="message_count" class="notification_count" style="display: none;">3</span>
							<a href="#" id="messageLink" class="notification_li">
								<i class="glyphicon glyphicon-envelope"></i>
								message
								<span class="badge">${fn:length(unreadMessageObjects)}</span>
							</a>
							<div id="messageContainer" class="notificationContainer" style="display: none; width: 500px">
								<div id="messageTitle" class="notificationTitle">messages</div>
								<div id="messagesBody" class="notificationsBody notifications">
									<div class="panel panel-default">
										<strong>unread messages</strong>
										<div class="panel-body" id="newmessages">
											<c:forEach var="object" items="${unreadMessageObjects}">
												<div id="${object.infoId}div">
													<table>
														<tr>
															<td width="300px">
																<img src="${object.senderProfile.profilePic}" class="addfrndimg" />
																<span>
																	<strong>
																		<a href="${pageContext.request.contextPath}/profile/${object.senderProfile.userId}"> ${object.senderProfile.firstname} ${object.senderProfile.lastname} </a>
																	</strong>
																</span>
																<br>
																<span>${object.infoText}</span>
																<br />
																<!--show videos and images  -->
																<c:if test="${object.videos ne ''}">
																	<c:set var="my" value="${object.videos}" />
																	<c:set var="fileParts" value="${fn:split(my,';')}" />
																	<c:forEach var="video" items="${fileParts}">
																		<video width="320" height="240" controls>
																			<source src="${video}" type="video/mp4">
																		</video>
																	</c:forEach>
																</c:if>
																<c:if test="${object.images ne ''}">
																	<c:set var="my" value="${object.images}" />
																	<c:set var="fileParts" value="${fn:split(my,';')}" />
																	<c:forEach var="image" items="${fileParts}">
																		<img src="${image}" class="myimage">
																	</c:forEach>
																</c:if>
																<!--complete  -->
															</td>
															<td class="addfrndtd">
																<div class="btn-group btn-group-lg ">
																	<button id="${object.infoId}" value="read" onclick="updateMessage(this.id,this.value)" class="btn-default">mark as read</button>
																	<button id="${object.infoId}" value="delete" onclick="updateMessage(this.id,this.value)" class="btn-default">delete</button>
																</div>
															</td>
														</tr>
													</table>
													<hr>
												</div>
											</c:forEach>
										</div>
										<strong>read messages</strong>
										<div class="panel-body" id="oldmessages" style="display: none;">
											<c:forEach var="object" items="${readMessageObjects}">
												<div id="${object.infoId}div">
													<table>
														<tr>
															<td width="300px">
																<img src="${object.senderProfile.profilePic}" class="addfrndimg" />
																<span>
																	<strong>
																		<a href="${pageContext.request.contextPath}/profile/${object.senderProfile.userId}"> ${object.senderProfile.firstname} ${object.senderProfile.lastname} </a>
																	</strong>
																</span>
																<br>
																<span>${object.infoText}</span>
																<br />
																<!--show videos and images  -->
																<c:if test="${object.videos ne ''}">
																	<c:set var="my" value="${object.videos}" />
																	<c:set var="fileParts" value="${fn:split(my,';')}" />
																	<c:forEach var="video" items="${fileParts}">
																		<video width="320" height="240" controls>
																			<source src="${video}" type="video/mp4">
																		</video>
																	</c:forEach>
																</c:if>
																<c:if test="${object.images ne ''}">
																	<c:set var="my" value="${object.images}" />
																	<c:set var="fileParts" value="${fn:split(my,';')}" />
																	<c:forEach var="image" items="${fileParts}">
																		<img src="${image}" class="myimage">
																	</c:forEach>
																</c:if>
																<!--complete  -->
															</td>
															<td class="addfrndtd">
																<div class="btn-group btn-group-lg ">
																	<button id="${object.infoId}" value="unread" onclick="updateMessage(this.id,this.value)" class="btn-default">mark as unread</button>
																	<button id="${object.infoId}" value="delete" onclick="updateMessage(this.id,this.value)" class="btn-default">delete</button>
																</div>
															</td>
														</tr>
													</table>
													<hr>
												</div>
											</c:forEach>
										</div>
									</div>
								</div>
								<div id="messageFooter" class="notificationFooter">
									<button onclick="showmore()" class="btn btn-link">see all</button>
								</div>
							</div>
						</li>
						<li id="notification_li">
							<span id="notification_count" class="notification_count" style="display: none;">3</span>
							<a href="#" id="notificationLink" role="button">
								<i class="glyphicon glyphicon-bell"></i>
								Notifications
								<span class="badge">${fn:length(notificationObjects)}</span>
							</a>
							<div id="notificationContainer" class="notificationContainer" style="display: none; width: 500px">
								<div id="notificationTitle" class="notificationTitle">Notifications</div>
								<div id="notificationsBody" class="notificationsBody notifications">
									<div class="panel panel-default">
										<c:forEach var="object" items="${notificationObjects}">
											<c:set var="text" value="sent you a friend request"></c:set>
											<c:set var="type" value="request"></c:set>
											<div class="panel-body" id="${object.notificationId}div">
												<div>
													<table>
														<tr>
															<td width="300px">
																<img src="${object.senderProfile.profilePic}" class="addfrndimg" />
																<span>
																	<strong>
																		<a href="${pageContext.request.contextPath}/profile/${object.senderProfile.userId}"> ${object.senderProfile.firstname} ${object.senderProfile.lastname} </a>
																	</strong>
																</span>
																<br>
																<span>${text}</span>
																<br />
															</td>
															<td class="addfrndtd">
																<div class="btn-group btn-group-lg ">
																	<c:if test="${type eq 'request'}">
																		<button value="accept" onclick="sendRequest(this,this.value,'${object.senderProfile.userId}')" class="btn-default ${object.notificationId}accept">accept</button>
																		<button value="decline" onclick="sendRequest(this,this.value,'${object.senderProfile.userId}')" class="btn-default ${object.notificationId}decline">decline</button>
																	</c:if>
																</div>
															</td>
														</tr>
													</table>
												</div>
												<hr>
											</div>
										</c:forEach>
									</div>
								</div>
								<div id="notificationFooter" class="notificationFooter">
									<a href="#">thats all</a>
								</div>
							</div>
						</li>
						<li>
							<a href="${pageContext.request.contextPath}/home">
								<i class="glyphicon glyphicon-home"></i>
								Home
							</a>
						</li>
						<li>
							<button id="addClass" type="submit" class="btn btn-link mylink">
								<span class="glyphicon glyphicon-comment"> </span>
								chat
							</button>
						</li>
						<li>
							<form action="${pageContext.request.contextPath}/logout" method="post">
								<button type="submit" class="btn btn-link mylink">
									<span class="glyphicon glyphicon-log-in"> </span>
									logout
								</button>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
							</form>
						</li>
					</ul>
				</nav>
			</div>
			<!-- /top nav -->
			<fmt:formatDate value="${profile.dob}" var="myVar" type="date" pattern="yyyy-MM-dd" />
			<div class="padding">
				<div class="full col-sm-12">
					<!-- content -->
					<div class="row">
						<div class="col-sm-3" id="sidebar">
							<!-- Contenedor -->
							<ul id="accordion" class="accordion">
								<li>
									<div class="col col_4 iamgurdeep-pic">
										<img class="img-responsive myimage" alt="myimage" id="mybigprofileimage" src="${profile.profilePic}">
										<a href="${pageContext.request.contextPath}/profileedit/" class="username">${profile.firstname} ${profile.lastname}</a>
									</div>
								</li>
								<li class="default open">
									<div class="link">
										<i class="fa fa-globe"></i>
										About
										<i class="fa fa-chevron-down"></i>
									</div>
									<ul class="submenu">
										<li>
											<a href="#"> Date of Birth : ${myVar}</a>
										</li>
										<c:if test="${!empty profile.work}">
											<li>
												<a href="#">Address : ${profile.homeTown}</a>
											</li>
										</c:if>
										<c:if test="${!empty profile.work}">
											<li>
												<a href="#">work:${profile.work}</a>
											</li>
										</c:if>
										<c:if test="${!empty profile.phone}">
											<li>
												<a href="#">Phone : ${profile.phone}</a>
											</li>
										</c:if>
									</ul>
								</li>
								<li class="default open">
									<div class="link">
										<i class="fa fa-picture-o"></i>
										Photos
										<i class="fa fa-chevron-down"></i>
									</div>
									<ul class="submenu">
										<li class="photos">
											<c:forEach var="product" items="${products}">
												<c:set var="my" value="${product.images}" />
												<c:if test="${my ne ''}">
													<c:set var="fileParts" value="${fn:split(my,';')}" />
													<c:forEach var="files" items="${fileParts}">
														<a href="#">
															<img class="img-responsive myimage" alt="myimage" src="${files}">
														</a>
													</c:forEach>
												</c:if>
											</c:forEach>
										</li>
									</ul>
								</li>
								<li class="default open">
									<div class="link">
										<i class="fa fa-users"></i>
										Friends
										<i class="fa fa-chevron-down"></i>
									</div>
									<ul class="submenu">
										<li class="photos">
											<c:forEach var="friend" items="${friends}">
												<a href="${pageContext.request.contextPath}/profile/${friend.userId}">
													<img class="img-responsive myimage" alt="myimage" src="${friend.profilePic}">
													${friend.firstname}
												</a>
											</c:forEach>
										</li>
									</ul>
								</li>
							</ul>
						</div>
						<div class="col-sm-4">
							<div class="text-center">
								<img src="${profile.profilePic}" class="avatar img-circle img-thumbnail" alt="avatar" id="myprofileimage">
								<h6>Upload a different photo...</h6>
								<div class="center-block">
									<div class="custom1">
										<div class="col-lg-12 col-md-12 col-sm-12">
											<input type="file" id="main-input" class="form-control form-input form-style-base" name="file">
											<h4 id="fake-btn" class="form-input fake-styled-btn text-center truncate">
												<span class="margin"> Choose File</span>
											</h4>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- main col right -->
						<div class="col-sm-5">
							<div class="gear">
								<label>First Name:</label>
								<span id="firstname" class="datainfo">${profile.firstname} </span>
								<a href="#" class="editlink">Edit Info</a>
								<a class="savebtn">Save</a>
								<a class="cancelbtn">cancel</a>
							</div>
							<div class="gear">
								<label>last Name:</label>
								<span id="lastname" class="datainfo">${profile.lastname}</span>
								<a href="#" class="editlink">Edit Info</a>
								<a class="savebtn">Save</a>
								<a class="cancelbtn">cancel</a>
							</div>
							<div class="gear">
								<label>your email:</label>
								<span id="mail" class="datainfo">${profile.mail}</span>
								<a href="#" class="editlink">Edit Info</a>
								<a class="savebtn">Save</a>
								<a class="cancelbtn">cancel</a>
							</div>
							<div class="gear">
								<label>password:</label>
								<span id="password" class="datainfo">***********</span>
								<a href="#" class="editlink">Edit Info</a>
								<a class="savebtn">Save</a>
								<a class="cancelbtn">cancel</a>
							</div>
							<div class="gear">
								<label>date of birth:</label>
								<span id="dob" class="datainfo">${myVar}</span>
								<a href="#" class="editlink">Edit Info</a>
								<a class="savebtn">Save</a>
								<a class="cancelbtn">cancel</a>
							</div>
							<div class="gear">
								<label>Gender:</label>
								<span id="gender" class="datainfo">${profile.gender}</span>
								<a href="#" class="editlink">Edit Info</a>
								<a class="savebtn">Save</a>
								<a class="cancelbtn">cancel</a>
							</div>
							<c:if test="${empty profile.highSchool}">
								<c:set var="name" value="empty"></c:set>
							</c:if>
							<c:if test="${not empty profile.highSchool}">
								<c:set var="name" value="notempty"></c:set>
							</c:if>
							<div class="gear">
								<label>highschool:</label>
								<span id="highSchool" class="datainfo ${name}">
									<c:if test="${empty profile.highSchool}">
    where you studied at highschool?
</c:if>
									<c:if test="${not empty profile.highSchool}">
    ${profile.highSchool}
</c:if>
								</span>
								<a href="#" class="editlink">Edit Info</a>
								<a class="savebtn">Save</a>
								<a class="cancelbtn">cancel</a>
							</div>
							<c:if test="${empty profile.college}">
								<c:set var="name" value="empty"></c:set>
							</c:if>
							<c:if test="${not empty profile.college}">
								<c:set var="name" value="notempty"></c:set>
							</c:if>
							<div class="gear">
								<label>college:</label>
								<span id="college" class="datainfo ${name}">
									<c:if test="${empty profile.college}">
    where is your college?
</c:if>
									<c:if test="${not empty profile.college}">
    ${profile.college}
</c:if>
								</span>
								<a href="#" class="editlink">Edit Info</a>
								<a class="savebtn">Save</a>
								<a class="cancelbtn">cancel</a>
							</div>
							<c:if test="${empty profile.work}">
								<c:set var="name" value="empty"></c:set>
							</c:if>
							<c:if test="${not empty profile.work}">
								<c:set var="name" value="notempty"></c:set>
							</c:if>
							<div class="gear">
								<label>work:</label>
								<span id="work" class="datainfo ${name}">
									<c:if test="${empty profile.work}">
    where do you work?
</c:if>
									<c:if test="${not empty profile.work}">
    ${profile.work}
</c:if>
								</span>
								<a href="#" class="editlink">Edit Info</a>
								<a class="savebtn">Save</a>
								<a class="cancelbtn">cancel</a>
							</div>
							<c:if test="${empty profile.about}">
								<c:set var="name" value="empty"></c:set>
							</c:if>
							<c:if test="${not empty profile.about}">
								<c:set var="name" value="notempty"></c:set>
							</c:if>
							<div class="gear">
								<label>about:</label>
								<span id="about" class="datainfo ${name}">
									<c:if test="${empty profile.about}">
    write something about yourself.
</c:if>
									<c:if test="${not empty profile.about}">
    ${profile.about}
</c:if>
								</span>
								<a href="#" class="editlink">Edit Info</a>
								<a class="savebtn">Save</a>
								<a class="cancelbtn">cancel</a>
							</div>
							<c:if test="${empty profile.quote}">
								<c:set var="name" value="empty"></c:set>
							</c:if>
							<c:if test="${not empty profile.quote}">
								<c:set var="name" value="notempty"></c:set>
							</c:if>
							<div class="gear">
								<label>quote:</label>
								<span id="quote" class="datainfo ${name}">
									<c:if test="${empty profile.quote}">
    what is your favourite quote?
</c:if>
									<c:if test="${not empty profile.quote}">
    ${profile.quote}
</c:if>
								</span>
								<a href="#" class="editlink">Edit Info</a>
								<a class="savebtn">Save</a>
								<a class="cancelbtn">cancel</a>
							</div>
							<c:if test="${empty profile.interest}">
								<c:set var="name" value="empty"></c:set>
							</c:if>
							<c:if test="${not empty profile.interest}">
								<c:set var="name" value="notempty"></c:set>
							</c:if>
							<div class="gear">
								<label>interest:</label>
								<span id="interest" class="datainfo ${name}">
									<c:if test="${empty profile.interest}">
    what is your interest?
</c:if>
									<c:if test="${not empty profile.interest}">
    ${profile.interest}
</c:if>
								</span>
								<a href="#" class="editlink">Edit Info</a>
								<a class="savebtn">Save</a>
								<a class="cancelbtn">cancel</a>
							</div>
							<c:if test="${empty profile.religious}">
								<c:set var="name" value="empty"></c:set>
							</c:if>
							<c:if test="${not empty profile.religious}">
								<c:set var="name" value="notempty"></c:set>
							</c:if>
							<div class="gear">
								<label>religious:</label>
								<span id="religious" class="datainfo ${name}">
									<c:if test="${empty profile.religious}">
    what is your religious view?
</c:if>
									<c:if test="${not empty profile.religious}">
    ${profile.religious}
</c:if>
								</span>
								<a href="#" class="editlink">Edit Info</a>
								<a class="savebtn">Save</a>
								<a class="cancelbtn">cancel</a>
							</div>
							<c:if test="${empty profile.phone}">
								<c:set var="name" value="empty"></c:set>
							</c:if>
							<c:if test="${not empty profile.phone}">
								<c:set var="name" value="notempty"></c:set>
							</c:if>
							<div class="gear">
								<label>phone:</label>
								<span id="phone" class="datainfo ${name}">
									<c:if test="${empty profile.phone}">
    what is your phone number?
</c:if>
									<c:if test="${not empty profile.phone}">
    ${profile.phone}
</c:if>
								</span>
								<a href="#" class="editlink">Edit Info</a>
								<a class="savebtn">Save</a>
								<a class="cancelbtn">cancel</a>
							</div>
							<c:if test="${empty profile.currentCity}">
								<c:set var="name" value="empty"></c:set>
							</c:if>
							<c:if test="${not empty profile.currentCity}">
								<c:set var="name" value="notempty"></c:set>
							</c:if>
							<div class="gear">
								<label>currentcity:</label>
								<span id="currentCity" class="datainfo ${name}">
									<c:if test="${empty profile.currentCity}">
    where do you live?
</c:if>
									<c:if test="${not empty profile.currentCity}">
    ${profile.currentCity}
</c:if>
								</span>
								<a href="#" class="editlink">Edit Info</a>
								<a class="savebtn">Save</a>
								<a class="cancelbtn">cancel</a>
							</div>
							<c:if test="${empty profile.homeTown}">
								<c:set var="name" value="empty"></c:set>
							</c:if>
							<c:if test="${not empty profile.homeTown}">
								<c:set var="name" value="notempty"></c:set>
							</c:if>
							<div class="gear">
								<label>hometown:</label>
								<span id="homeTown" class="datainfo ${name}">
									<c:if test="${empty profile.homeTown}">
    where is your hometown?
</c:if>
									<c:if test="${not empty profile.homeTown}">
    ${profile.homeTown}
</c:if>
								</span>
								<a href="#" class="editlink">Edit Info</a>
								<a class="savebtn">Save</a>
								<a class="cancelbtn">cancel</a>
							</div>
							<c:if test="${empty profile.relationStatus}">
								<c:set var="name" value="empty"></c:set>
							</c:if>
							<c:if test="${not empty profile.relationStatus}">
								<c:set var="name" value="notempty"></c:set>
							</c:if>
							<div class="gear">
								<label>relationstatus:</label>
								<span id="relationStatus" class="datainfo ${name}">
									<c:if test="${empty profile.relationStatus}">
    what is your relation status?
</c:if>
									<c:if test="${not empty profile.relationStatus}">
    ${profile.relationStatus}
</c:if>
								</span>
								<a href="#" class="editlink">Edit Info</a>
								<a class="savebtn">Save</a>
								<a class="cancelbtn">cancel</a>
							</div>
						</div>
						<div class="col-sm-3">
							<!--chat box-->
							<div class="fix" id="sidebar_secondary">
								<div class="popup-head">
									<div class="popup-head-left pull-left">
										<img class="md-user-image" alt="Gurdeep Osahan (Web Designer)" src="${pageContext.request.contextPath}/resources/images/avatar.png">
									</div>
									<div class="popup-head-right pull-right">
										<button class="chat-header-button" type="button">
											<i class="glyphicon glyphicon-facetime-video"></i>
										</button>
										<button class="chat-header-button" type="button">
											<i class="glyphicon glyphicon-earphone"></i>
										</button>
										<div class="btn-group gurdeepoushan">
											<button class="chat-header-button" data-toggle="dropdown" type="button" aria-expanded="false">
												<i class="glyphicon glyphicon-paperclip"></i>
											</button>
										</div>
										<button data-widget="remove" id="removeClass" class="chat-header-button pull-right" type="button">
											<i class="glyphicon glyphicon-remove"></i>
										</button>
									</div>
								</div>
								<div id="chat" class="chat_box_wrapper chat_box_small chat_box_active" style="opacity: 1; display: block; transform: translateX(0px);">
									<div class="chat_box touchscroll chat_box_colors_a">
										<div class="chat_message_wrapper">
											<div class="chat_user_avatar">
												<img class="md-user-image" alt="Gurdeep Osahan (Web Designer)" src="${pageContext.request.contextPath}/resources/images/avatar.png">
											</div>
											<ul class="chat_message">
												<li>
													<p>chat is not implemented</p>
												</li>
												<li>
													<p>
														i know chat is not implemented.
														<span class="chat_message_time">13:38</span>
													</p>
												</li>
											</ul>
										</div>
										<div class="chat_message_wrapper chat_message_right">
											<div class="chat_user_avatar">
												<img class="md-user-image" alt="Gurdeep Osahan (Web Designer)" src="${pageContext.request.contextPath}/resources/images/avatar.png">
											</div>
											<ul class="chat_message">
												<li>
													<p>
														so what if it is not everything else is working
														<span class="chat_message_time">13:34</span>
													</p>
												</li>
											</ul>
										</div>
										<div class="chat_message_wrapper">
											<div class="chat_user_avatar">
												<img class="md-user-image" alt="Gurdeep Osahan (Web Designer)" src="${pageContext.request.contextPath}/resources/images/avatar.png">
											</div>
											<ul class="chat_message">
												<li>
													<p>
														yeah i know
														<span class="chat_message_time">23 Jun 1:10am</span>
													</p>
												</li>
											</ul>
										</div>
										<div class="chat_message_wrapper chat_message_right">
											<div class="chat_user_avatar">
												<img class="md-user-image" alt="Gurdeep Osahan (Web Designer)" src="${pageContext.request.contextPath}/resources/images/avatar.png">
											</div>
											<ul class="chat_message">
												<li>
													<p>i will try to implement chat as well.</p>
												</li>
												<li>
													<p>
														very soon
														<span class="chat_message_time">Friday 13:34</span>
													</p>
												</li>
											</ul>
										</div>
									</div>
								</div>
								<div class="chat_submit_box">
									<div class="uk-input-group">
										<div class="gurdeep-chat-box">
											<span style="vertical-align: sub;" class="uk-input-group-addon">
												<i class="fa fa-camera" style="cursor: pointer;" id="chaticon"></i>
												<input type="file" name="" id="chatimage" style="display: none;">
											</span>
											<span style="display: inline; float: right;" class="uk-input-group-addon">
												<textarea placeholder="Type a message" style="height: 50px;" id="submit_message" name="submit_message" class="md-input"></textarea>
												<a href="#">
													<i class="glyphicon glyphicon-send" style="color: red;"></i>
												</a>
											</span>
										</div>
									</div>
								</div>
							</div>
							<!--chat box finish-->
						</div>
					</div>
					<!--/row-->
				</div>
				<!--container ends -->
			</div>
			<!-- /padding -->
		</div>
		<!-- /main -->
		<div style="display: none;" id="main-inputUploadSection"></div>
		<!-- dont delete this div else listfiles() will cause error -->
	</div>
	<!--row-->
</body>
</html>
