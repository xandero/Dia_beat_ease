// JS for the throwaway calc

var searchFoods = function () {
  var query = $('#query').val();
  var nutritionixUrl = 'https://api.nutritionix.com/v1_1/search/' + query;

  $.getJSON(nutritionixUrl, {
    appId: "92a57023",
    appKey: "5a11032e7168104fdfa242bd3b62e636",
    results: "0:2"
  }).done(listResults);
};

var listResults = function (result) {
  var foods = result.hits

  _(foods).each(function (food) {
    var $link = $('<a>').text(food.fields.item_name);

    // can't seem to attach .data() k/v pairs
    $link.attr('data-foodname', food.fields.item_name)
    $link.attr('data-item_id', food.fields.item_id);

    $link.addClass('result');
    var $li = $('<li>');
    $li.addClass('li');
    $li.append($link);
    $('#search-results').append($li);
  });
};



$(document).ready(function() {
  $('#calculate').on('click', function (event) {
    event.preventDefault();
    $('#search-results').empty();
    searchFoods();
  });

  $('#single-calc').keydown(function(event){
    if(event.keyCode == 13) {
      // event.preventDefault();
      $('#search-results').empty();
      $(this).blur();
      searchFoods();
      return false;
    }
  });
});