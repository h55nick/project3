window.survey =
  document_ready: ->
    $('.survey-wrapper').height( $(window).height() )
    $('.question span').fadeIn(800)