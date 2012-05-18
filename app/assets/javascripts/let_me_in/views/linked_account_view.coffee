window.LinkedAccountButton = Backbone.View.extend
  tagName:    "p"
  className:  "connect_linked_account"
  template:   JST["let_me_in/linked_accounts/show"]
  events: 
    "click button": "toggleConnect"
    "click .disconnect": "toggleConnect"
    
  initialize: (options) ->
    _.bindAll @
    @model.on("change", => @render())
  
  toggleConnect: (event) ->
    if @model.isConnected() || @model.isExpired()
      @model.destroy()
    else
      openPopup 600, 400, "/auth/#{@model.get('type')}/connect"
    false
  
  render: ->
    @$el.html @template(@model.toJSON())
    @
    
    
window.LinkedAccountButtons = Backbone.View.extend
  tagName: "div"
  id: "linked_accounts"
  template: JST["let_me_in/linked_accounts/index"]

  initialize: (options) ->
    _.bindAll @
    @views = []
    @initViews()
    @collection.on("add remove", @render)
    
  initViews: ->
    @collection.each (linked_account) =>
      view = new LinkedAccountButton(model: linked_account, el: "#linked_account_#{linked_account.id}")
      @views.push view
    
  render: ->
    @$el.html @template(data: @collection.toJSON())
    @initViews()
    @

window.NewLinkedAccountButtons = Backbone.View.extend
  id: "new_linked_accounts"
  events: 
    "click button": "connect"
  
  initialize: ->
    _.bindAll @
    @real_accounts = @options.accounts
    
  connect: (event) ->
    openPopup 600, 400, "/auth/#{$(event.target).attr('data-type')}/connect", @addAccount
    false
    
  addAccount: (json) ->
    if !json.error?
      @real_accounts.add [new LinkedAccount(json)]
      