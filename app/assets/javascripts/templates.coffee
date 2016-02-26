#$(document).ready ->
#  $('#section_last').focus ->
#    s_no = $('.section_field').length
#    console.log s_no
#    $.get('/templates/add_more_sections', s_no: s_no).done (data) ->
#      $('.section_field').last().focus()
#      return
#    return
#  $('.remove_j_qtn').click (e) ->
#    e.preventDefault()
#    sid = $(this).data('sid')
#    console.log sid
#    $('#template_sections_attributes_' + sid + '__destroy').val 1
#    $('#section_field_' + sid).remove()
#    $(this).remove()
#    false
#  return