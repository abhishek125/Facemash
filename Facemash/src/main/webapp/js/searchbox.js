$(function() {
    $( "#skills" ).autocomplete({
        source: '/Twitter/searchuser'
    });
});
function inputFocus(i){
		if(i.value==i.defaultValue){ i.value=""; i.style.color="#000"; }
	}
	function inputBlur(i){
		if(i.value==""){ i.value=i.defaultValue; i.style.color="#848484"; }
	}
	
	$(document).ready(function() {
	    //attach autocomplete
	    $("#tagQuery").autocomplete({
	        minLength: 1,
	        delay: 500,
	        //define callback to format results
	        source: function (request, response) {
	            $.getJSON("/Twitter/searchuser", request, function(result) {
	                response($.map(result, function(item) {
	                    return {
	                        // following property gets displayed in drop down
	                        label: item.firstname+" "+item.lastname,
	                        // following property gets entered in the textbox
	                        value: item.firstname+" "+item.lastname,
	                        // following property is added for our own use
	                        tag_url: "/Twitter/"+"profile/"+item.userId
	                    }
	                }));
	            });
	        },

	        //define select handler
	        select : function openInNewTab(event, ui) {
	        	  var win = window.open(ui.item.tag_url, '_blank');
	        	  win.focus();
	        	}
	        /*function(event, ui) {
	            if (ui.item) {
	                event.preventDefault();
	                $("#selected_tags span").append("<a href=" + ui.item.tag_url + ' target="_blank">'+ ui.item.label +'</a>');
	                //$("#tagQuery").value = $("#tagQuery").defaultValue
	                var defValue = $("#tagQuery").prop('defaultValue');
	                $("#tagQuery").val(defValue);
	                $("#tagQuery").blur();
	                return false;
	            }
	        }*/
	    });
	});
