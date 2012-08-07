Guru.Views.Camps ||= {}

class Guru.Views.Camps.NewView extends Backbone.View
  template: JST["backbone/templates/camps/new"]

  events:
    "submit #new-camps": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (camps) =>
        @model = camps
        window.location.hash = "/#{@model.id}"

      error: (camps, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
