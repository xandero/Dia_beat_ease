var validateBolus = function() {
  
  var bolus_insulin = parseInt( $('#bolus-value').val() );
  var result = true;
  if ( bolus_insulin < 10 || bolus_insulin > 24 ) {

    var retVal = confirm("Are you sure that's correct? That number is outside the standard range for Bolus Insulin.");
    if( retVal === true ){
      alert("You have confirmed that the Bolus Insulin value you entered is correct.");
    result = true;
    } else {
      alert("Please correct your Bolus value and resubmit.");
    result = false;
    }
  }
  // debugger;
  return result;
};

var validateBasal = function() {
  var basal_insulin = parseInt( $('#basal-value').val() ); 
  var weight = parseInt( $('#user-weight').val() );
  var target_basal = weight * 0.55; 

  var result_basal = false;
  if ( basal_insulin > 1.2 * (target_basal) || basal_insulin < 0.8 * (target_basal)) {

    var retVal = confirm("Are you sure that's correct? That number is outside the standard range for Basal Insulin.");
    if( retVal === true ){
      alert("You have confirmed that the Basal Insulin value you entered is correct.");
      result_basal =  true;
    } else {
      alert("Please correct your Basal value and resubmit.");
      result_basal = false;
    }
  }

  return result_basal;
};

$(document).ready(function() {
  $('form.edit_user').on('submit', function (event) {
    console.log("Why?")
    // debugger;
    var basal = validateBasal();
    var bolus = validateBolus();

    if ( basal !== true || bolus !== true ) {
      event.preventDefault();
    }
  });
  // $('.edit_user').on('submit', validateBasal);
});



















