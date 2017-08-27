var message = new Object();
var header, token, action;
var videosSelected=false;
var imagesSelected=false;
var messageReceiverId;
function theFocus(obj) {
	 $('[data-toggle="tooltip"]').tooltip(); 
}

function messaged(id){
	$('#messageModal').modal('show');
	messageReceiverId=id.substr(0,id.length-"message".length);

}
function showComments(activityId)
{
	$("#"+activityId+"commentsection").toggle();
}
function updateProduct(realproductId,value)
{
	var action=(value.localeCompare("like")==0||value.localeCompare("unlike")==0)?"like":"share";
	var jsonObject={"productId":realproductId,"action":value};
	sendJsonAsPost(context+"/updateproduct",jsonObject,realproductId+action)
	if(value.localeCompare("like")==0||value.localeCompare("unlike")==0)
		{
		var temp=value.localeCompare("like")==0?"unlike":"like";
		$("."+realproductId+"likebtn").val(temp);
		$("."+realproductId+"likesign").html(temp);
		}
	else if(value.localeCompare("share")==0||value.localeCompare("unshare")==0)
		{
		var temp=value.localeCompare("share")==0?"unshare":"share";
		$("."+realproductId+"sharebtn").val(temp);
		$("."+realproductId+"sharesign").html(temp);
		}
}
function showmore()
{
$("#oldmessages").css("display","block");	
}
function submitComment(id,profilePic,name,activityId){
	var realproductId=id.substr(0,id.length-"commentform".length)
	var comment=$("#"+activityId+"commentarea").val();
	var jsonCommentObject={"productId":realproductId,"comment":comment};
	var temp=new Array();
	$("."+realproductId+"commentsection").each(function(){temp.push($(this).children().last())});
	sendJsonAsPost(context+"/submitcomment",jsonCommentObject,realproductId+"comment");
	console.log(comment);
	for(var i = 0; i < temp.length; i++)
	{
	 $("<div class=\"outer\">"+
	   "<div class=\"inner\">" +
	 "  <img src="+'"'+profilePic+'"'+"class=\"mythumbnail\"> " +
	 "</div> " +
	 "   <div> " +
	 "    <div> "+    comment   +"  </div> " +
	 "  </div> " +
	 " <br style=\"clear: both\">" +
	 "   </div>").insertBefore(temp[i])
	}
}
function updateMessage(id,value)
{
if(value.localeCompare("read")==0)
{
	$("#"+id).val("unread");
	$("#"+id).html("mark as unread");
	$("#"+id+"div").prependTo("#oldmessages");	
}
else if(value.localeCompare("unread")==0)
	{
	$("#"+id).val("read");
	$("#"+id).html("mark as read");
	$("#"+id+"div").appendTo("#newmessages");
	}
else
	$("#"+id+"div").css("display","none");
var jsonObject={"infoid":id,"action":value};
sendJsonAsPost(context+"/updatemessage", jsonObject)
}
function otherComments(activityId)
{
$("#"+activityId+"othercomments").toggle();
}
function sendJsonAsPost(action,jsonObject,idofsectiontoupdate)
{
	$.ajax({
		type : "POST",
		url : action,
		data : JSON.stringify(jsonObject),
		dataType: "text",
		contentType:"application/json",
		beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: function(result)
		{
			if(idofsectiontoupdate!=undefined)
			$("."+idofsectiontoupdate).html(result);
		},
		error: function(result){
			console.log(result);
		}
	});	
}

