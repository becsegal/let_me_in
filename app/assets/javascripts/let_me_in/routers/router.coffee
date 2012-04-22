Router = Backbone.Router.extend

  routes: 
    "accounts": "linked_accounts"
    "signin": "signin"

  linked_accounts: ->
    if preloaded_data?
      accounts = (new LinkedAccounts).reset(preloaded_data.data)
      view = new LinkedAccountConnectors collection: accounts, el: '#linked_accounts'
  
  signin: -> 
    new NewSessionForm({preloaded: true, errors: errors});
      
window.admin_router = new Router()

Backbone.history.start({pushState: true})

($ "a.push_nav").live 'click', ->
  url = ($ this).attr('href')
  url = url.substring(1) if (url.indexOf("/") == 0)
  window.router.navigate url, true
  false
  
