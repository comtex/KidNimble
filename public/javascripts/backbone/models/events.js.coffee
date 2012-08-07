class Guru.Models.Events extends Backbone.Model
  paramRoot: 'event'

  defaults:
    start_at: null
    end_at: null
    name: null
    camp_id: null

class Guru.Collections.EventsCollection extends Backbone.Collection
  model: Guru.Models.Events
  url: '/events'
