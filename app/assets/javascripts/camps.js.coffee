window.update_search = (page) ->
  if window.router 
    window.router.camps.reset()
    window.router.camps.fetch({data: $('#search').serialize()+"&page="+page})
    $("#camps").html(window.router.view.render().el)
    $.get '/camps/mapplaces.html', $('#search').serialize()+"&page="+page, (data) ->
      $('#mapplaces').html( data )
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

window.get_category_imagename = (category) ->
  switch category
    when "Art/Music/Drama" then 'arts-music-ent.jpg'
    when "Sports" then 'sports.jpg'
    when "Special Needs" then 'special-needs.jpg'
    when "Educational" then 'educational.jpg'
    when "Religious" then 'religions.jpg'
    when "Outdoors" then 'outdoors.jpg'
    when "Traditional" then 'outdoors.jpg'
    when "Community Service" then 'outdoors.jpg'
    when "Teen Travel" then 'teen-travel.jpg'
    else 'outdoors.jpg'
