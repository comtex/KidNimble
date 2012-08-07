Guru.Views.Camps ||= {}

class Guru.Views.Camps.ShowView extends Backbone.View
  template: JST["backbone/templates/camps/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
