class Guru.Routers.EventsRouter extends Backbone.Router
  initialize: (options) ->
    @events = new Guru.Collections.EventsCollection()
    @events.reset options.events

  routes:
    "/new"      : "newEvents"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newEvents: ->
    @view = new Guru.Views.Events.NewView(collection: @events)
    $("#events").html(@view.render().el)

  index: ->
    @view = new Guru.Views.Events.IndexView(events: @events)
    $("#events").html(@view.render().el)

  show: (id) ->
    events = @events.get(id)

    @view = new Guru.Views.Events.ShowView(model: events)
    $("#events").html(@view.render().el)

  edit: (id) ->
    events = @events.get(id)

    @view = new Guru.Views.Events.EditView(model: events)
    $("#events").html(@view.render().el)
