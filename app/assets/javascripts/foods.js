// new food AJAX stuff
console.log('hi')


var searchFoods = function () {
  var query = $('#query').val();
  var nutritionixUrl = 'https://api.nutritionix.com/v1_1/search/' + query;

  var jsonObject = $.getJSON(nutritionixUrl, {
    appId: "92a57023",
    appKey: "5a11032e7168104fdfa242bd3b62e636",
    results: "0:2"
  });
};




// def search_foods
//     url = "https://api.nutritionix.com/v1_1/search/#{ params[:name] }?results=0:5&fields=item_name,brand_name,item_id,brand_id,nf_serving_size_qty,nf_serving_size_unit&appId=92a57023&appKey=5a11032e7168104fdfa242bd3b62e636"
//     raw_data = HTTParty.get url
//     parsed_data = JSON.parse(raw_data.body)
//     @food_data = parsed_data['hits']
//     @meal = params[:meal_id]
//   end


// var searchFlickr = function () {
//   // $('#images').empty();
//   $('#page-num').css("visibility", "visible");
//   var query = $('#query').val();
//   scrollCounter++;
//   var flickrUrl = 'https://api.flickr.com/services/rest/?jsoncallback=?';

//   $.getJSON(flickrUrl, {
//     method: 'flickr.photos.search',
//     api_key: '2f5ac274ecfac5a455f38745704ad084',
//     text: query,
//     format: 'json',
//     per_page: 100,
//     page: (scrollCounter)

//   }).done(processImages);
// };


$(document).ready(function() {

  $('#search').on('click', function (event) {
    event.preventDefault();
    searchFoods();
  });

});
