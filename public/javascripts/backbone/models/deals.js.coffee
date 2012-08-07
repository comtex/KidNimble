class Guru.Models.Deals extends Backbone.Model
  paramRoot: 'deal'

  defaults:
    camp_id: null
    title: null
    description: null

class Guru.Collections.DealsCollection extends Backbone.Collection
  model: Guru.Models.Deals
  url: '/deals'
