$(document).ready(function() {
  $('.side-nav').on('click', 'li a', function () {
   $('.chosen-one').removeClass('chosen-one');
   $(this).addClass('chosen-one');
  });
});


