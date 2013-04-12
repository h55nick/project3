window.iso =
    init:->
      console.log('iso.init')
      $(".dial").knob({'min':0,'max':100})
      $('#list').isotope({
        itemSelector : '.item',
        layoutMode : 'fitRows'
      });
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


$(document).ready(iso.init)