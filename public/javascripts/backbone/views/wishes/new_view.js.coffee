Guru.Views.Wishes ||= {}

class Guru.Views.Wishes.NewView extends Backbone.View
  template: JST["backbone/templates/wishes/new"]

  events:
    "submit #new-wishes": "save"

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
      success: (wishes) =>
        @model = wishes
        window.location.hash = "/#{@model.id}"

      error: (wishes, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
