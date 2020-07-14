$(document).on('turbolinks:load', function () {
  var counter_div = $('.time-counter');

  if(counter_div.length == 0) return;
  
  var end_date_str = JSON.parse($('.time-counter').attr('data-to'));
  var end_date = new Date(end_date_str);

  var time_span = counter_div.find('.time-seconds');

  setInterval(check_time, 1000)

  function check_time() {
    var remaining_time = (end_date - Date.now()) / 1000;
    time_span.text(Math.round(remaining_time));

    if(remaining_time <  0) {
      $('form').submit();
    }
  }
});
