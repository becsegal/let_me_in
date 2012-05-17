window.FormView = Backbone.View.extend

  initialize: (options) ->
    @init(options)
    @displayErrors(options.errors) if options.errors
    
  # Override in subclasses
  init: (options) ->
    
  clearErrors: ->
    @$el.find(".control-group").removeClass("error")
    @$el.find("._alert").remove()

  displayErrors: (errors) ->
    @clearErrors()
    me = @
    errors = errors.error if errors.error
    _.each errors, (value, key) ->
      $control_group = (me.$el).find("._#{key}_group")
      if $control_group.length > 0
        view = new FormErrorView(message: value) 
        $control_group.addClass('error')
        $control_group.find('.controls').append(view.render().el)
  
  formData: ->
    attr = {}
    _.each @$el.serializeArray(), (item) ->
      attr[item.name] = item.value
    attr

window.FormErrorView = Backbone.View.extend
  tagName: "span",
  className: "_alert help-inline",
  template: JST['let_me_in/alerts/inline']
  
  initialize: (options) ->
    @message = options.message

  render: ->
    ($ @el).html @message
    @