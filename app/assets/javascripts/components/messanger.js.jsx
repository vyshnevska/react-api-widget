var Messanger = React.createClass({
  getInitialState() {
    return {
      myMessagesCount: 0,
      currentUser: null,
      isAuthorized: AjaxCustomMethods.isAuthorized(),
    }
  },

  componentDidMount() {
    var ajaxOptions = {
      url:         'api/v1/messages.json',
      type:        'GET',
      dataType:    'json',
      headers:     {"Authorization": "Token token=" + AjaxCustomMethods.getAuthToken()},
      contentType: "application/json; charset=utf-8"
    };

    // Initiate the AJAX request to messages#index
    $.ajax(ajaxOptions)
      .done(this.assignAttrs)
      .fail(AjaxCustomMethods.handleError);
  },

  assignAttrs(response){
    this.setState({
      currentUser:  response.currentUser,
      myMessages:   response.myMessages,
      messagesToMe: response.messagesToMe,
      has_channel:  response.channel != undefined,
      myMessagesCount:       response.myMessagesCount,
      subscriptionsCount:    response.subscriptionsCount,
      channelsSelectOptions: response.channel
    });
  },

  render: function() {
    return (
      <div className="messages_box collapse-container" id="messages_container">
        <div className="collapse-group">
          <Header
            myMessagesCount = {this.state.myMessagesCount}
            isAuthorized    = {this.state.isAuthorized}
            currentUser     = {this.state.currentUser}
            subscriptionsCount = {this.state.subscriptionsCount}
             />
          <MessageFeed isAuthorized = {this.state.isAuthorized} />
        </div>
      </div>
    )
  }
});
