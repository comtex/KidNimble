Guru.Views.Camps ||= {}

class Guru.Views.Camps.CampsView extends Backbone.View
  template: JST["backbone/templates/camps/camps"]

  events:
    "click .destroy" : "destroy"

  tagName: "li"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this