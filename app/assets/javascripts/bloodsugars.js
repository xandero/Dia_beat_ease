// DROPZONE UPLOAD CODE

$(function() {
  var bloodsugarDropzone;
  bloodsugarDropzone = new Dropzone("#bloodsugar-dropzone");
  return bloodsugarDropzone.on("success", function(file, responseText) {
    var imageUrl;
    imageUrl = responseText.file_name.url;
  });
});

  $(document).ready(function() {
    // console.log('');
  });
