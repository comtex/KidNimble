Guru.Views.Wishes ||= {}

class Guru.Views.Wishes.WishesView extends Backbone.View
  template: JST["backbone/templates/wishes/wishes"]

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
