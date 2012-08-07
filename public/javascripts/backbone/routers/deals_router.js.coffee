class Guru.Routers.DealsRouter extends Backbone.Router
  initialize: (options) ->
    @deals = new Guru.Collections.DealsCollection()
    @deals.reset options.deals

  routes:
    "/new"      : "newDeals"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newDeals: ->
    @view = new Guru.Views.Deals.NewView(collection: @deals)
    $("#deals").html(@view.render().el)

  index: ->
    @view = new Guru.Views.Deals.IndexView(deals: @deals)
    $("#deals").html(@view.render().el)

  show: (id) ->
    deals = @deals.get(id)

    @view = new Guru.Views.Deals.ShowView(model: deals)
    $("#deals").html(@view.render().el)

  edit: (id) ->
    deals = @deals.get(id)

    @view = new Guru.Views.Deals.EditView(model: deals)
    $("#deals").html(@view.render().el)
