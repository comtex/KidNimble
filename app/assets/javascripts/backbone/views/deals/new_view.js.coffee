Guru.Views.Deals ||= {}

class Guru.Views.Deals.NewView extends Backbone.View
  template: JST["backbone/templates/deals/new"]

  events:
    "submit #new-deals": "save"

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
      success: (deals) =>
        @model = deals
        window.location.hash = "/#{@model.id}"

      error: (deals, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
