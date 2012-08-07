Guru.Views.Counselors ||= {}

class Guru.Views.Counselors.IndexView extends Backbone.View
  template: JST["backbone/templates/counselors/index"]

  initialize: () ->
    @options.counselors.bind('reset', @addAll)

  addAll: () =>
    @options.counselors.each(@addOne)

  addOne: (counselors) =>
    view = new Guru.Views.Counselors.CounselorsView({model : counselors})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(counselors: @options.counselors.toJSON() ))
    @addAll()

    return this
