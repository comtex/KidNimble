Guru.Views.Counselors ||= {}

class Guru.Views.Counselors.EditView extends Backbone.View
  template : JST["backbone/templates/counselors/edit"]

  events :
    "submit #edit-counselors" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (counselors) =>
        @model = counselors
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
