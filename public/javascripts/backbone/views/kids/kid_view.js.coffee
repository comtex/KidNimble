Guru.Views.Kids ||= {}

class Guru.Views.Kids.KidView extends Backbone.View
  template: JST["backbone/templates/kids/kid"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
