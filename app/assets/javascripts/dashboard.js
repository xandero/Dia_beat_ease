var data = {
    labels: [],
    datasets: [
        {
            label: "My First dataset",
            fillColor: "rgba(220,220,220,0.5)",
            strokeColor: "rgba(220,220,220,0.8)",
            highlightFill: "rgba(220,220,220,0.75)",
            highlightStroke: "rgba(220,220,220,1)",
            data: []
        }
    ]
};

$(document).ready(function() {
    // if this chart doesn't exist then don't run the rest of the code in doc ready, just return and 'break'
    var $chart = $('#myChart');
    if ($chart.length === 0) {
        return;
    }
              // this refers to the canvas (which is returned in an array when targeted)
    var ctx = $chart.get(0).getContext('2d');

    var bslevelRequest = $.getJSON('/readingdata/bslevel').done(function (bslevels) {
        data.datasets[0].data = bslevels;
    });

    var readingtimeRequest = $.getJSON('/readingdata/readingtime').done(function (readingtimes) {
        data.labels = readingtimes;
    });

    // the above two requests return promises
    // when the two requests are done then draw the chart
    $.when(readingtimeRequest, bslevelRequest).then(function() {
        var myLineChart = new Chart(ctx).Line(data);
    })

});


