if (!window.console) console = {log: function() {}};
/* Foundation v2.2 http://foundation.zurb.com */
jQuery(document).ready(function ($) {

	/* Use this js doc for all application specific JS */

	/* TABS --------------------------------- */
	/* Remove if you don't need :) */


	function activateTab($tab) {
		var $activeTab = $tab.closest('dl').find('a.active'),
				contentLocation = $tab.attr("href") + 'Tab';

		//Make Tab Active
		$activeTab.removeClass('active');
		$tab.addClass('active');

    	//Show Tab Content
		$(contentLocation).closest('.tabs-content').children('li').hide();
		$(contentLocation).css('display', 'block');
	}

	$('dl.tabs').each(function() {
		//Get all tabs
		var tabs = $(this).children('dd').children('a');
		tabs.click(function (e) {
			activateTab($(this));
		});
	});

	if (window.location.hash) {
		activateTab($('a[href="' + window.location.hash + '"]'));
	}

	/* ALERT BOXES ------------ */
	$(".alert-box").delegate("a.close", "click", function(event) {
    event.preventDefault();
	  $(this).closest(".alert-box").fadeOut(function(event){
	    $(this).remove();
	  });
	});


	/* PLACEHOLDER FOR FORMS ------------- */
	/* Remove this and jquery.placeholder.min.js if you don't need :) */

	$('input, textarea').placeholder();

	/* TOOLTIPS ------------ */
	$(this).tooltips();



	/* UNCOMMENT THE LINE YOU WANT BELOW IF YOU WANT IE6/7/8 SUPPORT AND ARE USING .block-grids */
//	$('.block-grid.two-up>li:nth-child(2n+1)').css({clear: 'left'});
//	$('.block-grid.three-up>li:nth-child(3n+1)').css({clear: 'left'});
//	$('.block-grid.four-up>li:nth-child(4n+1)').css({clear: 'left'});
//	$('.block-grid.five-up>li:nth-child(5n+1)').css({clear: 'left'});



	/* DROPDOWN NAV ------------- */

	var lockNavBar = false;
	$('.nav-bar a.flyout-toggle').live('click', function(e) {
		e.preventDefault();
		var flyout = $(this).siblings('.flyout');
		if (lockNavBar === false) {
			$('.nav-bar .flyout').not(flyout).slideUp(500);
			flyout.slideToggle(500, function(){
				lockNavBar = false;
			});
		}
		lockNavBar = true;
	});
  if (Modernizr.touch) {
    $('.nav-bar>li.has-flyout>a.main').css({
      'padding-right' : '75px'
    });
    $('.nav-bar>li.has-flyout>a.flyout-toggle').css({
      'border-left' : '1px dashed #eee'
    });
  } else {
    $('.nav-bar>li.has-flyout').hover(function() {
      $(this).children('.flyout').show();
    }, function() {
      $(this).children('.flyout').hide();
    })
  }


	/* DISABLED BUTTONS ------------- */
	/* Gives elements with a class of 'disabled' a return: false; */
  
});





