var AjaxCustomMethods = {

  // Relies on error response from API being JSON object like:
  // { errors: [ "Error message", "Another error message" ] }
  handleError: function(error){
    var errorsObj = $.parseJSON(error.responseText)
    var errorMessages = errorsObj.errors;
    alert("There was an error: " + errorMessages);
  },

  // meta tag in <head> holds auth token
  // <meta name="auth-token" content="TOKEN GOES HERE">
  getAuthToken: function() {
    var authToken = $("meta[name=auth-token]").attr("content");
    return authToken;
  }
};