function block(id,value)
{
	var blockedUserId=id.substr(0,id.length-value.length);
	sendKeyValuePair(context+"/block",value,blockedUserId);
	if(value.localeCompare("block")==0)
	{	$("#"+id).html("unblock");
		$("#"+id).val("unblock");
		$("#"+id).attr("id",blockedUserId+"unblock");
	}
	if(value.localeCompare("unblock")==0)
	{	$("#"+id).html("block");
		$("#"+id).val("block");
		$("#"+id).attr("id",blockedUserId+"block");
	}
}
function sendRequest(element,value,optionalUserId){
	var temp=element.className.split(" ");
	id=temp[1];
	var normalCssClasses=temp[0]+" ";
	realid=id.substr(0,id.length-value.length)
	if(value.localeCompare("add")==0)
	{	
		sendKeyValuePair(context+"/addfriend",value,realid,true);
		
	}
	else{
	sendKeyValuePair(context+"/addfriend",value,realid,false);
	if(value.localeCompare("accept")==0)
	{	$("."+id).html("unfriend");
		$("."+id).val("unfriend");
		$("."+id).attr("class",normalCssClasses+optionalUserId+"unfriend");
		$("."+realid+"decline").css("display","none");
		console.log("inside accpet"+id)
	}
	
	if(value.localeCompare("unfriend")==0 || value.localeCompare("cancel")==0)
	{	$("."+id).html("add friend");
		$("."+id).val("add");
		$("."+id).attr("class",normalCssClasses+optionalUserId+"add");
	}
	if(value.localeCompare("decline")==0 )
	{	
		$("."+realid+"accept").html("add friend");
		$("."+realid+"accept").val("add");
		$("."+realid+"accept").attr("class",normalCssClasses+optionalUserId+"add");
		$("."+realid+"decline").css("display","none");
	}
	}
}
function sendProfile(action, virtualMessage) {
	$.ajax({
		type : "POST",
		url : action,
		data : virtualMessage,
		processData : false,
		contentType : false,
		beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success : function(resultData) {
			$("#myprofileimage").attr("src",resultData);
			$("#mybigprofileimage").attr("src",resultData);
			 document.getElementById("fake-btn").innerHTML="<span class=\"margin\"> Choose File</span>";
		},
		error : function(resultData) {
			$("#myprofileimage").attr("src",resultData);
			$("#mybigprofileimage").attr("src",resultData);
			document.getElementById("fake-btn").innerHTML="<span class=\"margin\"> Choose File</span>";
		}
	});
	
}
$(document).ready(function(){
	$(".carousel-inner div:first-child").addClass("active")
	
	var virtualMessage=new FormData();
	/*profile js starts*/	
	$('input[id=main-input]').change(function() {
        var mainValue = $(this).val();
        if(mainValue == ""){
            document.getElementById("fake-btn").innerHTML = "Choose File";
        }else{
        	
            document.getElementById("fake-btn").innerHTML = mainValue.replace("C:\\fakepath\\", "");
            virtualMessage=listFiles("main-input", new FormData(), 'profile[]')
            var src=sendProfile(context+"/profilepicupdate", virtualMessage);
            
        }
    });    
	
  $(".editlink").on("click", function(e){
    e.preventDefault();
    var dataset = $(this).prev(".datainfo");
    var savebtn = $(this).next(".savebtn");
    var cancelbtn = savebtn.next(".cancelbtn");
    var theid   = dataset.attr("id");
    var empty	= dataset.hasClass('empty')
    var newid   = theid+"-form";
    var currval = dataset.text().trim();
    if(empty)
    	currval="";
    var type;
    dataset.css({"display":"none"});
    if(theid.localeCompare("dob")==0)
    	$('<input type="date" name="'+newid+'" id="'+newid+'" value="'+currval+'" class="hlite">').insertAfter(dataset);
    else if(theid.localeCompare("gender")==0 ||theid.localeCompare("relationStatus")==0)
    {
    	var optionsarray ;
    if(theid.localeCompare("gender")==0)
    	{
    	optionsarray = new Array("MALE","FEMALE");
    	}
    else if(theid.localeCompare("relationStatus")==0)
    	{
    	optionsarray = new Array("Single","Married");
    	}
    
	var select = $('<select id='+newid+' name='+newid +'/>');
	console.log(optionsarray.length+" "+theid);
	$.each(optionsarray,function(i){
	    $('<option/>',{text:optionsarray[i],
	                                value:optionsarray[i]
	                                }).appendTo(select);
	});

	select.insertAfter(dataset);

    }
    else{
    	$('<input type="text" name="'+newid+'" id="'+newid+'" value="'+currval+'" class="hlite">').insertAfter(dataset);
    	console.log("h "+currval+" no");
    }
    
 
    $(this).css("display", "none");
    savebtn.css("display", "block");
    cancelbtn.css("display", "block");
  });
  $(".savebtn").on("click", function(e){
	  	e.preventDefault();
	    var elink   = $(this).prev(".editlink");
	    var dataset = elink.prev().prev(".datainfo");
	    var newid   = dataset.attr("id");
	    var cancel   = $(this).next(".cancelbtn");
	    
	    var cinput  = "#"+newid+"-form";
	    var einput  = $(cinput);
	    var newval  = einput.val();
	    console.log(newid+" "+newval);
	    $(this).css("display", "none");
	    cancel.css({"display":"none"});
	    einput.remove();
	    dataset.html(newval);
	    dataset.css({"display":"inline"});
	    elink.css("display", "block");
	    action=context+"/updateprofile";
	    sendKeyValuePair(action,newid,newval);
	    
	  });
  $(".cancelbtn").on("click", function(e){
	    e.preventDefault();
	    var dataset = $(this).prev().prev().prev().prev(".datainfo");
	    var elink   = $(this).prev().prev(".editlink");
	    var save   = $(this).prev(".savebtn");
	    var newid=dataset.attr("id")+"-form";//input element id
	    $("#"+newid).remove();
	    dataset.css({"display":"inline"});
	    elink.css({"display":"block"});
	    save.css({"display":"none"});
	    $(this).css({"display":"none"});
	    
  });
});

