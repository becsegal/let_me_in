window.UserForm = window.FormView.extend
  events: 
    "submit": "submit"

  init: (options) ->
    @setElement($("#user_form")) if options.preloaded?
    @model = if options.model then options.model else new User()

  submit: (event) ->
    me = @
    @model.save @formData(),
      url: @$el.attr "action"
      data: @$el.serialize()
      contentType: 'application/x-www-form-urlencoded' # rack doesn't parse params for application/json
      success: (model, response) -> me.success_callback(model, response)
      error: (model, response) -> me.error_callback(model, response)
    false
    
  success_callback: (model, response) ->
    next_url = response.extra.redirect_url
    window.location.href = (next_url || "/")
  
  error_callback: (model, response) ->
    @displayErrors JSON.parse(response.responseText)
      
      
window.NewUserForm = window.UserForm.extend

  error_callback: (model, response) ->
    alert_view = new AlertView(error: ["<strong>Uh oh.</strong> We had some problems signing you up."])
    @$el.find('.feedback').html(alert_view.render().el)
    @displayErrors JSON.parse(response.responseText)


window.NewSessionForm = window.UserForm.extend

  error_callback: (model, response) ->
    alert_view = new AlertView(error: ["Bad username/email and password combo"])
    @$el.find('.feedback').html(alert_view.render().el)