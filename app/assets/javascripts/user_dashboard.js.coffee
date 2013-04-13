window.user_dashboard =
  ready: ->
    $('.interests-menu-item').on('click', user_dashboard.switch_panel)
    $('.careers-menu-item').on('click', user_dashboard.switch_panel)
    $('.jobs-menu-item').on('click', user_dashboard.switch_panel)

  switch_panel: ->
    if $(this).hasClass('interests-menu-item')
      $(this).parent().find('.dash-menu').removeClass('selected')
      $(this).addClass('selected')
      user_dashboard.hide_all()
      $('.my-interests').show()

    if $(this).hasClass('jobs-menu-item')
      $(this).parent().find('.dash-menu').removeClass('selected')
      $(this).addClass('selected')
      user_dashboard.hide_all()
      $('.my-jobs').show()

  hide_all: ->
    $('.my-interests').hide()
    $('.my-careers').hide()
    $('.my-jobs').hide()