// RENDER CSV DATA IN HTMLTABLE 
// NOTE: DATA PULLED FROM DATA JSON VIEW
var bloodsugarsCalc = {
        loadBloodsugars: function() {
            $.getJSON('/readingdata').done(function(result){
                // console.log(result)
                bloodsugarsCalc.readings = result;
                bloodsugarsCalc.renderBloodsugars();
            });
        },
        renderBloodsugars: function(){
          $('#bloodsugar-table tr.readings-row').remove();
            for (var i = 0; i < this.readings.length; i++) {
                var reading = bloodsugarsCalc.readings[i];
                bloodsugarsCalc.insertRow(reading);
            }
        },
        insertRow: function(reading) {
            var row = Handlebars.compile($('#bloodsugarTemplate').html());
                        $('#data-table').append(row(reading));
        }
    };

$(document).ready(function() {

  // RENDERS RECORDS FROM DATABASE
  bloodsugarsCalc.loadBloodsugars();
  // DROPZONE UPLOAD ON SUCCESS
  var bloodsugarDropzone;
  if ( $("#bloodsugar-dropzone").length !== 0 ) {
    bloodsugarDropzone = new Dropzone("#bloodsugar-dropzone");
    return bloodsugarDropzone.on("success", function() {
      bloodsugarsCalc.loadBloodsugars();
    });
  }
});


