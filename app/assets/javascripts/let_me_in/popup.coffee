
window.popup_window = null
window.popup_close_callback = null

window.closePopup = (json) ->
  if window.popup_window?
    window.popup_window.close()
  if window.popup_close_callback?
    window.popup_close_callback(json)
  else 
    window.location.reload()

window.openPopup = (width, height, url, callback) ->  
  l = (screen.width - width) / 2   
  t = (screen.height - height) / 2 
  window.popup_close_callback = callback
  window.popup_window = window.open url, "__popup", "width=#{width}, height=#{height}, top=#{t}, left=#{l}, scrollbars=yes"
