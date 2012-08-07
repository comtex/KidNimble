# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#

blankFields = ()->
  $('#zip').val ""
  $('#city').val ""

citySearch = ()->
  $.getJSON '/city/zip.js?term='+$('#city').val()+'&state='+$('#state').val(), (data)->
    if data.zip
      $('#zip').val data['zip']
      
zipSearch = ()->
  $.getJSON '/zip.js?term='+$('#zip').val(), (data)->
    if data.city
      $('#city').val data['city']
      $("#state").find(':selected').attr selected: false
      $("#state option[value='#{data.state}']").attr selected: true
      
      $("#state").next().find(':first-child').text($("#state").find(':selected').text()).parent().addClass('changed');
      
      
$(document).ready ->
  $('#zip').blur zipSearch
  $('#city').blur citySearch
  $("#state").change blankFields
  $('#city').autocomplete
    minLength: 3,
    delay: 200,
    disabled: false,
    source: (request, response)->
      $.ajax
        url: "/city.js",
        dataType: "json",
        data:
          state: $('#state').val(),
          term:  request.term
        success: ( data )->
          response( data )
          
  