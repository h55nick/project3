class Basic
  @document_ready: ->
    $('#user_form').on('click', 'a[data-clear-form]', Basic.cancel_form)
    $('body').on('dblclick', '.editable', Basic.change_to_input)

  @cancel_form: (e) ->
    e.preventDefault()
    $('#user_form').empty()

  @change_to_input: (data) ->
    text = $(this).text()
    input = $('<input type="text">').val(text).addClass('large-4 columns')
    save = $('<a href="#">x</a>').addClass('left')
    $(this).parent().append(save).append(input)
    reg = $(this).hide()


$(document).ready(Basic.document_ready)