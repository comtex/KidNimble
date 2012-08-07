class Guru.Models.Counselors extends Backbone.Model
  paramRoot: 'counselor'

  defaults:
    user_id: null
    approved: null

class Guru.Collections.CounselorsCollection extends Backbone.Collection
  model: Guru.Models.Counselors
  url: '/counselors'
