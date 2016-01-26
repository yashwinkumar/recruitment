$(document).ready(function () {

  $("#section_last").focus(function () {
    var s_no = $('.section_field').length;
    $.get('/templates/add_more_sections', {s_no: s_no})
      .done(function (data) {
        $('.section_field').last().focus();
      });
  });

  $('.remove_j_qtn').click(function (e) {
    e.preventDefault();
    sid = $(this).data('sid');
    console.log(sid);
    $('#template_sections_attributes_' + sid + '__destroy').val(1);
    $('#section_field_' + sid).remove();
    $(this).remove();
    return false;
  });
});