function sendKeyValuePair(action,newid,newval,printNotificationId)
{
	$.ajax({
		type : "POST",
		url : action,
		data : JSON.stringify(new function(){ this[newid] = newval; }),
		/*data : JSON.stringify({[newid]:newval}),*/
		dataType: "text",
		contentType:"application/json",
		beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success: function(result)
		{
			
			if(printNotificationId)
				{
			var id=newval+"add";
			$("."+id).html("cancel request");
			$("."+id).val("cancel");
			$("."+id).attr("class","btn-default "+result+"cancel");
				}
		},
		error: function(result){
			console.log(result);
		}
		
		
	});	
}
/*profile js ends*/ 
  


/*notification and message js starts*/
$(document).ready(function()
{
$("#notificationLink").click(function()
{
$("#notificationContainer").fadeToggle(300);
$("#messageContainer").hide();
$("#notification_count").fadeOut("slow");
return false;
});

//Document Click hiding the popup
$(document).click(function()
{
$("#notificationContainer").hide();
});

$("#notificationContainer a").click(function()
{
return true;
})
//Popup on click
$("#notificationContainer button").click(function()
{
return false;
});


$("#messageLink").click(function()
{
$("#messageContainer").fadeToggle(300);
$("#notificationContainer").hide();
$("#message_count").fadeOut("slow");
return false;
});

//Document Click hiding the popup
$(document).click(function()
{
$("#messageContainer").hide();
});

$("#messageContainer a").click(function()
		{
		return true;
		});
//Popup on click
$("#messageContainer button").click(function()
{
return false;
});
/*notification and message js ends*/

});

function send(action, virtualMessage) {
	$.ajax({
		type : "POST",
		url : action,
		data : virtualMessage,
		processData : false,
		contentType : false,
		beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success : function(resultData) {
			$('#dynamic').html(resultData).css("display","block").fadeOut(3000);
		},
		error : function(resultData) {
			$('#dynamic').html(resultData).css("display","block").fadeOut(3000);
		}
	});
	
}

