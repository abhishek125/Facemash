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
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<link
 href="${pageContext.request.contextPath}/resources/css/bootstrap.css"
 rel="stylesheet">
<link
 href="${pageContext.request.contextPath}/resources/css/font-awesome.min.css"
 rel="stylesheet">

<link
 href="${pageContext.request.contextPath}/resources/css/jquery-ui.min.css"
 rel="stylesheet">
<!--[if lt IE 9]>
          <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
<link
 href="${pageContext.request.contextPath}/resources/css/facebook.css"
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
 src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
<script
 src="${pageContext.request.contextPath}/resources/js/searchbox.js"></script>
</head>
<body>

 <div class="row ">

  <div class="col-sm-12 col-md-12" id="main">
   <!-- sidebar -->



   <!-- /sidebar -->

   <!-- main right col -->


   <!-- top nav -->
   <div class="navbar navbar-blue navbar-static-top">
    <div class="navbar-header">
     <button class="navbar-toggle" type="button" data-toggle="collapse"
      data-target=".navbar-collapse">
      <span class="sr-only">Toggle</span> <span class="icon-bar"></span>
      <span class="icon-bar"></span> <span class="icon-bar"></span>
     </button>
     <a href="${pageContext.request.contextPath}/home"
      class="navbar-brand logo">f</a>
    </div>
    <nav class="collapse navbar-collapse" role="navigation">
     <form class="navbar-form navbar-left" method="GET"
      action="${pageContext.request.contextPath}/searchallusers">
      <div class="input-group input-group-sm" style="max-width: 360px;">
       <input class="form-control city" placeholder="Search"
        name="username" id="tagQuery" type="text"
        onFocus="inputFocus(this)" onBlur="inputBlur(this)">

       <div class="input-group-btn">
        <button class="btn btn-default" type="submit">
         <i class="glyphicon glyphicon-search"></i>
        </button>
       </div>
      </div>
      <input type="hidden" name="${_csrf.parameterName}"
       value="${_csrf.token}">
     </form>
     <ul class="nav navbar-nav navbar-right">
      <li id="message_li"><span id="message_count"
       class="notification_count" style="display: none;">3</span> <a
       href="#" id="messageLink" class="notification_li"><i
        class="glyphicon glyphicon-envelope"></i> message <span
        class="badge">${fn:length(unreadMessageObjects)}</span></a>

       <div id="messageContainer" class="notificationContainer"
        style="display: none;width:500px">
        <div id="messageTitle" class="notificationTitle">messages</div>
        <div id="messagesBody" class="notificationsBody notifications">
         <div class="panel panel-default" >
         <strong>unread messages</strong>
          <div class="panel-body" id="newmessages">
           <c:forEach var="object" items="${unreadMessageObjects}">
            <div id="${object.infoId}div">
             <table>
              <tr>
               <td width="300px"><img
                src="${object.senderProfile.profilePic}"
                class="addfrndimg" /> <span> <strong> <a
                  href="${pageContext.request.contextPath}/profile/${object.senderProfile.userId}">
                   ${object.senderProfile.firstname}
                   ${object.senderProfile.lastname} </a>
                </strong></span><br> <span>${object.infoText}</span><br /> <!--show videos and images  -->
                <c:if test="${object.videos ne ''}">
                 <c:set var="my" value="${object.videos}" />
                 <c:set var="fileParts" value="${fn:split(my,';')}" />
                 <c:forEach var="video" items="${fileParts}">
                  <video width="320" height="240" controls>
                   <source src="${video}" type="video/mp4">
                  </video>
                 </c:forEach>
                </c:if> <c:if test="${object.images ne ''}">
                 <c:set var="my" value="${object.images}" />
                 <c:set var="fileParts" value="${fn:split(my,';')}" />
                 <c:forEach var="image" items="${fileParts}">
                  <img src="${image}" class="myimage">
                 </c:forEach>
                </c:if> <!--complete  --></td>
               <td class="addfrndtd">
                <div class="btn-group btn-group-lg ">
                 <button id="${object.infoId}" value="read"
                  onclick="updateMessage(this.id,this.value)"
                  class="btn-default"
                  >
                  mark as read</button>
                 <button id="${object.infoId}"
                  
                  value="delete"
                  onclick="updateMessage(this.id,this.value)"
                  class="btn-default">delete</button>
                </div>
               </td>
              </tr>
             </table>
            <hr>
            </div>
           
           </c:forEach>
          </div>
          <strong>read messages</strong>
          <div class="panel-body" id="oldmessages"
           style="display: none;">
           <c:forEach var="object" items="${readMessageObjects}">
            <div id="${object.infoId}div">
             <table>
              <tr>
               <td width="300px"><img
                src="${object.senderProfile.profilePic}"
                class="addfrndimg" /> <span> <strong> <a
                  href="${pageContext.request.contextPath}/profile/${object.senderProfile.userId}">
                   ${object.senderProfile.firstname}
                   ${object.senderProfile.lastname} </a>
                </strong></span><br> <span>${object.infoText}</span><br /> <!--show videos and images  -->
                <c:if test="${object.videos ne ''}">
                 <c:set var="my" value="${object.videos}" />
                 <c:set var="fileParts" value="${fn:split(my,';')}" />
                 <c:forEach var="video" items="${fileParts}">
                  <video width="320" height="240" controls>
                   <source src="${video}" type="video/mp4">
                  </video>
                 </c:forEach>
                </c:if> <c:if test="${object.images ne ''}">
                 <c:set var="my" value="${object.images}" />
                 <c:set var="fileParts" value="${fn:split(my,';')}" />
                 <c:forEach var="image" items="${fileParts}">
                  <img src="${image}" class="myimage">
                 </c:forEach>
                </c:if> <!--complete  --></td>
               <td class="addfrndtd">
                <div class="btn-group btn-group-lg ">
                 <button id="${object.infoId}" value="unread"
                  onclick="updateMessage(this.id,this.value)"
                  class="btn-default"
                  >
                  mark as unread</button>
                 <button id="${object.infoId}"
                  
                  value="delete"
                  onclick="updateMessage(this.id,this.value)"
                  class="btn-default">delete</button>
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
         <button onclick="showmore()" class="btn btn-link">see
          all</button>
        </div>
       </div></li>
      <li id="notification_li"><span id="notification_count"
       class="notification_count" style="display: none;">3</span> <a
       href="#" id="notificationLink" role="button"><i
        class="glyphicon glyphicon-bell"></i> Notifications <span
        class="badge">${fn:length(notificationObjects)}</span></a>

       <div id="notificationContainer" class="notificationContainer"
        style="display: none;width:500px">
        <div id="notificationTitle" class="notificationTitle">Notifications</div>
        <div id="notificationsBody"
         class="notificationsBody notifications">




         <div class="panel panel-default" >
          <c:forEach var="object" items="${notificationObjects}">
           <c:set var="text" value="sent you a friend request"></c:set>
           <c:set var="type" value="request"></c:set>

           <div class="panel-body" id="${object.notificationId}div">
            <div>
             <table>
              <tr>
               <td width="300px"><img
                src="${object.senderProfile.profilePic}"
                class="addfrndimg" /> <span> <strong> <a
                  href="${pageContext.request.contextPath}/profile/${object.senderProfile.userId}">
                   ${object.senderProfile.firstname}
                   ${object.senderProfile.lastname} </a>
                </strong></span><br> <span>${text}</span><br /></td>
               <td class="addfrndtd">
                <div class="btn-group btn-group-lg ">
                 <c:if test="${type eq 'request'}">
                  <button 
                   value="accept"
                   onclick="sendRequest(this,this.value,'${object.senderProfile.userId}')"
                   class="btn-default ${object.notificationId}accept"
                   >
                   accept</button>
                  <button 
                   
                   value="decline"
                   onclick="sendRequest(this,this.value,'${object.senderProfile.userId}')"
                   class="btn-default ${object.notificationId}decline">decline</button>
                 </c:if>
                </div>
               </td>
              </tr>
             </table>
            </div>
           <hr></div>
           
          </c:forEach>
         </div>
        </div>
        <div id="notificationFooter" class="notificationFooter">
         <a href="#">thats all</a>
        </div>

       </div></li>
      <li><a href="${pageContext.request.contextPath}/home"><i class="glyphicon glyphicon-home"></i>
        Home</a></li>
      <li><button id="addClass" type="submit" class="btn btn-link mylink">
         <span class="glyphicon glyphicon-comment"> </span> chat
        </button></li>
      <li>

       <form action="${pageContext.request.contextPath}/logout"
        method="post">
        <button type="submit" class="btn btn-link mylink">
         <span class="glyphicon glyphicon-log-in"> </span> logout
        </button>


        <input type="hidden" name="${_csrf.parameterName}"
         value="${_csrf.token}">
       </form>

      </li>
     </ul>

    </nav>
   </div>
   
      <!-- /top nav -->
   <fmt:formatDate value="${profile.dob}" var="myVar" type="date"
    pattern="yyyy-MM-dd" />


   <div class="padding">
    <div class="full col-sm-12">

     <!-- content -->
     <div class="row">
      <div class="col-sm-3" id="sidebar">
       <!-- Contenedor -->
       <ul id="accordion" class="accordion">
        <li>
         <div class="col col_4 iamgurdeep-pic">
          <img class="img-responsive myimage" alt="myimage"
           id="mybigprofileimage" src="${profile.profilePic}">
         <a
           href="${pageContext.request.contextPath}/profileedit/"
           class="username">${profile.firstname} ${profile.lastname}</a>
           
          

         </div>

        </li>
        <li class="default open">
         <div class="link">
          <i class="fa fa-globe"></i>About<i class="fa fa-chevron-down"></i>
         </div>
         <ul class="submenu">


          <li><a href="#"> Date of Birth : ${myVar}</a></li>
          <c:if test="${!empty profile.work}">
           <li><a href="#">Address : ${profile.homeTown}</a></li>
          </c:if>
          <c:if test="${!empty profile.work}">
           <li><a href="#">work:${profile.work}</a></li>
          </c:if>
          <c:if test="${!empty profile.phone}">
           <li><a href="#">Phone : ${profile.phone}</a></li>
          </c:if>


         </ul>
        </li>

        <li class="default open">
         <div class="link">
          <i class="fa fa-picture-o"></i>Photos <small>${fn:length(products)}</small><i
           class="fa fa-chevron-down"></i>
         </div>
         <ul class="submenu">
          <li class="photos"><c:forEach var="product"
            items="${products}">
            <c:set var="my" value="${product.images}" />
            <c:set var="fileParts" value="${fn:split(my,';')}" />
            <c:forEach var="files" items="${fileParts}">
             <a href="#"><img class="img-responsive myimage"
              alt="myimage" src="${files}"> </a>
            </c:forEach>
           </c:forEach></li>
         </ul>
        </li>
        <li class="default open">
         <div class="link">
          <i class="fa fa-users"></i>Friends <small>${fn:length(friends)}</small><i
           class="fa fa-chevron-down"></i>
         </div>
         <ul class="submenu">
          <li class="photos"><c:forEach var="friend"
            items="${friends}">
            <a
             href="${pageContext.request.contextPath}/profile/${friend.userId}"><img
             class="img-responsive myimage" alt="myimage"
             src="${friend.profilePic}"> ${friend.firstname} </a>
           </c:forEach></li>
         </ul>
        </li>
       </ul>
      </div>



      <!-- main col right -->
      <div class="col-sm-5">
       <div class="panel panel-default">
        <div class="panel-body">
         <c:if test="${empty users}">
          <p>no users found with this name</p>
         </c:if>
         <c:forEach var="user" items="${users}">
          <div>
           <table>
            <tr>
             <td width="400px"><img src="${user.profilePic}"
              class="addfrndimg" /> <span><strong><a
                href="${pageContext.request.contextPath}/profile/${user.userId}">${user.firstname}
                 ${user.lastname}</a></strong></span><br> <c:if
               test="${not empty user.work}">
               <span>${user.work}</span>
               <br>
              </c:if> <c:if test="${not empty user.currentCity}">
               <span>Lives in ${user.currentCity}</span>
               <br>
              </c:if> <span> ${fn:toLowerCase(user.gender)}</span> <c:if
               test="${not empty user.relationStatus}">
               <span>,${fn:toLowerCase(user.relationStatus)}</span>
               <c:if test="${not empty user.interest}">
                <span>,intrested in ${user.interest}</span>
               </c:if>
              </c:if> <c:if test="${not empty user.college}">
               <span>studied at ${user.college}</span>
               <br>
              </c:if> <c:if test="${not empty user.highSchool}">
               <span>highschool from ${user.highSchool}</span>
              </c:if></td>
             <c:set var="block" value="block"></c:set>
             <c:if test="${myfn:contains(blocked,user.userId)}">
              <c:set var="block" value="unblock"></c:set>
             </c:if>

             <c:set var="request" value="add"></c:set>
             <c:set var="id" value="${user.userId}"></c:set>
             <c:if test="${myfn:contains(friendSet,user.userId)}">
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
             <td class="addfrndtd">
              <div class="btn-group btn-group-lg" role="group">
               <button type="button" value="${request}"
                class="btn-default ${id}${request}"
                style=""
                
                onclick="sendRequest(this,this.value,'${user.userId}')">
                <c:if test="${request eq 'add'}">add friend</c:if>
                <c:if test="${request eq 'cancel'}">cancel request</c:if>
                <c:if test="${request eq 'unfriend'}">unfriend</c:if>
                <c:if test="${request eq 'accept'}">accept</c:if>
               </button>
               <button type="button" class=" btn-default "
                style=""
                data-toggle="dropdown">
                <span class="caret"></span>
               </button>
               <ul class="dropdown-menu" role="menu">
                <li><button id="${user.userId}message"
                  onclick="messaged(this.id)" class="btn btn-link">message</button></li>

                <li><button id="${user.userId}${block}"
                  value="${block}" onclick="block(this.id,this.value)"
                  class="btn btn-link">${block}</button></li>
                <c:if test="${request eq 'accept'}">
                 <li><button  value="decline"
                   onclick="sendRequest(this,this.value,'${user.userId}')"
                   class="btn btn-link ${id}decline">decline</button></li>
                </c:if>
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
<div class="col-sm-3">
      <!-- friends suggestions -->
      <div>
       <div class="panel panel-default">
        <div class="panel-body">
         <c:if test="${empty suggestions}">
          <p>no users found with this name</p>
         </c:if>
         <c:forEach var="user" items="${suggestions}">
          <div>
           <table>
            <tr>
             <td width="200px"><img src="${user.profilePic}"
              class="suggestImg" /> <span><strong><a
                href="${pageContext.request.contextPath}/profile/${user.userId}">${user.firstname}
                 ${user.lastname}</a></strong></span>
                 </td>
             <c:set var="block" value="block"></c:set>
             <c:if test="${myfn:contains(blocked,user.userId)}">
              <c:set var="block" value="unblock"></c:set>
             </c:if>

             <c:set var="request" value="add"></c:set>
             <c:set var="id" value="${user.userId}"></c:set>
             
             
             <td class="addfrndtd">
              <div class="btn-group btn-group-lg" role="group">
               <button type="button" value="${request}"
                class="btn-default ${id}${request}"
                style=""
                
                onclick="sendRequest(this,this.value,'${user.userId}')">
                <c:if test="${request eq 'add'}">add friend</c:if>
                
               </button>
               <button type="button" class=" btn-default "
                style=""
                data-toggle="dropdown">
                <span class="caret"></span>
               </button>
               <ul class="dropdown-menu" role="menu">
                <li><button id="${user.userId}message"
                  onclick="messaged(this.id)" class="btn btn-link">message</button></li>

                <li><button id="${user.userId}${block}"
                  value="${block}" onclick="block(this.id,this.value)"
                  class="btn btn-link">${block}</button></li>
                
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
          <img
           class="md-user-image" alt="Gurdeep Osahan (Web Designer)"
           src="${pageContext.request.contextPath}/resources/images/avatar.png">
         </div>
         <div class="popup-head-right pull-right">
          <button class="chat-header-button" type="button">
           <i class="glyphicon glyphicon-facetime-video"></i>
          </button>
          <button class="chat-header-button" type="button">
           <i class="glyphicon glyphicon-earphone"></i>
          </button>
          <div class="btn-group gurdeepoushan">
           <button class="chat-header-button" data-toggle="dropdown"
            type="button" aria-expanded="false">
            <i class="glyphicon glyphicon-paperclip"></i>
           </button>
                     </div>

          <button data-widget="remove" id="removeClass"
           class="chat-header-button pull-right" type="button">
           <i class="glyphicon glyphicon-remove"></i>
          </button>
         </div>
        </div>

        <div id="chat"
         class="chat_box_wrapper chat_box_small chat_box_active"
         style="opacity: 1; display: block; transform: translateX(0px);">
         <div class="chat_box touchscroll chat_box_colors_a">
          <div class="chat_message_wrapper">
           <div class="chat_user_avatar">
            <img
           class="md-user-image" alt="Gurdeep Osahan (Web Designer)"
           src="${pageContext.request.contextPath}/resources/images/avatar.png">
           </div>
           <ul class="chat_message">
            <li>
             <p>chat is not implemented</p>
            </li>
            <li>
             <p>
              i know chat is not implemented.<span class="chat_message_time">13:38</span>
             </p>
            </li>
           </ul>
          </div>
          <div class="chat_message_wrapper chat_message_right">
           <div class="chat_user_avatar">
            <img
           class="md-user-image" alt="Gurdeep Osahan (Web Designer)"
           src="${pageContext.request.contextPath}/resources/images/avatar.png">
           </div>
           <ul class="chat_message">
            <li>
             <p>
             so what if it is not everything else is working <span
               class="chat_message_time">13:34</span>
             </p>
            </li>
           </ul>
          </div>
          <div class="chat_message_wrapper">
           <div class="chat_user_avatar">
           <img
           class="md-user-image" alt="Gurdeep Osahan (Web Designer)"
           src="${pageContext.request.contextPath}/resources/images/avatar.png">
           </div>
           <ul class="chat_message">
            <li>
             <p>
              yeah i know <span
               class="chat_message_time">23 Jun 1:10am</span>
             </p>
            </li>
           </ul>
          </div>
          <div class="chat_message_wrapper chat_message_right">
           <div class="chat_user_avatar">
            <img
           class="md-user-image" alt="Gurdeep Osahan (Web Designer)"
           src="${pageContext.request.contextPath}/resources/images/avatar.png">
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
           <span style="vertical-align: sub;"
            class="uk-input-group-addon"><i
             class="fa fa-camera" style="cursor: pointer;" id="chaticon"></i><input type="file" name="" id="chatimage" style="display:none;">
           </span> 
           <span style="display:inline;
    float: right;"  class="uk-input-group-addon"><textarea placeholder="Type a message" height="50px"
            id="submit_message" name="submit_message" class="md-input"></textarea> <a href="#"><i
            class="glyphicon glyphicon-send" style="color:red;"></i></a>
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
    <!-- col-12 -->
   </div>
   <!-- /padding -->
  </div>
  <!-- main -->

 </div>
 <!-- main row ends -->
 <!--post modal-->
 <div id="messageModal" class="modal fade" tabindex="-1" role="dialog"
  aria-hidden="true">
  <div class="modal-dialog">
   <div class="modal-content">
    <div class="modal-header">
     <button type="button" class="close" data-dismiss="modal"
      aria-hidden="true">*</button>
     send message
    </div>
    <div class="modal-body">
     <div>
      <form class="form center-block form-horizontal" method="post"
       role="form" id="messageForm" enctype="multipart/form-data"
       action="${pageContext.request.contextPath}/sendmessage">
       <div>
       <textarea class="form-control input-lg" autofocus="autofocus"
        placeholder="What do you want to share?" id="message"></textarea>
        
           </div>
       <div class="modal-footer">
       <div id="myVideoUploadSection"></div>
           <div id="myImageUploadSection"></div>
       <div id="dynamic"></div>
        <div>
         <input class="btn btn-primary pull-right" type="submit"
          value="post">
         <ul class="pull-left list-inline">
          <li>
           <button class="mybutton" type="button" id="fancyuploadvideo">
            <i class="glyphicon glyphicon-facetime-video"></i>
           </button> <input type="file" id="myVideo" multiple="multiple"
            style="display: none" accept="video/mp4,video/x-m4v,video/*" />
          </li>
          <li>
           <button class="mybutton" type="button" id="fancyuploadimage">
            <i class="glyphicon glyphicon-camera"></i>
           </button> <input type="file" id="myImage" multiple="multiple"
            style="display: none"
            accept="image/x-png,image/gif,image/jpeg" />
          </li>
         </ul>
         <input type="hidden" value="${profile.userId}" id="userId" />
         <input type="hidden" name="${_csrf.parameterName}"
          value="${_csrf.token}" />
        </div>
       </div>
      </form>
     </div>
    </div>
   </div>
   
  </div>
 </div>

</body>
</html>
