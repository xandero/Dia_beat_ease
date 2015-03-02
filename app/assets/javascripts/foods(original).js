// // brings back a JSON object with the specified number of results (based on the user's search query, e.g. banana)
// var searchFoods = function () {
//   var query = $('#query').val();
//   var nutritionixUrl = 'https://api.nutritionix.com/v1_1/search/' + query;

//   $.getJSON(nutritionixUrl, {
//     appId: "92a57023",
//     appKey: "5a11032e7168104fdfa242bd3b62e636",
//     results: "0:2"
//   }).done(listResults);
// };

// var listResults = function (result) {
//   var foods = result.hits

//   _(foods).each(function (food) {
//     var $link = $('<a>').text(food.fields.item_name);

//     // need to get these data attributes working (codescool jQuery stuff)
//     // might be because they are not being selected from the dom
//     // currently not secure as attrs but still working (change later)
//     $link.attr('foodname', food.fields.item_name);
//     $link.attr('item_id', food.fields.item_id);
//     $link.addClass('result');
//     var $li = $('<li>');
//     $li.addClass('li');
//     $li.append($link);
//     $('#search-results').append($li);
//   });
// };

// // var showFood = function (event) {
// //   // should use .data() instead of assigning random attrs
// //   var item_id = $(this).attr('item_id');
// //   var nutritionixUrl = 'https://api.nutritionix.com/v1_1/item';

// //   $.getJSON(nutritionixUrl, {
// //     id: item_id,
// //     appId: "92a57023",
// //     appKey: "5a11032e7168104fdfa242bd3b62e636"
// //   }).done(function(result) {
// //     // should the relevant data be listed with the food?
// //     // debugger;
// //     $('#form-serving-size-qty').val(result.nf_serving_size_qty);
// //     $('#form-serving-size-weight').val(result.nf_serving_size_weight);
// //     $('#form-serving-size-unit').val(result.nf_serving_size_unit);
// //     $('#form-carbs').val(result.nf_total_carbohydrate);
// //   });
// // };

// $(document).ready(function() {

//   $('#search').on('click', function (event) {
//     event.preventDefault();
//     $('#search-results').empty();
//     searchFoods();
//   });

//   $('#query').on('keypress', function(event) {
//     if (event.which !== 13) {
//       return;
//     }
//     $('#search-results').empty();
//     searchFoods();
//   });

//   $('#search-results').on('click', 'a', function() {
//     // populates form
//     // showFood();

//     $('#form-foodname').val($(this).attr('foodname'));
//     $('#quantity-div').empty();
//     $(this).addClass('selected');
//     var item_id = $(this).attr('item_id');
//     var item_name = $(this).attr('item_name');

//     // get rid of other results
//     var searchResults = $('#search-results a');

//     _(searchResults).each(function (result) {
//       if (result.classList.contains('selected') === false) {
//         // delete it!
//         result.parentNode.remove();
//       }
//     });

//     var nutritionixUrl = 'https://api.nutritionix.com/v1_1/item';

//     $.getJSON(nutritionixUrl, {
//       id: item_id,
//       appId: "92a57023",
//       appKey: "5a11032e7168104fdfa242bd3b62e636"
//     }).done(function(result) {
//       console.log(result);

//       $('#form-serving-size-qty').val(result.nf_serving_size_qty);
//       $('#form-serving-size-weight').val(result.nf_serving_weight_grams);
//       $('#form-serving-size-unit').val(result.nf_serving_size_unit);
//       $('#form-carbs').val(result.nf_total_carbohydrate);
//     });

//     var $quantityInput = $('<input id="quantity" placeholder="Quantity">');
//     var $addToMeal = $('<button id="add-to-meal">Add to meal</button>');

//     $('#quantity-div').append($quantityInput);
//     $('#quantity-div').append($addToMeal);
//   });

//   $('#quantity-div').on('click', 'button', function() {

//     $('#form-quantity').val($('#quantity').val());

//     var $li = $('<li>');
//     var qty = $('#quantity').val();
//     var $badge = $('<span class="badge"></span>');
//     $badge.text(qty);

//     $li.text($('.selected').attr('foodname') + ' ');
//     $li.append($badge);

//     $('#foods-added').append($li);
//     $('#search-results').empty();
//     $('#quantity-div').empty();
//   });
// });