window.iso =
  init:->
    console.log('iso.init')
    #LISTENERS
    #$('body').on('change',"#first_filter_choice",iso.reset)
    $('body').on('click','.obar', iso.toggle_selected_bar)
    $('body').on('click',"#refilter",iso.anajax)
    ## PRESETS
    $(".dial").knob({'min':0,'max':100})
    $('#list').isotope({
      itemSelector : '.item',
      layoutMode : 'fitRows'
    });

    # this is for selecting the filters
    $('.filters').on('click', '.preparation', iso.show_filters)
    $('.filters').on('click', '.growth', iso.show_filters)
    $('.filters').on('click', '#advanced', iso.show_filters)

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