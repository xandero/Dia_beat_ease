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
    $link.attr('foodname', food.fields.item_name);
    $link.attr('item_id', food.fields.item_id);
    $link.addClass('result');
    var $li = $('<li>');
    $li.append($link);
    $('#search-results').append($li);
  });
};

var showFood = function (event) {
  // 'this' is empty, not getting the right thing
  // when this is done, attrs can be converted to data()
  // and then throwaway calc can be made with this code
  var item_id = $(this).attr('item_id');
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
    // 'this' only works inside the event handler
    // if I try to put it in a separate function, 'this' no longer refers to the element the user has clicked on. wtf.
    $(this).addClass('selected');
    var item_id = $(this).attr('item_id');
    var nutritionixUrl = 'https://api.nutritionix.com/v1_1/item';

    $.getJSON(nutritionixUrl, {
      id: item_id,
      appId: "92a57023",
      appKey: "5a11032e7168104fdfa242bd3b62e636"
    }).done(function(result) {
      console.log(result);

      console.log(result.item_name);
      console.log(result.nf_serving_size_qty);
      console.log(result.nf_serving_weight_grams);

      // need to then prompt the user to enter the quantity
      // maybe add an input with a placeholder of qty when they click the link
      // have a nested event handler so when they press enter on that it adds it all to the meal (maybe have an add button instead of enter, feedback that the user is actually adding something to their meal)
    });

    var $quantityInput = $('<input id="quantity" placeholder="Quantity">');
    var $addToMeal = $('<button id="add-to-meal">Add to meal</button>');
    $('#quantity-div').append($quantityInput);
    $('#quantity-div').append($addToMeal);
  });

  $('#quantity-div').on('click', 'button', function() {
    console.log('clicked');
    var $li = $('<li>');
    $li.text($('.selected').attr('foodname'));
    $('#foods-added').append($li);
    $('#search-results').empty();
    $('#quantity-div').empty();
  });


});
