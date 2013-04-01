/*var url = "";
$(function(){
    var params = "java";
    var city = "austin";
    var state = "tx";
    var limit = "100";
    url = "http://api.indeed.com/ads/apisearch?publisher=6311669519978301&q="+params+"&l="+city+"%2C+"+state+"&radius=&st=&jt=&start=&limit="+limit+"&fromage=&form=json&filter=&latlong=1&co=us&chnl=&userip=1.2.3.4&useragent=Mozilla/%2F4.0%28Firefox%29&v=2";
    url = "http://api.indeed.com/ads/apisearch?publisher=6311669519978301&q=java&l=austin+tx&sort=&format=json&v=2";
    $('#search').click(ret);

});

  function ret(){
      var settings ={
        dataType: 'json',
        type: 'get',
        url: url
      };
    $.ajax(settings).done(result_show);
}
function result_show(){
      alert("BOOM");
}*/
$(function(){
  $('#dbear').hide();
  $('body').keypress(dancingbear);

});


function dancingbear(e){
if(e.keyCode === 98){
  $('#dbear').toggle('hide');
  $('.hero').toggle('hide');
}
}