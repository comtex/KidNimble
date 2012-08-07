class Guru.Models.Kid extends Backbone.Model
  paramRoot: 'kid'

  defaults:
    name: null
    sex: null
    born_at: null

class Guru.Collections.KidsCollection extends Backbone.Collection
  model: Guru.Models.Kid
  url: '/kids'
