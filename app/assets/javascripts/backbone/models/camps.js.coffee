class Guru.Models.Camps extends Backbone.Model
  paramRoot: 'camp'
  defaults:
    zip: ""
    city: ""
    state: ""
    address: ""
  fetch: (args)->
    console.log args

class Guru.Collections.CampsCollection extends Backbone.Collection
  model: Guru.Models.Camps
  url: '/camps'
