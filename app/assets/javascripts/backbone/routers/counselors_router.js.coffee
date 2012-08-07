class Guru.Routers.CounselorsRouter extends Backbone.Router
  initialize: (options) ->
    @counselors = new Guru.Collections.CounselorsCollection()
    @counselors.reset options.counselors

  routes:
    "/new"      : "newCounselors"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newCounselors: ->
    @view = new Guru.Views.Counselors.NewView(collection: @counselors)
    $("#counselors").html(@view.render().el)

  index: ->
    @view = new Guru.Views.Counselors.IndexView(counselors: @counselors)
    $("#counselors").html(@view.render().el)

  show: (id) ->
    counselors = @counselors.get(id)
    console.log(counselors)

    @view = new Guru.Views.Counselors.ShowView(model: counselors)
    $("#counselors").html(@view.render().el)

  edit: (id) ->
    counselors = @counselors.get(id)

    @view = new Guru.Views.Counselors.EditView(model: counselors)
    $("#counselors").html(@view.render().el)
