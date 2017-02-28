AjaxRequestHandler = {

  handleError(error){
    // Relies on error response from API being JSON object like:
    // { errors: [ "Error message", "Another error message" ] }
    var errorsObj = $.parseJSON(error.responseText)
    var errorMessages = errorsObj.errors;
    alert("There was an error: " + errorMessages);
  }
}
