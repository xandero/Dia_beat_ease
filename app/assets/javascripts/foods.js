// new food AJAX stuff
console.log('hi')

// brings back a JSON object with the specified number of results (based on the user's search query, e.g. banana)
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
  console.log(result);

  // 'hits' is an array of foods/search results
  var foods = result.hits


  // need to loop through and print out each food with id
  _(foods).each(function (food) {
    var $link = $('<a>').text(food.fields.item_name);

    // need to get these data attributes working (codescool jQuery stuff)
    // might be because they are not being selected from the dom
    // currently not secure as attrs but still working (change later)
    $link.attr('item_id', food.fields.item_id);
    $link.addClass('result');
    var $li = $('<li>');
    $li.append($link);
    $('#search-results').append($li);
  });
};

var showFood = function () {
  // 'this' is empty, not getting the right thing
  // when this is done, attrs can be converted to data()
  // and then throwaway calc can be made with this code
  var item_id = $(this).attr('item_id');
  debugger;
  var nutritionixUrl = 'https://api.nutritionix.com/v1_1/item';

  $.getJSON(nutritionixUrl, {
    id: item_id,
    appId: "92a57023",
    appKey: "5a11032e7168104fdfa242bd3b62e636"
  }).done(function(result) {
    console.log(result);
  });
};


$(document).ready(function() {

  $('#search').on('click', function (event) {
    event.preventDefault();
    $('#search-results').empty();
    searchFoods();
  });

  $('#query').on('keypress', function(event) {
    if (event.which !== 13) {
      return;
    }
    searchFoods();
  });

  $('#search-results').on('click', 'a', function(event) {
    // event.preventDefault();
    showFood();
  });


});
