$(document).ready ->
	$("input[type='radio'].trigger-text").click ->
		$("input[type='text'].triggered-text").focus()

	$("input[type='text'].triggered-text").blur ->
		$("input[type='radio'].trigger-text").val $("input[type='text'].triggered-text").val()

	$("input[type='radio'].trigger-text").attr "checked", true unless $("input[type='text'].triggered-text").val() is ""