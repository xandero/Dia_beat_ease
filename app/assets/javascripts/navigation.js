console.log('included')
$(document).ready(function() {
  $('.active').removeClass('active');
  var page = $('body').attr('class');
  if (page === 'meals-index') {
    $('.addmeal-link').closest('li').addClass('active');
  } else if (page === 'users-dashboard') {
        $('.dashboard-link').closest('li').addClass('active');
  } else if (page === 'bloodsugars-index') {
        $('.import-link').closest('li').addClass('active');
  } else if (page === 'activities-index') {
        $('.addactivity-link').closest('li').addClass('active');
  } else if (page === 'pages-weather') {
        $('.weather-link').closest('li').addClass('active');
  } else if (page === 'pages-calc') {
        $('.calculator-link').closest('li').addClass('active');
  }
});