// DROPZONE UPLOAD CODE
$(document).ready(function(){

    var bloodsugarsCalc = {
        console.log('test')
    //     loadBloodsugars: function() {
    //         $.getJSON(readingUrl).done(function(result){
    //             console.log(result)
    //             // bloodsugarsCalc.readings = result;
    //             // bloodsugarsCalc.renderBloodsugars();
    //         });
    //     }

    // //     renderBloodsugars: function(){
    // //         for (var i = 0; i < this.readings.length; i++) {
    // //             var reading = this.readings[i]
    // //             var row = this.bloodsugarHTML(reading);

    // //         };

    }

    // bloodsugarsCalc.bloodsugarHTML = Handlebars.compile($('#bloodsugarTemplate').html())
    $(function() {
      var bloodsugarDropzone;
      bloodsugarDropzone = new Dropzone("#bloodsugar-dropzone");
      return bloodsugarDropzone.on("success", function(file, responseText) {
        var readingUrl;
        readingUrl = responseText.file_name.url;
        bloodsugarCalc.loadTasks
      });
    });
})
