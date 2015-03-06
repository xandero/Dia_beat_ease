// JS for single-page food CRUD

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
  var foods = result.hits;

  _(foods).each(function (food) {
    var $link = $('<a>')
      .text(food.field.item_name)
      .attr('data-foodname', food.fields.item_name)
      .attr('data-item_id', food.fields.item_id)
      .addClass('result');

    var $li = $('<li>');
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

  // Makes the search work when enter is pressed. Take that, Bootstrap.
  $('#query').keydown(function(event){
    if(event.keyCode == 13) {
      $('#search-results').empty();
      $(this).blur();
      searchFoods();
      return false;
    }
  });

  $('#search-results').on('click', 'a', function() {
    $(this).addClass('selected');
    $('#form-quantity').focus();
    var item_id = $(this).data('item_id');

    // Get rid of other results (parent here is the <li>, so we don't get left with random bullet points)
    $('#search-results a').not('.selected').parent().remove();

    var nutritionixUrl = 'https://api.nutritionix.com/v1_1/item';

    $.getJSON(nutritionixUrl, {
      id: item_id,
      appId: "92a57023",
      appKey: "5a11032e7168104fdfa242bd3b62e636"
    }).done(function(result) {
      console.log(result);

      $('#form-foodname').val(result.item_name);
      $('#form-serving-size-qty').val(result.nf_serving_size_qty);
      $('#form-serving-size-weight').val(result.nf_serving_weight_grams);
      $('#form-serving-size-unit').val(result.nf_serving_size_unit);
      $('#form-carbs').val(result.nf_total_carbohydrate);
    });
  });

  $('#form-submit').on('click', function (event) {
    event.preventDefault();

    if (($('#form-foodname').val() === "") || ($('#form-quantity').val() <= 0)) {
      // Maybe this should flash an error of some kind?
      return;
    }

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
      var totalCarbCount = 0;

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
        $li.attr('data-food-id', result[i].id)
          .attr('data-meal-id', result[i].meal_id)
          .attr('data-carbs', result[i].carbs)
          .attr('data-quantity', result[i].quantity);

        $('#added-foods').append($li);
      }

      $('#total-carbs').text('Total Carbs: ' + totalCarbCount);

      // Insulin dosage
      var userBolusInsulin = parseInt($('#insulin-required').data('bolus-insulin'));
      var dosage = totalCarbCount / 15 * userBolusInsulin;
      // Math.round magic makes JavaScript play nice and round to 1dp (sans .000000000007 freebie)
      $('#insulin-required').text('Required Insulin Dose: ' + (Math.round( dosage * 10 ) / 10));
    });
  });

  // Empties form fields when a food is added to the meal
  $('#form-submit').on('click', function () {
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

  $('#add-foods-to-meal-button').on('click', function () {
    $('#construct-meal-forms').slideToggle(600);
    $('#construct-meal-forms').toggleClass('hide-meal-construction');
    $(this).remove();
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
      // Updates the maths when a food is removed
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

      $li.remove();
    });
  });

  $('#added-foods').on('click', '.ruby-delete', function () {
    $rubyLi = $(this).parent();
    var rubyMealId = $rubyLi.data('meal-id');
    var rubyFoodId = $rubyLi.data('food-id');
    $.ajax(('/meals/' + rubyMealId + '/foods/' + rubyFoodId), {
      type: 'POST',
      data: {
        _method: 'DELETE'
      }
    }).done(function () {
    // Updates the maths when a food is removed
      var carbs = $rubyLi.data('carbs');
      var quantity = $rubyLi.data('quantity');
      var minusCarbs = carbs * quantity;
      var original = $('#total-carbs').text();
      original = original.split(' ');
      var totalCarbCount = parseInt(original[7]) - Math.round(minusCarbs);

      $('#total-carbs').text('Total Carbs: ' + Math.round(totalCarbCount));

      var userBolusInsulin = parseInt($('#insulin-required').data('bolus-insulin'));
      var dosage = totalCarbCount / 15 * userBolusInsulin;
      $('#insulin-required').text('Required Insulin Dose: ' + (Math.round( dosage * 10 ) / 10));
      $rubyLi.remove();
    });
  });
});
