window.LinkedAccount = Backbone.Model.extend
  initialize: (options) ->
    # nada yet
    
  isConnected: ->
    @get 'connected'
    
  isExpired: ->
    !@get('connected') && @get('app_username')?
    
window.LinkedAccounts = Backbone.Collection.extend
  model: LinkedAccount