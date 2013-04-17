window.splash =
  ready: ->
    $('.interest').on('click', window.splash.slide_interest_info)
  slide_interest_info: ->
    $('.interest').fadeOut(400)
    if $(this).hasClass('artistic') then $('.interest-artistic.interest').delay(400).fadeIn(400)
    if $(this).hasClass('realistic') then $('.interest-realistic.interest').delay(400).fadeIn(400)
    if $(this).hasClass('enterprising') then $('.interest-enterprising.interest').delay(400).fadeIn(400)
    if $(this).hasClass('social') then $('.interest-social.interest').delay(400).fadeIn(400)
    if $(this).hasClass('investigative') then $('.interest-investigative.interest').delay(400).fadeIn(400)
    if $(this).hasClass('conventional') then $('.interest-conventional.interest').delay(400).fadeIn(400)
  load_graphs: ->
    data =
      labels: ["Technical Writer","Anthropologist","Translator"],
      datasets: [{
        fillColor : "rgba(220,220,220,0.5)",
        strokeColor : "rgba(220,220,220,1)",
        data : [64610,56070,44160]
        }]
    options =
      scaleShowGridLines : true

    myChart = new Chart(document.getElementById("bar").getContext("2d")).Bar(data, options)