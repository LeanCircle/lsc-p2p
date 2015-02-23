$('#link_preview').ready ->
  # Function to resize iFrame
  resize_iframe = ->
    viewportHeight = $(window).height()
    # Subtract height of "top bar"
    $('#link_preview').css height: viewportHeight - 80
    return

  resize_iframe()

  # Also, resize iFrame when the window is resized
  $(window).resize resize_iframe

  return