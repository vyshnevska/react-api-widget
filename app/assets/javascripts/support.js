var AjaxCustomMethods = {

  // Relies on error response from API being JSON object like:
  // { errors: [ "Error message", "Another error message" ] }
  handleError: function(error){
    console.log("There was an error: " + error.statusText);
  },

  // meta tag in <head> holds auth token
  // <meta name="auth-token" content="TOKEN GOES HERE">
  getAuthToken: function() {
    var authToken = $("meta[name=auth-token]").attr("content");
    return authToken;
  }
};