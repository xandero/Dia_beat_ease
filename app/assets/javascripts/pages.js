// JS for the throwaway calc

var searchSingleFoods = function () {
  var query = $('#single-calc').val();
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

// currently fucking up because it's not getting the value from the form input


$(document).ready(function() {
  $('#calculate').on('click', function (event) {
    event.preventDefault();
    $('#search-results').empty();
    searchSingleFoods();
  });

  $('#single-calc').keydown(function(event){
    if(event.keyCode == 13) {
      // event.preventDefault();
      $('#search-results').empty();
      $(this).blur();
      searchSingleFoods();
      return false;
    }
  });

  $('#search-results').on('click', 'a', function() {
    // $('#calc-foodname').val($(this).data('foodname'));
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

      $('#calc-foodname').val(result.item_name);
      $('#calc-serving-size-qty').val(result.nf_serving_size_qty);
      $('#calc-serving-size-weight').val(result.nf_serving_weight_grams);
      $('#calc-serving-size-unit').val(result.nf_serving_size_unit);
      $('#calc-carbs').val(result.nf_total_carbohydrate);
    }).done(function () {
      var userBolusInsulin = parseInt($('#single-calc-dosage').data('bolus-insulin'));
      var carbCount = parseInt($('#calc-carbs').val());
      var singleDosage = carbCount / 15 * userBolusInsulin;
      $('#single-calc-dosage').text('Insulin Dosage: ' + (Math.round( singleDosage * 10 ) / 10));
    });
  });
});
