function remove_fields(link) {
  $(link).prev('input[type=hidden]').val('1');
  $(link).closest('.field').hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp('new_' + association, 'g')
  $(link).parent().before(content.replace(regexp, new_id));
}

function addForm() {
  var association = 'answers';
  var regexp = new RegExp('new_' + association, 'g');
  var new_id = new Date().getTime();
  $('.add_answer').before(window[association + '_field'].replace(regexp, new_id));
  $('.correct-choose').hide();
  $('.remove-choose').hide();
  $('.add_answer').hide();
}

function changeType() {
  var options = $('.field');
  for(i = 0; i < options.length; i++){
    $(options[i].querySelector('.remove-choose > a')).prev('input[type=hidden]').val('1');
    $(options[i].querySelector('.remove-choose > a')).addClass('hidden');
  }
  options.addClass('hidden');
}

var prev;
$(document).on('focus', '.question-type', function() {
  prev = this.value;
});

$(document).on('change', '.question-type', function() {
  if($(this).val() == 'single_choice') {
    changeType();
    $('.add_answer').show();
    var allCheckboxs = $('.correct');
    allCheckboxs.each(function(index, cb) {
      $(cb).attr('checked', false);
    })
    if(prev == 'text'){
      changeType();
    }
  } else if ($(this).val() == 'multiple_choice') {
    changeType();
    $('.add_answer').show();
    if(prev == 'text'){
      changeType();
    }
  } else if($(this).val() == 'text') {
    var x = $(this).val();
    changeType();
    addForm();
    var allCheckboxs = $('.correct');
    allCheckboxs.each(function(index, cb) {
      $(cb).attr('checked', true);
    })
  }
  prev = $(this).val();
});
