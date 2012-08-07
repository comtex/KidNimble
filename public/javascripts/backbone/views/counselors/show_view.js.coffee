Guru.Views.Counselors ||= {}

class Guru.Views.Counselors.ShowView extends Backbone.View
  template: JST["backbone/templates/counselors/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
