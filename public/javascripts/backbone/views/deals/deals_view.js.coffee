Guru.Views.Deals ||= {}

class Guru.Views.Deals.DealsView extends Backbone.View
  template: JST["backbone/templates/deals/deals"]

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
