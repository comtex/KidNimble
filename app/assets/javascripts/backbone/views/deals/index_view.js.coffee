Guru.Views.Deals ||= {}

class Guru.Views.Deals.IndexView extends Backbone.View
  template: JST["backbone/templates/deals/index"]

  initialize: () ->
    @options.deals.bind('reset', @addAll)

  addAll: () =>
    @options.deals.each(@addOne)

  addOne: (deals) =>
    view = new Guru.Views.Deals.DealsView({model : deals})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(deals: @options.deals.toJSON() ))
    @addAll()

    return this
