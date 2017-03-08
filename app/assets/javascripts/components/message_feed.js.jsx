var MessageFeed = React.createClass({
  // ---- main methods
  getInitialState() {
    return { messages: [] }
  },

  showMessages(data){
    this.setState({ messages: data });
  },

  componentDidMount() {
    var ajaxOptions = {
      url: '/api/v1/messages.json',
      type: 'GET',
      dataType: 'json',
      headers: { "Authorization": "Token token=" + AjaxCustomMethods.getAuthToken() },
      contentType: "application/json; charset=utf-8"
    };

    // Initiate the AJAX request to messages#index
    $.ajax(ajaxOptions).done(this.showMessages).fail(AjaxCustomMethods.handleError);
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