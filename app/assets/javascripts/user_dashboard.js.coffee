window.user_dashboard =
  selected_careers: []

  ready: ->
    # this is all for switching between the panels
    $('.interests-menu-item').on('click', user_dashboard.switch_panel)
    $('.careers-menu-item').on('click', user_dashboard.switch_panel)
    $('.jobs-menu-item').on('click', user_dashboard.switch_panel)

    # this is all for the careers panel
    $('.careers-list').on('click', 'span', user_dashboard.select_career)

    # this is all for the jobs panel
    $('.wide-color').on('mouseover', '.job', user_dashboard.show_job_details)
    $('.wide-color').on('mouseleave', '.job', user_dashboard.hide_job_details)
    $('.saved-jobs').on('mouseover', user_dashboard.highlight_saved_jobs)
    $('.saved-jobs').on('mouseleave', user_dashboard.remove_highlight_saved_jobs)
    $('.applied-jobs').on('mouseover', user_dashboard.highlight_applied_jobs)
    $('.applied-jobs').on('mouseleave', user_dashboard.remove_highlight_applied_jobs)
    $('.saved-jobs').on('click', '#job-apply', user_dashboard.apply_to_job)

  ##########################
  ### basic panel functions
  ##########################

  switch_panel: ->
    if $(this).hasClass('interests-menu-item')
      $(this).parent().find('.dash-menu').removeClass('selected')
      $(this).addClass('selected')
      user_dashboard.hide_all()
      $('.my-interests').show()

    if $(this).hasClass('careers-menu-item')
      $(this).parent().find('.dash-menu').removeClass('selected')
      $(this).addClass('selected')
      user_dashboard.hide_all()
      $('.my-careers').show()

    if $(this).hasClass('jobs-menu-item')
      $(this).parent().find('.dash-menu').removeClass('selected')
      $(this).addClass('selected')
      user_dashboard.hide_all()
      $('.my-jobs').show()

  hide_all: ->
    $('.my-interests').hide()
    $('.my-careers').hide()
    $('.my-jobs').hide()

  ##########################
  ### my careers dashboard
  ##########################

  select_career: ->
    if !$(this).hasClass('selected')
      if user_dashboard.selected_careers.length < 3
        user_dashboard.selected_careers.push( $(this).data('career-id') )
      else
        user_dashboard.selected_careers.shift()
        user_dashboard.selected_careers.push( $(this).data('career-id') )
    else
      user_dashboard.selected_careers = _.without(user_dashboard.selected_careers, $(this).data('career-id') )

    $('.careers-list span').css('background', '#eee').removeClass('selected')
    _.each(user_dashboard.selected_careers, user_dashboard.highlight_career)

    settings =
      dataType: 'script'
      method: 'GET'
      url: "/careers/career_info?careers=#{user_dashboard.selected_careers}"

    $.ajax(settings)

  highlight_career: (id) ->
    color = $('.careers-list').data('color')
    $(".careers-list span[data-career-id=#{id}]").css('background', color).addClass('selected')

  show_interests_overlap: (career, user) ->
    career_data =
      fillColor: "rgba(238,238,238,0.8)"
      strokeColor: "rgba(255,255,255,1)"
      pointColor: "rgba(238,238,238,1)"
      pointStrokeColor : "#fff"
      data: career

    user_data =
      fillColor: "rgba(255,123,41,0.8)"
      strokeColor: "rgba(255,255,255,1)"
      pointColor: "rgba(255,123,41,1)"
      pointStrokeColor: "#fff"
      data: user

    data =
      labels: ["R","I","A","S","E","C"]
      datasets: [user_data, career_data]

    ctx = document.getElementById("my2Chart").getContext("2d");
    new Chart(ctx).Radar(data);

  ##########################
  ### my jobs dashboard
  ##########################

  show_job_details: ->
    $(this).children('.row').slideDown()

  hide_job_details: ->
    $(this).children('.row').slideUp()

  highlight_saved_jobs: ->
    color = $('.saved-jobs').find('.sectional-block').data('color')
    $('.saved-jobs').find('.sectional-block').css('background', color)
    $('.saved-jobs-list').css('opacity', '1')

  remove_highlight_saved_jobs: ->
    $('.saved-jobs').find('.sectional-block').css('background', '#eee')
    $('.saved-jobs-list').css('opacity','0.3')

  highlight_applied_jobs: ->
    color = $('.applied-jobs').find('.sectional-block').data('color')
    $('.applied-jobs').find('.sectional-block').css('background', color)
    $('.applied-jobs-list').css('opacity', '1')

  remove_highlight_applied_jobs: ->
    $('.applied-jobs').find('.sectional-block').css('background', '#eee')
    $('.applied-jobs-list').css('opacity','0.3')

  apply_to_job: ->
    job_id = $(this).closest('.job').data('job-id')
    token = $('input[name=authenticity_token]').val()
    settings =
      dataType: 'script'
      method: 'POST'
      url: '/jobs/apply'
      data: { authenticity_token: token, job_id: job_id }
    $.ajax(settings)
