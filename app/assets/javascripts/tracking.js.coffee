$(document).on 'page:change', ->
  _gaq.push ['_trackPageview']

$(document).ready ->
  $('.btn.tracked').mousedown ->
    category = "button"
    action = if $(this).attr('type') == 'submit' then 'sumbit' else 'click'
    label = $(this).attr('id')
    _gaq.push(["_trackEvent", category, action, label])