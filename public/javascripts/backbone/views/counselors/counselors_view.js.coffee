Guru.Views.Counselors ||= {}

class Guru.Views.Counselors.CounselorsView extends Backbone.View
  template: JST["backbone/templates/counselors/counselors"]

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
