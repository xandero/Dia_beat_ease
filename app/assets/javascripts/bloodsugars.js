// DROPZONE UPLOAD CODE
$(document).ready(function(){
    $(function() {
      var bloodsugarDropzone;
      bloodsugarDropzone = new Dropzone("#bloodsugar-dropzone");
      return bloodsugarDropzone.on("success", function(file, responseText) {
        var imageUrl;
        imageUrl = responseText.file_name.url;
      });
    });
});

