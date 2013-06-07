window.iso =
  init:->
    #LISTENERS
    #$('body').on('change',"#first_filter_choice",iso.reset)
    $('body').on('click','.obar', iso.toggle_selected_bar)
    $('body').on('click',"#refilter",iso.anajax)
    $('body').on('click','#more_info',-> $('body').chardinJs('start');)

    $('#careerblock').on('mouseover', '.career', iso.show_additional_details)
    $('#careerblock').on('mouseleave', '.career', iso.hide_additional_details)

    ## PRESETS
    $(".dial").knob({'min':0,'max':100})
    #ISO
    $('#list').isotope({
      itemSelector : '.item',
      layoutMode : 'fitRows'
    });
    #JQUERY-UI
    $("#prep-range").slider
      range: true
      min: 1
      max: 5
      values: [3, 5]
      slide: (event, ui) ->
        $("#prep-amount").val "" + ui.values[0] + " - " + ui.values[1]
        prep_levels = _.range(ui.values[0], ui.values[1]+1);
        $('#prep_values').val(prep_levels)
    $("#prep-amount").val "" + $("#prep-range").slider("values", 0) + " - " + $("#prep-range").slider("values", 1)
    $("#growth-range").slider
      range: true
      min: 1
      max: 5
      values: [3, 5]
      slide: (event, ui) ->
        $("#growth-amount").val "" + ui.values[0] + " - " + ui.values[1]
        growth_levels = _.range(ui.values[0], ui.values[1]+1);
        $('#growth_values').val(growth_levels)
    $("#growth-amount").val "" + $("#growth-range").slider("values", 0) + " - " + $("#growth-range").slider("values", 1)


    # this is for selecting the filters
    $('.filters').on('click', '.preparation', iso.show_filters)
    $('.filters').on('click', '.growth', iso.show_filters)
    $('.filters').on('click', '#advanced', iso.show_filters)

    console.log('iso.init')

  toggle_selected_bar:->
    console.log('toggle_selected')
    $(this).attr('data-select',($(this).attr('data-select') != "true"))
    $(this).toggleClass("bar_selected")
    growth_levels = $.makeArray($(".growth_filter[data-level]").map(->
        if $(this).attr('data-select') == "true"
          $(this).attr "data-level"
      ))
    prep_levels = $.makeArray($(".prep_filter[data-level]").map(->
        if $(this).attr('data-select') == "true"
          $(this).attr "data-level"
      ))
    $('#growth_values').val(growth_levels)
    $('#prep_values').val(prep_levels)

  anajax:->
    $('.additional-career-details').slideUp()
    # $('#loading').remove()
    if $('#careerblock').children().length > 0
      $('.career-list').animate({opacity:0.2}, 400)
      $('.career-list').parent().prepend("<h3 id='loading' style='text-align: center; margin: 50px 0; display:none;'>Loading...</h3>")
      $('#loading').delay(400).slideDown()
    else
      $('.career-list').parent().prepend("<h3 id='loading' style='text-align: center; margin: 50px 0;'>Loading...</h3>")
    $('#careerblock').slideUp(3000);

  filter_job_zone:(e) ->
    e.preventDefault()
    $(this).parent().parent().children().removeClass('active')
    $(this).parent().addClass('active')
    $('#filterblock').attr('data-efilter',$(this).text())
    attrs = iso.get_filter_attr()
    iso.all_filter(attrs)

  filter_growth_zone:(e) ->
    e.preventDefault()
    $(this).parent().parent().children().removeClass('active')
    $(this).parent().addClass('active')
    $('#filterblock').attr('data-gfilter',$(this).text())
    attrs = iso.get_filter_attr()
    console.log("G: Filtering: "+ attrs)
    iso.all_filter(attrs)

  filter_reset:->
    attrs = iso.get_filter_attr()
    iso.all_filter(attrs)

  all_filter:(attrs)->
    console.log("af: #{attrs}")
    $("#list").isotope
      filter: "#{attrs}"
      ($items) ->
        id = @attr("id")
        len = $items.length
        console.log "Isotope has filtered for " + len + " items in #" + id

  get_filter_attr:->
      growth = $('#filterblock').attr('data-gfilter');
      zone = $('#filterblock').attr('data-efilter');
      zone = "" if zone == "1"
      return ".g#{growth}.z#{zone}"

  reset:->
      console.log("reset")

  show_additional_details: ->
    $(this).find('.additional-career-details').css('opacity', 1)

  hide_additional_details: ->
    $(this).find('.additional-career-details').css('opacity', 0.3)

  ##########################
  ### selecting filters
  ##########################

  show_filters: ->
    if $(this).hasClass('preparation')
      $('.total-filter-dropdown').slideUp()
      $('.growth-dropdown').slideUp()
      $('.preparation-dropdown').slideDown()

    if $(this).hasClass('growth')
      $('.total-filter-dropdown').slideUp()
      $('.preparation-dropdown').slideUp()
      $('.growth-dropdown').slideDown()

    if $(this).attr('id') == 'advanced'
      $('.preparation-dropdown').slideUp()
      $('.growth-dropdown').slideUp()
      $('.total-filter-dropdown').slideDown()


 ### reget:->
      console.log("reget-#{$(this).val()}")
      settings =
      dataType: 'script'
      method: 'get'
      url: '/careers/filter'
      data:
        filter_var: $(this).val()
      $.ajax(settings)###

$(document).ready(iso.init)