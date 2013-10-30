jQuery ($) ->

  renderError = (form, msg) ->
    errorHtml = " <div class='center' id='error_explanation'>
                    <div class='alert alert-dismissable alert-danger'>
                      <button aria-hidden='true' class='close' data-dismiss='alert' type='button'>×</button>
                      
                      
                        <p>" + msg + "</p>
                      
                    </div>
                  </div> "
    form.find('.payment-errors').append errorHtml

  $("button[name=submit_button]").click ->
    # track form submission (both successful and not)
    _gaq.push(["_trackEvent", "button", "submit", "form-submit-btn"])
    
    $('#payment-form').submit (event) ->
      $(document).find('.alert').hide()
      
      $form = $(this);
      # Disable the submit button to prevent repeated clicks
      $form.find('button').prop 'disabled', true

      Stripe.card.createToken $form, stripeResponseHandler

      # Prevent the form from submitting with the default action
      false

    stripeResponseHandler = (status, response) ->
      $form = $('#payment-form')
      if response.error
        # Show the errors on the form
        renderError($form, response.error.message)
        $form.find('button').prop 'disabled', false
        # Re-enable back button
        $form.unbind 'submit'
      else
        # token contains id, last4, and card type
        token = response.id
        # Insert the token into the form so it gets submitted to the server
        $form.append $('<input type="hidden" name="stripeToken" />').val(token)
        # and submit
        $form.find('button').prop 'disabled', true
        $form.get(0).submit()