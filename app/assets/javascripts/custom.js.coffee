$(document).ready ->

  # style text field nested into radio button
  $("input[type='radio'].trigger-text").click ->
    $("input[type='text'].triggered-text").focus()

  $("input[type='text'].triggered-text").blur ->
    $("input[type='radio'].trigger-text").val $("input[type='text'].triggered-text").val()

  $("input[type='radio'].trigger-text").attr "checked", true unless $("input[type='text'].triggered-text").val() is ""

  # remove error styling when focus
  $('div.form-group div.field_with_errors').children().focus ->
    $(this).parent().siblings().addBack().removeClass('field_with_errors')

  $('form div.alert-dismissable button.close').click ->
    $('form .field_with_errors').removeClass('field_with_errors')