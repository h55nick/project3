window.saver =
  save_career_to_user: ->
    id = $(this).data('career-id')
    settings =
      dataType: 'script'
      method: 'POST'
      url: "/careers/add_career"
      data: { career_id: id }
    $.ajax(settings)

  remove_career_from_user: ->
    id = $(this).data('career-id')
    settings =
      dataType: 'script'
      method: 'POST'
      url: "/careers/remove_career"
      data: { _method:'DELETE', career_id: id }
    $.ajax(settings)