$(document).ready(function(){
	$(function() {
	    var Accordion = function(el, multiple) {
			this.el = el || {};
			this.multiple = multiple || false;

			// Variables privadas
			var links = this.el.find('.link');
			// Evento
			links.on('click', {el: this.el, multiple: this.multiple}, this.dropdown)
		}

		Accordion.prototype.dropdown = function(e) {
			var $el = e.data.el;
				$this = $(this),
				$next = $this.next();

			$next.slideToggle();
			$this.parent().toggleClass('open');

			if (!e.data.multiple) {
				$el.find('.submenu').not($next).slideUp().parent().removeClass('open');
			};
		}

		var accordion = new Accordion($('#accordion'), false);
	})

	$(function(){
	$("#addClass").click(function () {
	  $('#sidebar_secondary').css('display', 'block');
	    });

	    $("#removeClass").click(function () {
	  $('#sidebar_secondary').css('display','none ');
	    });
	})
					$("#chaticon").click(function() {
						$("#chatimage").trigger('click');
					});

					$('#chatimage').on('change', function() {
						//do something
					})


});

/*status update js start */
$(document).ready(
		function() {
			/* file attachment js start */
			var virtualMessage = new FormData();
			token = $("meta[name='_csrf']").attr("content");
			header = $("meta[name='_csrf_header']").attr("content");
			$("#myImage").change(function() {
					if(imagesSelected)
						virtualMessage.set("images[]",null);//so old selected images are discarded and now new ones can be added
					else
						imagesSelected=true;
				virtualMessage = listFiles("myImage",virtualMessage,'images[]');
			});
			
			$("#myVideo").change(function() {
				if(videosSelected)
					virtualMessage.set("videos[]",null);
				else
					videosSelected=true;
				virtualMessage = listFiles("myVideo",virtualMessage,'videos[]');
			});
			$("#statusForm").submit(
					function(event) {
						virtualMessage.set("status",null);
						// Prevent the form from submitting via the browser.
						event.preventDefault();
						
						status = $('#status').val();
						
						action = $('#statusForm').attr('action');
						virtualMessage.append("status", new Blob([ JSON
						            								.stringify(status) ], {
						            							type : "application/json"
						            						}));
						send(action, virtualMessage);
					});
			/*mesage sending*/
			$("#messageForm").submit(
					function(event) {
						/*console.log("inside the message"+messageReceiverId);*/
						// Prevent the form from submitting via the browser.
						event.preventDefault();
						virtualMessage.set("message",null)
						message= $('#message').val();
						receiverId=messageReceiverId;
						action = $('#messageForm').attr('action');
						virtualMessage.append("message", new Blob([ JSON
						            								.stringify(message) ], {
						            							type : "application/json"
						            						}));
						virtualMessage.append("receiverId", new Blob([ JSON
						            								.stringify(receiverId) ], {
						            							type : "application/json"
						            						}));
						send(action, virtualMessage);
					});
			
			
			/* file attachment js ends */

		});

function listFiles(elementId,virtualMessage,propertyName) {
	var x = document.getElementById(elementId);
	var txt = "";
	if ('files' in x) {
		if (x.files.length != 0) {
			for (var i = 0; i < x.files.length; i++) {
				var file = x.files[i];
				virtualMessage.append(propertyName, file);
				if ('name' in file) {
					txt += "<div class='col-sm-6'>" + file.name + "</div>";
				}

			}
		}
	} else {
		if (x.value != "") {
			txt += "The files upload feature is not supported by your browser!";
		}
	}
	document.getElementById(elementId+"UploadSection").innerHTML = txt;
	return virtualMessage;
}

$(document).ready(function()	{
	$("#fancyuploadimage").click(function(){
	$("#myImage").click();	
	});
	$("#fancyuploadvideo").click(function(){
		$("#myVideo").click();	
		});
});
		
/*status update js ends */