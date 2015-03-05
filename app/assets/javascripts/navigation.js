  $(document).ready(function() {
    // debugger;
     $(".side-nav").on("click", "li", function(event){
      event.preventDefault();
     $(this).find(".active").removeClass("active");
     $(this).parent().addClass("active");
    });
  });