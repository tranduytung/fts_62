var countdown = function() {
  $('#clock').countdown({
    until: $('#remaining_time').val(),
    format: 'HMS',
    onExpiry: function() {
      alert('Your exam has timed out. Your test will be submitted automatically');
      $('.submit-time-out').trigger('click');
      $('.submit-time-out').hidden();
    }
  });
}

document.addEventListener('turbolinks:load', countdown);
$(document).on('page:update', countdown);
