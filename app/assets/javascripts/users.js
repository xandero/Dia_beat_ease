function getWeather(lat,long){
  var apiKey = '0bc0203aed2cfca106f903a48670b4c4';
  var url = 'https://api.forecast.io/forecast/';
  //var lati = -37.8449;
  //var longi = 145.0451;
  var lati = lat;
  var longi = long;
  var data;       
  //units=ca makes temps in celcius and wind speed in KM PH
  $.getJSON(url + apiKey + "/" + lati + "," + longi + "?callback=?&units=ca", function(data) {
    console.log(data);
    console.log(data.daily.data);
    debugger;
    $('#weather').html('time    : ' + data.currently.time +
     '<br>summary               : ' + data.currently.summary +
     '<br>timezone              : ' + data.timezone +
     '<br>temperature           : ' + data.currently.temperature +
     '<br>apparentTemperature   : ' + data.currently.apparentTemperature +                               
     '<br>temperatureMax        : ' + data.daily.data[0].temperatureMax +
     '<br>temperatureMaxTime    : ' + data.daily.data[0].temperatureMaxTime +
     '<br>temperatureMin        : ' + data.daily.data[0].temperatureMin +
     '<br>temperatureMinTime    : ' + data.daily.data[0].temperatureMinTime +
     '<br>units                 : ' + data.flags.units   

    );
  });
}
$( document ).ready(function() {
  $("#getData").click(function(){
    var lat = $("#lat").val();
    var long = $("#long").val();
    getWeather(lat,long);
  });
});