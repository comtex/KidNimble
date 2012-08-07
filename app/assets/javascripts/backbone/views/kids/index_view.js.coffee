Guru.Views.Kids ||= {}

class Guru.Views.Kids.IndexView extends Backbone.View
  template: JST["backbone/templates/kids/index"]

  initialize: () ->
    @options.kids.bind('reset', @addAll)

  addAll: () =>
    @options.kids.each(@addOne)

  addOne: (kid) =>
    view = new Guru.Views.Kids.KidView({model : kid})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(kids: @options.kids.toJSON() ))
    @addAll()

    return this
