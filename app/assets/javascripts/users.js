var validateBolus = function() {
  console.log('inside function');
  var bolus_insulin = $('#bolus-value').val();
  if ( bolus_insulin < 10 || bolus_insulin > 30 ) {

    var retVal = confirm("Are you sure that's correct? That number is outside the standard range for Bolus Insulin.");
    if( retVal == true ){
      alert("You have confirmed that the Bolus value you entered is correct.");
    return true;
    } else {
      alert("Please check your Bolus value and resubmit.");
    return false;
    }
  }
};

$(document).ready(function() {
  $('#profile-submit').on('click', validateBolus);
  console.log('hello');

});


