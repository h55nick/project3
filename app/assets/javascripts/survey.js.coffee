window.survey =
  document_ready: ->
    $('.background-image').height( $(window).height() )
    $('.survey-wrapper').height( $(window).height() )
    $('.survey-question').css('padding-top', ($(window).height()/4))
    $('.survey-question').on('click', 'li', survey.next_question)
    survey.change_background(question) for question in $('.question')
    parallax.q1.top()

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
    img = '/assets/' + $(question).parent().parent().find('.hide').text() + '-1.jpg'
    $(question).parent().parent().css('background', bg)
    $(question).parent().parent().parent().css('background', "url('#{img}') no-repeat")

  # random_background: ->
  #   colors = ['#4D5360', '#FFC629', '#FF2151', '#FF7B29', '#8B77B5', '#FCE9C8']
  #   # grey, yellow, red, orange, purple, beige
  #   random = Math.floor((Math.random()*6)+1)
  #   $color_bg = false
  #   if $color_bg == false
  #     console.log('inside')
  #     $('.survey-wrapper').animate({ opacity: 0 }, 1000).delay(1000).css('background-color', colors[random]).animate({ opacity: 1 }, 1000)
  #     color_bg = true
  #   else
  #     console.log('to white')
  #     $('.survey-wrapper').animate({ opacity: 0 }, 1000).css('background', '#FFFFFF').animate({ opacity: 1 }, 1000)
  #     $color_bg = false