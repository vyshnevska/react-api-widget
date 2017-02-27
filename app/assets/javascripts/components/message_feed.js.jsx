var MessageFeed = React.createClass({
  // ---- ajax methods
  showMessages(data){
    this.setState({ messages: data })
  },

  handleError(error){
    // Relies on error response from API being JSON object like:
    // { errors: [ "Error message", "Another error message" ] }
    var errorsObj = $.parseJSON(error.responseText)
    var errorMessages = errorsObj.errors;
    alert("There was an error: " + errorMessages);
  },

  getAuthToken() {
    // meta tag in <head> holds auth token
    // <meta name="auth-token" content="TOKEN GOES HERE">
    var authToken = $("meta[name=auth-token]").attr("content");
    return authToken;
  },
  // ---- ajax methods


  // ---- main methods
  getInitialState() {
    return { messages: [] }
  },

  componentDidMount() {
    var ajaxOptions = {
      url: '/api/v1/messages.json',
      type: 'GET',
      dataType: 'json',
      headers: { "Authorization": "Token token=" + this.getAuthToken() },
      contentType: "application/json; charset=utf-8"
    };

    // Initiate the AJAX request to messages#index
    $.ajax(ajaxOptions).done(this.showMessages).fail(this.handleError);
  },

  handleSubmit(message) {
    var newState = this.state.messages.concat(message);
    this.setState({ messages: newState })
  },

  render: function() {
    return (
      <div className='body'>
        <NewMessage handleSubmit={this.handleSubmit}/>
        <AllMessages messages={this.state.messages}/>
      </div>
    )
  }
});