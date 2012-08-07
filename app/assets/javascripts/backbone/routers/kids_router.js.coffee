class Guru.Routers.KidsRouter extends Backbone.Router
  initialize: (options) ->
    @kids = new Guru.Collections.KidsCollection()
    @kids.reset options.kids

  routes:
    "/new"        : "newKid"
    "/index"      : "index"
    "/:id/edit"   : "edit"
    "/:id"        : "show"
    ".*"          : "index"

  newKid: ->
    @view = new Guru.Views.Kids.NewView(collection: @kids)
    $("#kids").html(@view.render().el)
    $('select.styled').customStyle();

  index: ->
    @view = new Guru.Views.Kids.IndexView(kids: @kids)
    $("#kids").html(@view.render().el)

  show: (id) ->
    kid = @kids.get(id)

    @view = new Guru.Views.Kids.ShowView(model: kid)
    $("#kids").html(@view.render().el)

  edit: (id) ->
    kid = @kids.get(id)

    @view = new Guru.Views.Kids.EditView(model: kid)
    $("#kids").html(@view.render().el)
    $('select.styled').customStyle();
    
