window.LinkedAccountConnector = Backbone.View.extend
  tagName:    "p"
  className:  "connect_linked_account"
  template:   JST["let_me_in/linked_accounts/show"]
  events: 
    "click button": "toggleConnect"
    "click .disconnect": "toggleConnect"
    
  initialize: (options) ->
    me = @
    @model.on("change", -> me.render())
      
  toggleConnect: (event) ->
    me = @
    if @model.isConnected() || @model.isExpired()
      $.ajax 
        type: 'DELETE'
        url: "/auth/#{@model.get('type')}/disconnect.json"
        data: {id: @model.get('id')}
        success: (data) ->
          me.model.set data.data
    else
      openPopup 600, 400, "/auth/#{@model.get('type')}/connect"
    false
  
  render: ->
    @$el.html @template(@model.toJSON())
    @
    
    
window.LinkedAccountConnectors = Backbone.View.extend
  tagName: "div"
  id: "linked_accounts"

  initialize: (options) ->
    @views = []
    me = @
    @collection.each (linked_account) ->
      view = new LinkedAccountConnector(model: linked_account, el: "#linked_account_#{linked_account.id}")
      me.views.push view