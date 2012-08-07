Guru.Views.Camps ||= {}

class Guru.Views.Camps.EditView extends Backbone.View
  template : JST["backbone/templates/camps/edit"]

  events :
    "submit #edit-camps" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (camps) =>
        @model = camps
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
