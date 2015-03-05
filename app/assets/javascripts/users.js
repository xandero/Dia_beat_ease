var validateBolus = function() {
  console.log('validating bolus');
  var bolus_insulin = parseInt($('#bolus-value').val());
  if ( bolus_insulin < 10 || bolus_insulin > 24 ) {

    var retVal = confirm("Are you sure that's correct? That number is outside the standard range for Bolus Insulin.");
    if( retVal === true ){
      alert("You have confirmed that the Bolus Insulin value you entered is correct.");
    return true;
    } else {
      alert("Please correct your Bolus value and resubmit.");
    return false;
    }
  }
};

var validateBasal = function() {
  console.log('validating basal');
  var basal_insulin = parseInt($('#basal-value').val());
  var weight = parseInt($('#user-weight').val());
  var target_basal = weight * 0.55;

  if ( basal_insulin > 1.2 * (target_basal) || basal_insulin < 0.8 * (target_basal)) {

    var retVal = confirm("Are you sure that's correct? That number is outside the standard range for Basal Insulin.");
    if( retVal === true ){
      alert("You have confirmed that the Basal Insulin value you entered is correct.");
    return true;
    } else {
      alert("Please correct your Basal value and resubmit.");
    return false;
    }
  }
};

$(document).ready(function() {
  $('#profile-submit').on('click', validateBolus);
  $('#profile-submit').on('click', validateBasal);
});


