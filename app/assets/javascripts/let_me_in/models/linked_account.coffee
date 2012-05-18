window.LinkedAccount = Backbone.Model.extend

  url: -> "/auth/#{@get('type')}/#{@get('id')}.json"

  initialize: (options) ->
    # nada yet
    
  isConnected: ->
    @get 'connected'
    
  isExpired: ->
    !@get('connected') && @get('app_username')?
    
window.LinkedAccounts = Backbone.Collection.extend
  model: LinkedAccount