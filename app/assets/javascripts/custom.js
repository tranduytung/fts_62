var ready;

ready = function () {
  start_page();
  $('body').on('DOMNodeInserted', function () {
    start_page();
  })
}

function start_page () {
  $(".form_user").hide();
}

$(document).ready(ready);
$(document).on('page:load', ready);

var prev;

$(document).on("focus", ".people_type", function() {
  prev = this.value;
});

$(document).on("focus", ".people_type", function() {
  prev = this.value;
});

$(document).on("change", ".people_type", function() {

  if($(this).val() == "user") {
    $(".form_admin").hide();
    $(".form_user").show();
  } else if ($(this).val() == "admin") {
    $(".form_admin").show();
    $(".form_user").hide();
  }
  prev = $(this).val();
});
