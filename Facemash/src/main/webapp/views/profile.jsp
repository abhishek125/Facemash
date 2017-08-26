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
<title>view user profile</title>
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
									<div class="panel panel-default" style="overflow: scroll;">
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
									<div class="panel panel-default" style="overflow: scroll;">
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
			<div class="full col-sm-12">
				<c:set var="user" value="${profile}"></c:set>
				<!-- content -->
				<div class="row">
					<div class="col-sm-3" id="sidebar">
						<c:set var="block" value="block"></c:set>
						<c:if test="${myfn:contains(blocked,user.userId)}">
							<c:set var="block" value="unblock"></c:set>
						</c:if>
						<c:set var="request" value="add"></c:set>
						<c:set var="id" value="${user.userId}"></c:set>
						<c:if test="${myfn:contains(myFriendSet,user.userId)}">
							<c:set var="request" value="unfriend"></c:set>
						</c:if>
						<c:if test="${not empty sentRequest[user.userId]}">
							<c:set var="request" value="cancel"></c:set>
							<c:set var="id" value="${sentRequest[user.userId]}"></c:set>
						</c:if>
						<c:if test="${not empty receivedRequest[user.userId]}">
							<c:set var="request" value="accept"></c:set>
							<c:set var="id" value="${receivedRequest[user.userId]}"></c:set>
						</c:if>
						<fmt:formatDate value="${profile.dob}" var="myVar" type="date" pattern="yyyy-MM-dd" />
						<!-- Contenedor -->
						<ul id="accordion" class="accordion">
							<li>
								<div class="col col_4 iamgurdeep-pic">
									<img class="img-responsive myimage" alt="myimage" src="${profile.profilePic}">
									<div class="username">
										<h2>${profile.firstname} ${profile.lastname}</h2>
										<!-- <a href="https://web.facebook.com/myimage" target="_blank"
           class=""> <i class="fa fa-user-plus"></i> Add Friend
          </a> -->
										<button type="button" value="${request}" class="btn-default ${id}${request}" onclick="sendRequest(this,this.value,'${user.userId}')">
											<i class="fa fa-user-plus"></i>
											<c:if test="${request eq 'add'}">add friend</c:if>
											<c:if test="${request eq 'cancel'}">cancel request</c:if>
											<c:if test="${request eq 'unfriend'}">unfriend</c:if>
											<c:if test="${request eq 'accept'}">accept</c:if>
										</button>
										<ul class="nav navbar-nav">
											<li class="dropdown">
												<a href="#" class="dropdown-toggle" data-toggle="dropdown">
													<span class="fa fa-ellipsis-v pull-right"></span>
												</a>
												<ul class="dropdown-menu pull-right">
													<li>
														<button id="${user.userId}message" onclick="messaged(this.id)" class="btn btn-link">message</button>
													</li>
													<li>
														<button id="${user.userId}${block}" value="${block}" onclick="block(this.id,this.value)" class="btn btn-link">${block}</button>
													</li>
													<c:if test="${request eq 'accept'}">
														<li>
															<button value="decline" onclick="sendRequest(this,this.value,'${user.userId}')" class="btn btn-link ${id}decline">decline</button>
														</li>
													</c:if>
												</ul>
											</li>
										</ul>
									</div>
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
									<c:if test="${!empty profile.currentCity}">
										<li>
											<a href="#">Address : ${profile.currentCity}</a>
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
									User's Photos
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
									User's Friends
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
					<!-- main col left -->
					<div class="col-sm-6">
						<c:forEach var="activity" items="${activities}">
							<c:if test="${activity.activityType eq 'STATUS'}">
								<c:set var="text" value="uploaded his status"></c:set>
							</c:if>
							<c:if test="${activity.activityType eq 'LIKE'}">
								<c:set var="text" value="liked a post"></c:set>
							</c:if>
							<c:if test="${activity.activityType eq 'SHARE'}">
								<c:set var="text" value="shared a post"></c:set>
							</c:if>
							<div class="panel panel-default">
								<div class="panel-heading">
									<span class="pull-right"> ${activity.date} </span>
									<h4>
										<a href="${pageContext.request.contextPath}/profile/${activity.profile.userId}"> ${activity.profile.firstname} ${activity.profile.lastname} ${text}</a>
									</h4>
								</div>
								<div class="panel-body">
									${activity.product.textData}
									<div id="image${activity.activityId}" class="carousel slide" data-interval="false">
										<!-- Indicators -->
										<!-- Wrapper for slides -->
										<c:if test="${activity.product.images ne '' || activity.product.videos ne ''}">
											<div class="carousel-inner" style="background: black;">
												<c:if test="${activity.product.images ne ''}">
													<c:set var="my" value="${activity.product.images}" />
													<c:set var="fileParts" value="${fn:split(my,';')}" />
													<c:forEach var="files" items="${fileParts}">
														<div class="item">
															<img class="img-responsive" style="margin-left: 0px; width: 100%; height: 400px" alt="myimage" src="${files}">
														</div>
													</c:forEach>
												</c:if>
												<c:if test="${activity.product.videos ne ''}">
													<c:set var="my" value="${activity.product.videos}" />
													<c:set var="fileParts" value="${fn:split(my,';')}" />
													<c:forEach var="video" items="${fileParts}">
														<div class="item">
															<video style="margin-left: 0px" width="100%" height="400px" controls>
																<source src="${video}" type="video/mp4">
															</video>
														</div>
													</c:forEach>
												</c:if>
												<!-- Left and right controls -->
												<a class="left carousel-control" href="#image${activity.activityId}" data-slide="prev" style="height: 300px;">
													<span class="glyphicon glyphicon-chevron-left"></span>
													<span class="sr-only">Previous</span>
												</a>
												<a class="right carousel-control" href="#image${activity.activityId}" data-slide="next" style="height: 300px;">
													<span class="glyphicon glyphicon-chevron-right"></span>
													<span class="sr-only">Next</span>
												</a>
											</div>
										</c:if>
										<hr>
									</div>
									<div id="video${activity.product.productId}" class="carousel slide" data-interval="false"></div>
									<c:set var="liked" value="like"></c:set>
									<c:if test="${fn:contains(likes,activity.product.productId)}">
										<c:set var="liked" value="unlike"></c:set>
									</c:if>
									<c:set var="shared" value="share"></c:set>
									<c:if test="${fn:contains(shares,activity.product.productId)}">
										<c:set var="shared" value="unshare"></c:set>
									</c:if>
									<div style="margin-bottom: 20px;">
										<button class="btn  btn-primary ${activity.product.productId}likebtn" style="margin-left: 30px;" value="${liked}" onclick="updateProduct('${activity.product.productId}',this.value)">
											<i class="fa fa-thumbs-up ${activity.product.productId}likesign" id="">${liked}</i>
											<span class="badge ${activity.product.productId}like">${activity.product.likes}</span>
										</button>
										<button class="btn  btn-success" style="margin-left: 30px;" onclick="showComments('${activity.activityId}')">
											<i class="fa fa-comment">comment</i>
											<span class="badge ${activity.product.productId}comment">${activity.product.comments}</span>
										</button>
										<button class="btn  btn-info ${activity.product.productId}sharebtn" style="margin-left: 30px;" value="${shared}" onclick="updateProduct('${activity.product.productId}',this.value)">
											<i class="fa fa-share ${activity.product.productId}sharesign">${shared}</i>
											<span class="badge ${activity.product.productId}share">${activity.product.shares}</span>
										</button>
									</div>
									<div class="main-holder ${activity.product.productId}commentsection" id="${activity.activityId}commentsection" style="display: none;">
										<!-- <div id="show-more">
          <span><button class="btn btn-link" onclick="otherComments('${activity.activityId}')">show more comments</button> <span
           class="ajax-loading"></span></span>
         </div> -->
										<!-- force quirks mode by using the xml pro-logue -->
										<c:set var="myComments" value="${userComments[activity.product.productId]}"></c:set>
										<c:set var="otherComments" value="${allComments[activity.product.productId]}"></c:set>
										<c:if test="${not empty myComments}">
											<c:forEach var="commentActivity" items="${myComments}">
												<div class="outer">
													<div class="inner">
														<img src="${commentActivity.profile.profilePic}" class="mythumbnail">
													</div>
													<div>
														<div>
															<a href="${pageContext.request.contextPath}/profile/${commentActivity.profile.userId}"> ${commentActivity.profile.firstname} ${commentActivity.profile.lastname} </a>
															<br />
															${commentActivity.text}
														</div>
													</div>
													<br style="clear: both">
												</div>
											</c:forEach>
										</c:if>
										<div style="display: none;" id="${activity.activityId}othercomments">
											<c:if test="${not empty otherComments}">
												<c:forEach var="commentActivity" items="${otherComments}">
													<div class="outer">
														<div class="inner">
															<img src="${commentActivity.profile.profilePic}" class="mythumbnail">
														</div>
														<div>
															<div>
																<a href="${pageContext.request.contextPath}/profile/${commentActivity.profile.userId}"> ${commentActivity.profile.firstname} ${commentActivity.profile.lastname} </a>
																<br />
																${commentActivity.text}
															</div>
														</div>
														<br style="clear: both">
													</div>
												</c:forEach>
											</c:if>
										</div>
										<div>
											<img src="${loggedInUser.profilePic}" class="mythumbnail">
											<form>
												<textarea id="${activity.activityId}commentarea" class="lightText commentarea"></textarea>
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
												<input class="send-button" id="${activity.activityId}" value="done" type="button" onclick="
          submitComment('${activity.product.productId}commentform','${loggedInUser.profilePic}',
          '${loggedInUser.firstname} ${loggedInUser.lastname}','${activity.activityId}')">
											</form>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
						<c:forEach var="entry" items="${myCommentGroup}">
							<c:set var="listOfCommentActivities" value="${entry.value}"></c:set>
							<c:forEach var="activity" items="${listOfCommentActivities}">
							<%-- <c:set var="activity" value="${listOfCommentActivities[0]}"></c:set> --%>
							<div class="panel panel-default">
								<div class="panel-heading">
									<span class="pull-right"> ${activity.date} </span>
									<h4>
										<a href="${pageContext.request.contextPath}/profile/${activity.profile.userId}"> ${activity.profile.firstname} ${activity.profile.lastname} commented on a post</a>
									</h4>
								</div>
								<div class="panel-body">
									${activity.product.textData}
									<div id="image${activity.activityId}" class="carousel slide" data-interval="false">
										<!-- Indicators -->
										<!-- Wrapper for slides -->
										<c:if test="${activity.product.images ne '' || activity.product.videos ne ''}">
											<div class="carousel-inner" style="background: black;">
												<c:if test="${activity.product.images ne ''}">
													<c:set var="my" value="${activity.product.images}" />
													<c:set var="fileParts" value="${fn:split(my,';')}" />
													<c:forEach var="files" items="${fileParts}">
														<div class="item">
															<img class="img-responsive" style="margin-left: 0px; width: 100%; height: 400px" alt="myimage" src="${files}">
														</div>
													</c:forEach>
												</c:if>
												<c:if test="${activity.product.videos ne ''}">
													<c:set var="my" value="${activity.product.videos}" />
													<c:set var="fileParts" value="${fn:split(my,';')}" />
													<c:forEach var="video" items="${fileParts}">
														<div class="item">
															<video style="margin-left: 0px" width="100%" height="400px" controls>
																<source src="${video}" type="video/mp4">
															</video>
														</div>
													</c:forEach>
												</c:if>
												<!-- Left and right controls -->
												<a class="left carousel-control" href="#image${activity.activityId}" data-slide="prev" style="height: 300px;">
													<span class="glyphicon glyphicon-chevron-left"></span>
													<span class="sr-only">Previous</span>
												</a>
												<a class="right carousel-control" href="#image${activity.activityId}" data-slide="next" style="height: 300px;">
													<span class="glyphicon glyphicon-chevron-right"></span>
													<span class="sr-only">Next</span>
												</a>
											</div>
										</c:if>
										<hr>
									</div>
									<div id="video${activity.product.productId}" class="carousel slide" data-interval="false"></div>
									<c:set var="liked" value="like"></c:set>
									<c:if test="${fn:contains(likes,activity.product.productId)}">
										<c:set var="liked" value="unlike"></c:set>
									</c:if>
									<c:set var="shared" value="share"></c:set>
									<c:if test="${fn:contains(shares,activity.product.productId)}">
										<c:set var="shared" value="unshare"></c:set>
									</c:if>
									<div style="margin-bottom: 20px;">
										<button class="btn  btn-primary ${activity.product.productId}likebtn" style="margin-left: 30px;" value="${liked}" onclick="updateProduct('${activity.product.productId}',this.value)">
											<i class="fa fa-thumbs-up ${activity.product.productId}likesign" id="">${liked}</i>
											<span class="badge ${activity.product.productId}like">${activity.product.likes}</span>
										</button>
										<button class="btn  btn-success" style="margin-left: 30px;" onclick="showComments('${activity.activityId}')">
											<i class="fa fa-comment">comment</i>
											<span class="badge ${activity.product.productId}comment">${activity.product.comments}</span>
										</button>
										<button class="btn  btn-info ${activity.product.productId}sharebtn" style="margin-left: 30px;" value="${shared}" onclick="updateProduct('${activity.product.productId}',this.value)">
											<i class="fa fa-share ${activity.product.productId}sharesign">${shared}</i>
											<span class="badge ${activity.product.productId}share">${activity.product.shares}</span>
										</button>
									</div>
									<div class="main-holder ${activity.product.productId}commentsection" id="${activity.activityId}commentsection" style="display: none;">
										<!--    <div id="show-more">
          <span><button class="btn btn-link" onclick="otherComments('${activity.activityId}')">show more comments</button> <span
           class="ajax-loading"></span></span>
         </div> -->
										<c:set var="myComments" value="${userComments[activity.product.productId]}"></c:set>
										<c:set var="otherComments" value="${allComments[activity.product.productId]}"></c:set>
										<c:if test="${not empty myComments}">
											<c:forEach var="commentActivity" items="${myComments}">
												<div class="outer">
													<div class="inner">
														<img src="${commentActivity.profile.profilePic}" class="mythumbnail">
													</div>
													<div>
														<div>
															<a href="${pageContext.request.contextPath}/profile/${commentActivity.profile.userId}"> ${commentActivity.profile.firstname} ${commentActivity.profile.lastname} </a>
															<br />
															${commentActivity.text}
														</div>
													</div>
													<br style="clear: both">
												</div>
											</c:forEach>
										</c:if>
										<c:forEach var="commentActivity" items="${listOfCommentActivities}">
											<c:if test="${commentActivity.product.productId eq activity.product.productId}">
												<div class="outer">
													<div class="inner">
														<img src="${commentActivity.profile.profilePic}" class="mythumbnail">
													</div>
													<div>
														<div>
															<a href="${pageContext.request.contextPath}/profile/${commentActivity.profile.userId}"> ${commentActivity.profile.firstname} ${commentActivity.profile.lastname} </a>
															<br />
															${commentActivity.text}
														</div>
													</div>
													<br style="clear: both">
												</div>
											</c:if>
										</c:forEach>
										<div style="display: none;" id="${activity.activityId}othercomments">
											<c:if test="${not empty otherComments}">
												<c:forEach var="commentActivity" items="${otherComments}">
													<div class="outer">
														<div class="inner">
															<img src="${commentActivity.profile.profilePic}" class="mythumbnail">
														</div>
														<div>
															<div>
																<a href="${pageContext.request.contextPath}/profile/${commentActivity.profile.userId}"> ${commentActivity.profile.firstname} ${commentActivity.profile.lastname} </a>
																<br />
																${commentActivity.text}
															</div>
														</div>
														<br style="clear: both">
													</div>
												</c:forEach>
											</c:if>
										</div>
										<div>
											<img src="${loggedInUser.profilePic}" class="mythumbnail">
											<form>
												<textarea id="${activity.activityId}commentarea" class="lightText commentarea"></textarea>
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
												<input class="send-button" id="${activity.product.productId}commentform" value="done" type="button" onclick="submitComment(this.id,'${loggedInUser.profilePic}','${loggedInUser.firstname} ${loggedInUser.lastname}',
          '${activity.activityId}')">
											</form>
										</div>
									</div>
								</div>
							</div>
							</c:forEach>
						</c:forEach>
						<div style="text-align: center;">
							<strong>no more feeds from this user</strong>
						</div>
					</div>
					<!-- main col right -->
					<div class="col-sm-3">
						<!-- friends suggestions -->
						<div>
							<div class="panel panel-default">
								<div class="panel-body">
									<c:if test="${empty suggestions}">
										<p>no suggestions to show</p>
									</c:if>
									<c:forEach var="user" items="${suggestions}">
										<div>
											<table>
												<tr>
													<td width="200px">
														<img src="${user.profilePic}" class="suggestImg" />
														<span>
															<strong>
																<a href="${pageContext.request.contextPath}/profile/${user.userId}">${user.firstname} ${user.lastname}</a>
															</strong>
														</span>
													</td>
													<c:set var="block" value="block"></c:set>
													<c:if test="${myfn:contains(blocked,user.userId)}">
														<c:set var="block" value="unblock"></c:set>
													</c:if>
													<c:set var="request" value="add"></c:set>
													<c:set var="id" value="${user.userId}"></c:set>
													<td class="addfrndtd">
														<div class="btn-group btn-group-lg" role="group">
															<button type="button" value="${request}" class="btn-default ${id}${request}" style="" onclick="sendRequest(this,this.value,'${user.userId}')">
																<c:if test="${request eq 'add'}">add friend</c:if>
															</button>
															<button type="button" class=" btn-default " style="" data-toggle="dropdown">
																<span class="caret"></span>
															</button>
															<ul class="dropdown-menu" role="menu">
																<li>
																	<button id="${user.userId}message" onclick="messaged(this.id)" class="btn btn-link">message</button>
																</li>
																<li>
																	<button id="${user.userId}${block}" value="${block}" onclick="block(this.id,this.value)" class="btn btn-link">${block}</button>
																</li>
															</ul>
														</div>
													</td>
												</tr>
											</table>
										</div>
										<hr>
									</c:forEach>
								</div>
							</div>
						</div>
						<!-- friend suggestion ends -->
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
										<span style="display: inline; float: right; height: 50px" class="uk-input-group-addon">
											<textarea placeholder="Type a message" id="submit_message" name="submit_message" class="md-input"></textarea>
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
				<!--row-->
			</div>
			<!-- col-12 ends -->
		</div>
		<!--main ends  -->
	</div>
	<div id="messageModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">*</button>
					send message
				</div>
				<div class="modal-body">
					<div>
						<form class="form center-block form-horizontal" method="post" role="form" id="messageForm" enctype="multipart/form-data" action="${pageContext.request.contextPath}/sendmessage">
							<textarea class="form-control input-lg" autofocus="autofocus" placeholder="What do you want to share?" id="message"></textarea>
							<div id="myVideoUploadSection"></div>
							<div id="myImageUploadSection"></div>
							<div id="dynamic"></div>
							<div class="modal-footer">
								<div>
									<input class="btn btn-primary pull-right" type="submit" value="post">
									<ul class="pull-left list-inline">
										<li>
											<button class="mybutton" type="button" id="fancyuploadvideo">
												<i class="glyphicon glyphicon-facetime-video"></i>
											</button>
											<input type="file" id="myVideo" multiple="multiple" style="display: none" accept="video/mp4,video/x-m4v,video/*" />
										</li>
										<li>
											<button class="mybutton" type="button" id="fancyuploadimage">
												<i class="glyphicon glyphicon-camera"></i>
											</button>
											<input type="file" id="myImage" multiple="multiple" style="display: none" accept="image/x-png,image/gif,image/jpeg" />
										</li>
									</ul>
									<input type="hidden" value="${profile.userId}" id="userId" />
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div id="dynamic"></div>
		</div>
	</div>
</body>
</html>
