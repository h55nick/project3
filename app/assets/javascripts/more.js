
$(function(){
  $('body').on('click','#more',moreplease)
  $('.career').show();
});

function moreplease(e){
  var zone = $('#more').attr('data-zone');
  var start = $('.career').length;
  console.log(start);
  settings={
    dataType: 'script',
    method: 'GET',
    data: {zone: zone, start:start},
    url: '/careers/more'
  };
  $.ajax(settings).done(moredone);
/*   e.preventDefault();*/
}

function moredone(e){
  e.preventDefault();
}