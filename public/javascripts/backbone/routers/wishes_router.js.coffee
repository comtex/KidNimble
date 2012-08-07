class Guru.Routers.WishesRouter extends Backbone.Router
  initialize: (options) ->
    @wishes = new Guru.Collections.WishesCollection()
    @wishes.reset options.wishes

  routes:
    "/new"      : "newWishes"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newWishes: ->
    @view = new Guru.Views.Wishes.NewView(collection: @wishes)
    $("#wishes").html(@view.render().el)

  index: ->
    @view = new Guru.Views.Wishes.IndexView(wishes: @wishes)
    $("#wishes").html(@view.render().el)

  show: (id) ->
    wishes = @wishes.get(id)

    @view = new Guru.Views.Wishes.ShowView(model: wishes)
    $("#wishes").html(@view.render().el)

  edit: (id) ->
    wishes = @wishes.get(id)

    @view = new Guru.Views.Wishes.EditView(model: wishes)
    $("#wishes").html(@view.render().el)
