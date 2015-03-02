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

  $('#search').on('click', function (event) {
    event.preventDefault();
    $('#search-results').empty();
    searchFoods();
  });

  // makes the search work when enter is pressed. Take that, bootstrap.
  $('#query').keydown(function(event){
    if(event.keyCode == 13) {
      // event.preventDefault();
      $('#search-results').empty();
      $(this).blur();
      searchFoods();
      return false;
    }
  });

  $('#search-results').on('click', 'a', function() {
    $('#form-foodname').val($(this).data('foodname'));
    $(this).addClass('selected');
    var item_id = $(this).data('item_id');

    // get rid of other results
    var searchResults = $('#search-results a');

    _(searchResults).each(function (result) {
      if (result.classList.contains('selected') === false) {
        // delete it!
        result.parentNode.remove();
      }
    });

    var nutritionixUrl = 'https://api.nutritionix.com/v1_1/item';

    $.getJSON(nutritionixUrl, {
      id: item_id,
      appId: "92a57023",
      appKey: "5a11032e7168104fdfa242bd3b62e636"
    }).done(function(result) {
      console.log(result);

      $('#form-serving-size-qty').val(result.nf_serving_size_qty);
      $('#form-serving-size-weight').val(result.nf_serving_weight_grams);
      $('#form-serving-size-unit').val(result.nf_serving_size_unit);
      $('#form-carbs').val(result.nf_total_carbohydrate);
    });
  });

  $('#form-submit').on('click', function (event) {
    event.preventDefault();
    var mealId = $('#form-meal-id').val();

    $.post('/meals/' + mealId + '/foods', {
      food: {
        foodname: $('#form-foodname').val(),
        quantity: $('#form-quantity').val(),
        serving_size_qty: $('#form-serving-size-qty').val(),
        serving_size_unit: $('#form-serving-size-unit').val(),
        serving_size_weight: $('#form-serving-size-weight').val(),
        carbs: $('#form-carbs').val(),
        meal_id: mealId
      }
    }).done(function (result) {

      // result is the returned array of food objects
      // need to append them to the list of 'added foods'
      for (var i = 0; i < result.length; i++) {
        console.log(result[i].foodname);
      }
    });

  });

  // empties everything when the food is added to the meal
  $('#form-submit').on('click', function () {
    $('#search-results').empty();
    $('#query').val('');
    $('#form-foodname').val('');
    $('#form-quantity').val('');
    $('#form-serving-size-qty').val('');
    $('#form-serving-size-unit').val('');
    $('#form-serving-size-weight').val('');
    $('#form-carbs').val('');
  });

  $('#complete-meal').on('click', function () {
    $('#construct-meal-forms').toggleClass('hide-meal-construction');

    if ($('#construct-meal-forms').hasClass('hide-meal-construction')) {
      $(this).text('Add foods to meal');
    } else {
      $(this).text('Complete meal');
    }
  });

  // $('#form-submit').on('click', function () {
  //   $.getJSON('/foods').done(function () {
  //     taskApp.tasks = result;
  //     taskApp.renderTasks();
  //   });
  // }
  // });

});
