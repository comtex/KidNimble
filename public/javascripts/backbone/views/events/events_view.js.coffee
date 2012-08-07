Guru.Views.Events ||= {}

class Guru.Views.Events.EventsView extends Backbone.View
  template: JST["backbone/templates/events/events"]

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
