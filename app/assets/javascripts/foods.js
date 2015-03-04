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
    $('#form-quantity').focus();
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
        // doesn't seem to work if I change it here either...
        carbs: $('#form-carbs').val(),
        meal_id: mealId
      }
    }).done(function (result) {
      var totalCarbCount = 0;
      // need to sum up the carb values of each


      $('#added-foods').empty();
      for (var i = 0; i < result.length; i++) {
        var $li = $('<li>');
        var mealId = result[i].meal_id;
        var foodId = result[i].id;
        $li.text(result[i].foodname);

        totalCarbCount = totalCarbCount + Math.round(result[i].carbs * result[i].quantity);
        $('#total-carbs').val('Total Carbs: ' + (totalCarbCount));

        $li.prepend($('<span class="badge food-badge">Carbs: ' + Math.round(result[i].quantity * result[i].carbs) + '</span> '));
        $li.prepend($('<span class="badge food-badge">Qty: ' + result[i].quantity + '</span> '));
        $li.append($(' <span class="glyphicon glyphicon-trash delete">'));
        $li.attr('data-food-id', result[i].id);
        $li.attr('data-meal-id', result[i].meal_id);
        $li.attr('data-carbs', result[i].carbs);
        $li.attr('data-quantity', result[i].quantity);

        $('#added-foods').append($li);
        console.log(result[i].foodname);
      }

      $('#total-carbs').text('Total Carbs: ' + totalCarbCount);

      // calculates and displays required insulin dosage
      // maybe add in the unit?
      var userBolusInsulin = parseInt($('#insulin-required').data('bolus-insulin'));
      var dosage = totalCarbCount / 15 * userBolusInsulin;
      // Math.round magic makes JavaScript play nice and round to 1dp (sans .000000000007 freebie)
      $('#insulin-required').text('Required Insulin Dose: ' + (Math.round( dosage * 10 ) / 10));

    });

  });

  // empties everything when the food is added to the meal
  $('#form-submit').on('click', function () {
    // $('#added-foods').empty();
    $('#query').focus();
    $('#search-results').empty();
    $('#query').val('');
    $('#form-foodname').val('');
    $('#form-quantity').val('');
    $('#form-serving-size-qty').val('');
    $('#form-serving-size-unit').val('');
    $('#form-serving-size-weight').val('');
    $('#form-carbs').val('');
  });

  $('#complete-meal-button').on('click', function () {
    console.log('clicked');
    $('#construct-meal-forms').slideToggle(600);
    $('#construct-meal-forms').toggleClass('hide-meal-construction');
    $(this).blur();
    if ($('#construct-meal-forms').hasClass('hide-meal-construction')) {
      $(this).text('Add foods to meal');
    } else {
      $(this).text('Complete meal');
    }
  });

  $('#added-foods').on('click', '.delete', function () {
    var $li = $(this).parent();
    var mealId = $li.data('meal-id');
    var foodId = $li.data('food-id');
    $.ajax(('/meals/' + mealId + '/foods/' + foodId), {
      type: 'POST',
      data: {
        _method: 'DELETE'
      }
    }).done(function () {
      // does the maths with for total carbs
      var carbs = $li.data('carbs');
      var quantity = $li.data('quantity');
      var minusCarbs = carbs * quantity;
      var original = $('#total-carbs').text();
      original = original.split(' ');
      var totalCarbCount = parseInt(_.last(original)) - minusCarbs;
      $('#total-carbs').text('Total Carbs: ' + Math.round(totalCarbCount));

      var userBolusInsulin = parseInt($('#insulin-required').data('bolus-insulin'));
      var dosage = totalCarbCount / 15 * userBolusInsulin;
      $('#insulin-required').text('Required Insulin Dose: ' + (Math.round( dosage * 10 ) / 10));

      // total carbs /15 * bolus

      // removes the DOM element
      $li.remove();
    });

  });
});
