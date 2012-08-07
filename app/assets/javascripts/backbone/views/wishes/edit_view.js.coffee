Guru.Views.Wishes ||= {}

class Guru.Views.Wishes.EditView extends Backbone.View
  template : JST["backbone/templates/wishes/edit"]

  events :
    "submit #edit-wishes" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (wishes) =>
        @model = wishes
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
