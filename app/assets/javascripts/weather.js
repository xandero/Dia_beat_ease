// var data = {
//     labels: ["January", "February", "March", "April", "May", "June", "July"],
//     datasets: [
//         {
//             label: "My First dataset",
//             fillColor: "rgba(220,220,220,0.5)",
//             strokeColor: "rgba(220,220,220,0.8)",
//             highlightFill: "rgba(220,220,220,0.75)",
//             highlightStroke: "rgba(220,220,220,1)",
//             data: [65, 59, 80, 81, 56, 55, 40]
//         },
//         {
//             label: "My Second dataset",
//             fillColor: "rgba(151,187,205,0.5)",
//             strokeColor: "rgba(151,187,205,0.8)",
//             highlightFill: "rgba(151,187,205,0.75)",
//             highlightStroke: "rgba(151,187,205,1)",
//             data: [28, 48, 40, 19, 86, 27, 90]
//         }
//     ]
// };

// $(document).ready(function(){
//     var $chart = $('#weather');
//     if ($chart.length=== 0) {
//         return;
//     }
//     var ctx = $chart.get(0).getContext('2d');
    
//     var maxRequest$.getJSON('/temperatures/max').done(function(maximums){
//         data.datasets[0].data = maximums
//     })

//     var minRequest$.getJSON('/temperatures/max').done(function(maximums){
//         data.datasets[0].data = maximums
//     })

//     $.when(maxRequest, minRequest).then(function() {
//         var myLineChart = new Chart(ctx).Line(data);
//     });
// })







