Guru.Views.Camps ||= {}

class Guru.Views.Camps.IndexView extends Backbone.View
  template: JST["backbone/templates/camps/index"]
  
  initialize: (options) ->
    @options.camps.bind('reset', @addAll)
    
    @search_title = ''
    if(@options.camps.length > 0)
      @search_title = 'Results: Your search returned ' + @options.camps.length + ' items.'
    else
      @search_title = 'No Results Found'
    
    
  addAll: () =>
    @options.camps.each(@addOne)
    
    console.log("found #{@options.camps.length} camps!")
    if(@options.camps.length > 0)
      @search_title = 'Results: Your search returned ' + @options.camps.length + ' items.'
    else
      @search_title = 'No Results Found'
    $("h3#searchtitle").html(@search_title)
    
  addOne: (camps) =>
    view = new Guru.Views.Camps.CampsView({model : camps})
    @$("ul#camps-table").append(view.render().el)
    
  render: =>
    
    $(@el).html(@template({camps: @options.camps.toJSON(),search_title: @search_title}))
    @addAll()
    
    return this
