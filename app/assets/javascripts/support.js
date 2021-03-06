var AjaxCustomMethods = {
  // Relies on error response from API being JSON object like:
  // { errors: [ "Error message", "Another error message" ] }
  handleError: function(error) {
    console.log("There was an error: " + error.statusText);
  },

  // meta tag in <head> holds auth token
  // <meta name="auth-token" content="TOKEN GOES HERE">
  getAuthToken: function() {
    var authToken = $("meta[name=auth-token]").attr("content");
    return authToken;
  },

  isAuthorized: function() {
    if(this.getAuthToken().length > 0){
      return true
    } else {
      return false
    }
  }
};

var CustomMethods = {
  truncate: function(text, size) {
    size = (typeof size !== 'undefined') ?  size : 20;
    if(text.length > size){
      return text.substring(0, parseInt(size)) + '...';
    } else {
      return text;
    }
  }
};

Array.prototype.eachSlice = function (size){
  this.arr = []
  for (var i = 0, l = this.length; i < l; i += size){
    this.arr.push(this.slice(i, i + size))
  }
  return this.arr
};