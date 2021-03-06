window.survey =
  document_ready: ->
    $('.background-image').height( $(window).height() )
    $('.survey-wrapper').height( $(window).height() )
    $('.survey-question').css('padding-top', ($(window).height()/4))
    $('.survey-question').on('click', 'li', survey.next_question)
    survey.change_background(question) for question in $('.question')
    parallax.speed = 200
    parallax.intro1.top()

  next_question: ->
    q_id = $(this).parent().prev().children('span').first().data('questionId')
    q_val = $(this).text()
    s_id = $(this).closest('.background-image').attr('id')
    settings =
      dataType: 'script'
      method: 'POST'
      url: '/survey'
      data:
        question_id: q_id
        question_val: q_val
        survey_id: s_id
    $.ajax(settings)

  change_background: (question) ->
    bg = $(question).css('background')
    img = '/assets/blurred/' + $(question).parent().parent().find('.hide').text() + '-1.jpg'
    $(question).parent().parent().css('background', bg)
    $('body').css('background', "url('#{img}')")