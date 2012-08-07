Guru.Views.Kids ||= {}

class Guru.Views.Kids.ShowView extends Backbone.View
  template: JST["backbone/templates/kids/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
