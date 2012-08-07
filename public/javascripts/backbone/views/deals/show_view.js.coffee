Guru.Views.Deals ||= {}

class Guru.Views.Deals.ShowView extends Backbone.View
  template: JST["backbone/templates/deals/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
