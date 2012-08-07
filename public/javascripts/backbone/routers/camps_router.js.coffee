class Guru.Routers.CampsRouter extends Backbone.Router
  initialize: (options) ->
    @camps = new Guru.Collections.CampsCollection()
    @camps.reset options.camps

  get_params:
    "this"

  routes:
    "/new"       : "newCamps"
    "/index"     : "index"
    "/:id/edit"  : "edit"
    "/:id/show"  : "show"
    "/:id/page"  : "page"
    ".*"         : "index"

  newCamps: ->
    @view = new Guru.Views.Camps.NewView(collection: @camps)
    $("#camps").html(@view.render().el)

  index: ->
    @view = new Guru.Views.Camps.IndexView(camps: @camps)
    $("#camps").html(@view.render().el)
    

  page: (page)->
    page = 1 unless page
    console.log "Loading page: "+page
    window.update_search(page)

  show: (id) ->
    #$('.main').remove()
    $('.main').hide()
    camp = @camps.get(id)
    
    @view = new Guru.Views.Camps.ShowView(model: camp)
    $(".container.header").after(@view.render().el.innerHTML)

    # define tabs click here due to js loading sequence
    jQuery ($) ->
      activateTab = (tab) ->
        activeTab = $(tab).closest('dl').find('a.active')
        contentLocation = '#' + $(tab).attr('id') + 'Tab'

        
        $(activeTab).removeClass('active')
        activeTab.removeClass('active')
        
        tab.addClass('active')
        $(tab).addClass('active')
        
        
        $(contentLocation).closest('.tabs-content').children('li').hide()
        $(contentLocation).css('display', 'block')
      
      $('dl.tabs').each (i,element) =>
        tabs = $(element).children('dd').children('a')

        tabs.each (i, element) =>
          $(element).click (e) =>
            e.preventDefault()
            activateTab($(element))

    
    
    

  edit: (id) ->
    camps = @camps.get(id)

    @view = new Guru.Views.Camps.EditView(model: camps)
    $("#camps").html(@view.render().el)
