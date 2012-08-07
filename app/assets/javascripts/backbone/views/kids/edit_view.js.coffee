Guru.Views.Kids ||= {}

class Guru.Views.Kids.EditView extends Backbone.View
  template : JST["backbone/templates/kids/edit"]

  events :
    "submit #edit-kid" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()
    
    @model.unset("errors")
    
    @model.save(null,
      success : (kid) =>
        @model = kid
        window.location.hash = "/#{@model.id}"
        
      error: (kid, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )
    $('select.styled').customStyle();

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
