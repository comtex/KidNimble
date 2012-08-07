Guru.Views.Kids ||= {}

class Guru.Views.Kids.NewView extends Backbone.View
  template: JST["backbone/templates/kids/new"]

  events:
    "submit #new-kid": "save"

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
      success: (kid) =>
        @model = kid
        window.location.hash = "/#{@model.id}"

      error: (kid, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )
    $('select.styled').customStyle();

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
