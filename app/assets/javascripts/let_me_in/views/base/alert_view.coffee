window.AlertView = Backbone.View.extend
  className: "alerts"
  template: JST['alerts/index']
  
  initialize: (options) ->
    _.bindAll @, 'render'
    @error = options.error
    @notice = options.notice

  clearAll: ->
    $("._alert").remove()
    
  render: ->
    @$el.html @template
      error: if @error then @error.join("<br />") else false
      notice: if @notice then @notice.join("<br />") else false
    @
