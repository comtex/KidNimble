Guru.Views.Deals ||= {}

class Guru.Views.Deals.EditView extends Backbone.View
  template : JST["backbone/templates/deals/edit"]

  events :
    "submit #edit-deals" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (deals) =>
        @model = deals
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
