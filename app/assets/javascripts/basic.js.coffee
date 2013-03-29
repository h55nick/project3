class Basic
  @document_ready: ->
    $('#user_form').on('click', 'a[data-clear-form]', Basic.cancel_form)
    $('body').on('dblclick', '.editable', Basic.change_to_input)
    $('.sectional-block').find('h3').hide()
    $('.sectional-block').on('mouseenter', Basic.colorize_block)
    $('.sectional-block').on('mouseleave', Basic.colorize_block)

  @cancel_form: (e) ->
    e.preventDefault()
    $('#user_form').empty()

  @change_to_input: (data) ->
    text = $(this).text()
    input = $('<input type="text">').val(text).addClass('large-4 columns')
    save = $('<a href="#">x</a>').addClass('left')
    $(this).parent().append(save).append(input)
    reg = $(this).hide()

  @colorize_block: ->
    $(this).toggleClass('hover')
    $(this).parent().find('h3').fadeToggle(300)


$(document).ready(Basic.document_ready)