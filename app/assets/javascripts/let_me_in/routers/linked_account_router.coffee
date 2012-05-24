LinkedAccountRouter = Backbone.Router.extend

  routes: 
    "accounts": "linked_accounts"
    "signin": "signin"

  linked_accounts: ->
    if preloaded_data?
      accounts = (new LinkedAccounts).reset(preloaded_data.data)
      view = new LinkedAccountButtons collection: accounts, el: '#linked_accounts'
    new_view = new NewLinkedAccountButtons(accounts: accounts, el: '#new_linked_accounts')
  
  signin: -> 
    new NewSessionForm({preloaded: true, errors: (if errors? then errors else false)});
      
window.account_router = new LinkedAccountRouter()

($ "a.push_nav").live 'click', ->
  url = ($ this).attr('href')
  url = url.substring(1) if (url.indexOf("/") == 0)
  window.router.navigate url, true
  false
  
