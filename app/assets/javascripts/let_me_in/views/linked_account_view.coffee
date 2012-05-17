window.LinkedAccountButton = Backbone.View.extend
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
    if @model.isConnected() || @model.isExpired()
      $.ajax 
        type: 'DELETE'
        url: "/auth/#{@model.get('type')}/disconnect.json"
        data: {id: @model.get('id')}
        success: (data) =>
          @model.set data.data
    else
      openPopup 600, 400, "/auth/#{@model.get('type')}/connect"
    false
  
  render: ->
    @$el.html @template(@model.toJSON())
    @
    
    
window.LinkedAccountButtons = Backbone.View.extend
  tagName: "div"
  id: "linked_accounts"

  initialize: (options) ->
    @views = []
    @collection.each (linked_account) =>
      view = new LinkedAccountButton(model: linked_account, el: "#linked_account_#{linked_account.id}")
      @views.push view
    @collection.on("add", @render)
    
  render: ->
    console.debug "LinkedAccountButtons.render"

window.NewLinkedAccountButtons = Backbone.View.extend
  id: "new_linked_accounts"
  events: 
    "click button": "connect"
  
  initialize: (options) ->
    console.debug "NewLinkedAccountButtons.initialize"
    @real_accounts = options.accounts
    
  connect: (event) ->
    console.debug "connect"
    console.debug event
    console.debug "type: #{$(event.target).attr('data-type')}"
    openPopup 600, 400, "/auth/#{$(event.target).attr('data-type')}/connect", @addAccount
    false
    
  addAccount: (json) ->
    if !json.error?
      account = new LinkedAccount(json)
      console.debug "adding account: "
      console.debug account
      @real_accounts.add [account]
      console.debug "real accounts:"
      console.debug @real_accounts