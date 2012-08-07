Guru.Views.Wishes ||= {}

class Guru.Views.Wishes.IndexView extends Backbone.View
  template: JST["backbone/templates/wishes/index"]

  initialize: () ->
    @options.wishes.bind('reset', @addAll)

  addAll: () =>
    @options.wishes.each(@addOne)

  addOne: (wishes) =>
    view = new Guru.Views.Wishes.WishesView({model : wishes})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(wishes: @options.wishes.toJSON() ))
    @addAll()

    return this
