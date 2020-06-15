$(document).on('turbolinks:load', function () {
  var input_paasword = $('input#user_password');
  var input_password_confirmation = $('input#user_password_confirmation');
  if (input_paasword.length && input_password_confirmation.length) {
    input_paasword.change(checkpassword);
    input_password_confirmation.change(checkpassword);
  }

  function checkpassword() {
    var element_style = null;
    if (!input_password_confirmation.val()) {
      input_password_confirmation.removeClass('is-invalid is-valid');
    } else if (input_paasword.val() == input_password_confirmation.val()) {
      input_password_confirmation.removeClass('is-invalid').addClass('is-valid');
    } else {
      input_password_confirmation.removeClass('is-valid').addClass('is-invalid');
    }


    //if(input_password_confirmation.next('span.passcheck') )
  }
});