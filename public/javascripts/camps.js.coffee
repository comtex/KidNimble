window.update_search = (page) ->
  if window.router 
    window.router.camps.reset()
    window.router.camps.fetch({data: $('#search').serialize()+"&page="+page})
    $("#camps").html(window.router.view.render().el)
    $.getJSON '/links', $('#search').serialize()+"&page="+page, (data) ->
      $('#links').html( data )

jQuery(document).ready ->
  $('#search-button').click ->
    window.update_search(1)

window.notify_of_counselor = ->
  if confirm("Are you sure? Site operators will be notified in order to verify.") == true
    $.post "/counselors", {"camp_id": camp_id}, (data) ->
      alert("You have been added as a counselor, we'll notify you when you've been approved.")
      $("#iam").removeClass('btn').removeClass('primary').html("<span class='label success'>Notified...</span>").attr("onclick", null)

window.do_rating = (id) ->
  console.log id
  $('#ratingBox').html('<div id="'+id+'"></div>')
  $('#'+id).jRating
    step          : true
    length        : 5
    type          : "big"
    phpPath       : "/reviews"
    bigStarsPath  : "/assets/stars.png"
    smallStarsPath: "/assets/small.png"
    onSuccess     : (data) ->
      console.log(data)
      alert('Success : your rate has been saved :)')
