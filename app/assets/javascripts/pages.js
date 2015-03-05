// JS for the single dosage calculator

var searchSingleFoods = function () {
  var query = $('#single-calc').val();
  var nutritionixUrl = 'https://api.nutritionix.com/v1_1/search/' + query;

  $.getJSON(nutritionixUrl, {
    appId: "92a57023",
    appKey: "5a11032e7168104fdfa242bd3b62e636",
    results: "0:10"
  }).done(listResults);
};

var listResults = function (result) {
  var foods = result.hits;

  _(foods).each(function (food) {
    var $link = $('<a>').text(food.fields.item_name)
      .attr('data-foodname', food.fields.item_name)
      .attr('data-item_id', food.fields.item_id)
      .addClass('result');

    var $li = $('<li>');
    $li.append($link);
    $('#search-results').append($li);
  });
};

$(document).ready(function() {
  $('#single-calc').focus();

  $('#calculate').on('click', function (event) {
    event.preventDefault();
    $('#search-results').empty();
    searchSingleFoods();
  });

  // Makes the search work when enter is pressed. Take that, Bootstrap.
  $('#single-calc').keydown(function(event){
    if(event.keyCode == 13) {
      $('#search-results').empty();
      $(this).blur();
      searchSingleFoods();
      return false;
    }
  });

  $('#search-results').on('click', 'a', function() {
    $(this).addClass('selected');
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

      $('#calc-foodname').val(result.item_name);
      $('#calc-serving-size-qty').val(result.nf_serving_size_qty);
      $('#calc-serving-size-weight').val(result.nf_serving_weight_grams);
      $('#calc-serving-size-unit').val(result.nf_serving_size_unit);
      $('#calc-carbs').val(result.nf_total_carbohydrate);
      $('#calc-quantity').focus();
    });
  });

  $('#calc-it').on('click', function (event) {
    event.preventDefault();
    var userBolusInsulin = parseInt($('#calc-bolus').val());
    var carbCount = parseInt($('#calc-carbs').val()) * parseFloat($('#calc-quantity').val());
    var singleDosage = carbCount / 15 * userBolusInsulin;
    $('#single-calc-dosage').text('Insulin Dosage: ' + (Math.round( singleDosage * 10 ) / 10));
    $('#single-calc-dosage').css('background-color', '#5CB85C');
    $('#search-results').empty();
    $('#single-calc').val('').focus();
  });

});
