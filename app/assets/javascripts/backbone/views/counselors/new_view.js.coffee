Guru.Views.Counselors ||= {}

class Guru.Views.Counselors.NewView extends Backbone.View
  template: JST["backbone/templates/counselors/new"]

  events:
    "submit #new-counselors": "save"

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
      success: (counselors) =>
        @model = counselors
        window.location.hash = "/#{@model.id}"

      error: (counselors, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
