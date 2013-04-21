window.resizer =
  user_dashboard: ->
    nav_top = $('.nav-wrapper').height()
    row_top = $('.nav-wrapper').next().height()
    spacing_top = $(window).height() - nav_top - row_top
    $('.nav-wrapper').next().css('padding-top', (spacing_top/2)).css('padding-bottom', (spacing_top/2))
    nav_bottom = $('.wide-color').height()
    row_bottom = $('.wide-color-below').height()
    spacing_bottom = $(window).height() - nav_bottom - row_bottom
    $('.wide-color-below').css('padding-top', (spacing_bottom/2)).css('padding-bottom', (spacing_bottom/2))
