Guru.Views.Wishes ||= {}

class Guru.Views.Wishes.ShowView extends Backbone.View
  template: JST["backbone/templates/wishes/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
