$(document).ready(function() {
 $('#delete-meal').on('click', function () {
  var $li = $(this).parent();
  var mealId = $li.data('meal-id');
  $.ajax(('/meals/' + mealId), {
    type: 'POST',
    data: {
      _method: 'DELETE'
    }
  });
});