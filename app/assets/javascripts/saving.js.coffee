window.saver =
  remove_career_from_user: ->
    id = $(this).data('career-id')
    settings =
      dataType: 'script'
      method: 'POST'
      url: "/careers/remove_career"
      data: { _method:'DELETE', career_id: id }
    $.ajax(settings)

  save_career: ->
    console.log("save_career")
    $(this).css('background','');
    $(this).css('background','/assets/checkmark.svg');
    id = $(this).data().cid;
    settings =
      dataType: 'script'
      method: 'POST'
      url: "/careers/add_career"
      data: {career_id: id }
    $.ajax(settings)