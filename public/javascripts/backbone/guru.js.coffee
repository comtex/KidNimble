#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Guru =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}

$.ajaxSetup
  beforeSend: (xhr) ->
    xhr.setRequestHeader "Accept", "application/json"
  cache: false