/*_______________________________*/
	function showReviewSavedMsg(){
		alert("Review was successfully created.");
	}
	function showPostSavedMsg(){
		alert("Post was successfully created.");
	}
	function showMemberSavedMsg(){
		alert("Member was successfully invited.");
	}
	function showPassUpdateMsg(){
		alert("Password changed successfully.");
	}
	function showEventSavedMsg(){
		alert("Event was successfully created.");
	}
	function showEventUpdateMsg(){
		alert("Event was successfully updated.");
	}
	function submitReview(camp_id){
	  	var note = $('#note').val();
	  	var rating = 0;
	  	for(var i=1;i<=5;i++){
	  		if(typeof($('#rating'+i).attr('checked')) != 'undefined'){
	  			rating = i;
	  		}
	  	}
	  	
	  	$.post('/reviews/addreview.html', {'camp_id': camp_id, 'note': note, 'rating': rating}, function(data) {
	        $('#reviews').append(data);
	    });
	  }
	function openPopup(url, wth){
		if(wth == null || wth == 0){wth = 520;}
		//e.preventDefault();
	    var dialog_form = $('<div id="dialog-form">Loading ...</div>').dialog({
	      autoOpen: false,
	      width: wth,
	      modal: true,
	      open: function() {
	        return $(this).load(url);
	      },
	      close: function() {
	        $('#dialog-form').fadeOut().remove();
	      }
	    });
	    dialog_form.dialog('open');
	    return false;
	}
	
	function createTempReview(form){
		form.submit();
		window.location='/users/sign_up';
	}
	function login(camp_id) {
	  var email = $('#new_user #user_email').val();
	  var password = $('#new_user #user_password').val();
	  var data = {remote: true, commit: "Sign in", utf8: "✓", user: {remember_me: 1, password: password, email: email}};
	  $.post('/users/sign_in.json', data, function(resp) {
	    if(resp.success) {
	    	getReviewData(camp_id);
			$('#dialog-form').dialog('close');
			$('#dialog-form').fadeOut().remove();
			showReviewSavedMsg();
	    } else {
			$('#loginError').html(resp.errors[0]);
	    }
	  });
	  return false;
	}
	
	function getReviewData(camp_id){
		$.getJSON('/reviews', {'camp_id': camp_id}, function(data) {
		html = '';
        $.each(data, function(i,e) {
        	html += '<div class="row columns title">';
            html += '	<div class="twelve columns">';
            html += '		<div class="img columns">';
            html += '   		<img width="55" height="58" src="/assets/template/campgurus25_18.png" alt="">';
            html += '		</div><div class="rating columns">';
            html += '			<ul id="rater">';
								for(var i=1;i<=5;i++){
									if(i <= e['rating']){
			html += '				<li><img src="/assets/template/star.png" alt="star" title="" /></li>';
									}else{
			html += '				<li><img src="/assets/template/star-empty.png" alt="star" title="" /></li>';
									}
								}
			html += '			</ul>';
			html += '		</div><div class="title columns">';
			html += '   		<span class="colorgry1">';
            html += '      		<a href="#">'+e['note']+'</a>';
            html += '   		</span>';
            html += '		</div>';
            html += '	</div><div class="twelve columns">';
            html += '   	<h6>'+e['first_name'] + ' ' + e['last_name'].charAt(0);+'</h6>';
            html += '	</div>';
            html += '</div>';
            html += '<div class="clear"></div>';
        });
        if (data.length == 0) {
          html = '<div class="twelve review"><div class="twelve columns"><h5>No reviews.</h5></div></div>';
        }
        $('#reviews').html(html);
      });
	}
	
	function getPostData(group_id){
		$.getJSON('/posts', {'group_id': group_id}, function(data) {
      	var html = '';
        $.each(data, function(i,e) {
        	html += '<li class="row" id="mf145">';
		    html += '  <div class="columns title" id="mf146">';
		    html += '    <img width="25" height="28" src="/assets/template/campgurus25_18.png" alt="" id="mf147">';
		    html += '      <span class="colorgry1" id="mf148">'+ e['title'] +' ['+ e['name'] +'] </span>';
		    html += '      <span id="mf149">'+ e['content'] +'</span>';
		    html += '  </div>';
		    html += '</li>';
        });
        if (data.length == 0) {
          html += '<li class="row"><div class="columns title"><h5>No Posts!!!</h5></div></li>';
        }
        $('ul#camps-table').html(html);
      });
	}
	/*_______________________________*/
	

	// Place your application-specific JavaScript functions and classes here
	// This file is automatically included by javascript_include_tag :defaults

  	function errorResponse(jqXHR, exception){
  		var errorText = null;
  		if (jqXHR.status === 0) {
            errorText = ('Not connect.\n Verify Network.');
        } else if (jqXHR.status == 404) {
            errorText = ('Requested page not found [404].');
        } else if (jqXHR.status == 500) {
            errorText = ('Internal Server Error [500].');
        } else if (exception === 'parsererror') {
            errorText = ('Requested JSON parse failed.');
        } else if (exception === 'timeout') {
            errorText = ('Time out error.');
        } else if (exception === 'abort') {
            errorText = ('Ajax request aborted.');
        } else {
            errorText = ('Uncaught Error.\n' + jqXHR.responseText);
        }
  		return errorText;
  	}

	function moveEvent(event, dayDelta, minuteDelta, allDay){
	    jQuery.ajax({
	        data: 'id=' + event.id + '&title=' + event.title + '&day_delta=' + dayDelta + '&minute_delta=' + minuteDelta + '&all_day=' + allDay,
	        dataType: 'script',
	        beforeSend: function(){$('#loading').show();},
	        error:  function(jqXHR, exception){$('#loading').html(errorResponse(jqXHR, exception));$('#loading').fadeOut(5000);},
	        type: 'post',
	        url: "/events/move.js"
	    }).done(function(){$('#loading').hide();});
	}
	
	function resizeEvent(event, dayDelta, minuteDelta){
	    jQuery.ajax({
	        data: 'id=' + event.id + '&title=' + event.title + '&day_delta=' + dayDelta + '&minute_delta=' + minuteDelta,
	        dataType: 'script',
	        beforeSend: function(){$('#loading').show();},
	        error:  function(jqXHR, exception){$('#loading').html(errorResponse(jqXHR, exception));$('#loading').fadeOut(5000);},
	        type: 'post',
	        url: "/events/resize.js"
	    }).done(function(){$('#loading').hide();});
	}
	
	function deleteEvent(event_id, delete_all){
	    jQuery.ajax({
	        data: 'id=' + event_id + '&delete_all='+delete_all,
	        dataType: 'script',
	        beforeSend: function(){$('#loading').show();},
	        error:  function(jqXHR, exception){$('#loading').html(errorResponse(jqXHR, exception));$('#loading').fadeOut(5000);},
	        type: 'post',
	        url: "/events/destroy.js"
	    }).done(function(){$('#loading').hide();});
	}
	
	function showEventDetails(event){
	    $('#event_desc').html(event.description);
	    $('#edit_event').html("<a href = 'javascript:void(0);' onclick ='editEvent(" + event.group_id + ", " + event.id + ")'>Edit</a>");
	    if (event.recurring) {
	        title = event.title + "(Recurring)";
	        $('#delete_event').html("&nbsp; <a href = 'javascript:void(0);' onclick ='deleteEvent(" + event.id + ", " + false + ")'>Delete Only This Occurrence</a>");
	        $('#delete_event').append("&nbsp;&nbsp; <a href = 'javascript:void(0);' onclick ='deleteEvent(" + event.id + ", " + true + ")'>Delete All In Series</a>")
	        $('#delete_event').append("&nbsp;&nbsp; <a href = 'javascript:void(0);' onclick ='deleteEvent(" + event.id + ", \"future\")'>Delete All Future Events</a>")
	    }
	    else {
	        title = event.title;
	        $('#delete_event').html("<a href = 'javascript:void(0);' onclick ='deleteEvent(" + event.id + ", " + false + ")'>Delete</a>");
	    }
	    $('#desc_dialog').dialog({
	        title: title,
	        modal: true,
	        width: 500,
	        close: function(event, ui){
	            $('#desc_dialog').dialog('destroy')
	        }
	        
	    });
	    
	}
	
	function newEvent(group_id){
		$('#create_event_dialog').dialog({
			title: 'Add Event',
			modal: true,
			width: 500,
			open: function() {return $(this).load("/events/new.html?group_id=" + group_id);},
			close: function(event, ui) { $('#create_event_dialog').dialog('destroy') }  
		});
	}
	function editEvent(group_id, event_id){
		$('#desc_dialog').dialog('destroy');
		$('#create_event_dialog').dialog({
			title: 'Edit Event',
			modal: true,
			width: 500,
			open: function() {return $(this).load("/events/"+event_id+"/edit.html?group_id=" + group_id);},
			close: function(event, ui) { $('#create_event_dialog').dialog('destroy') }  
		});
	}
	
	function showPeriodAndFrequency(value){
	
	    switch (value) {
	        case 'Daily':
	            $('#period').html('day');
	            $('#frequency').show();
	            break;
	        case 'Weekly':
	            $('#period').html('week');
	            $('#frequency').show();
	            break;
	        case 'Monthly':
	            $('#period').html('month');
	            $('#frequency').show();
	            break;
	        case 'Yearly':
	            $('#period').html('year');
	            $('#frequency').show();
	            break;
	            
	        default:
	            $('#frequency').hide();
	    }
	    
	    
	    
	    
	}
