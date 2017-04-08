var MessageFeed = React.createClass({
  // ---- main methods

  getInitialState() {
    return {
      own_messages: [],
      my_feed: [],
      channelsSelectOptions: [],
      isAuthorized: this.props.isAuthorized,
      has_channel: false
    }
  },

  populateData(data){
    this.setState({
      own_messages: data.messages.from_me,
      my_feed:      data.messages.to_me,
      has_channel:  data.channels.length > 0,
      channelsSelectOptions: data.channels
    });
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
    $.ajax(ajaxOptions).done(this.populateData).fail(AjaxCustomMethods.handleError);
  },

  handleSubmit(message) {
    this.state.own_messages.unshift(message); // adds a new message at the biginning
    this.setState({ own_messages: this.state.own_messages });
    console.log('message was sent succesfully!', message);
  },

  render: function() {
    if(this.state.isAuthorized){
      return(
        <div className='body'>
          {this.state.has_channel &&
            <NewMessage
              sendNewMessageHandler={this.handleSubmit}
              channelsSelectOptions={this.state.channelsSelectOptions}
            />}
          <a className='section-separator'> </a>
          { <AvailableChannels />}
          <a className='section-separator'> </a>
          <AllMessages
            own_messages = {this.state.own_messages}
            my_feed      = {this.state.my_feed} />
        </div>)
    } else {
      return(
        <div className='unauthorized'>
          <h5>You are not authorized </h5>
        </div>)
    }
  }
});
MessageFeed.propTypes = {
  own_messages: React.PropTypes.array,
  my_feed: React.PropTypes.array,
  channelsSelectOptions: React.PropTypes.array,
  has_channel: React.PropTypes.bool
};