class Guru.Models.Wishes extends Backbone.Model
  paramRoot: 'wish'

  defaults:
    buyable_id: null
    buyable_type: null
    user_id: null

class Guru.Collections.WishesCollection extends Backbone.Collection
  model: Guru.Models.Wishes
  url: '/wishes'
