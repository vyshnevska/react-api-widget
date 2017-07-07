var MessageFeed = React.createClass({
  // ---- main methods
  getInitialState() {
    return {
      own_messages: [],
      my_feed: []
    }
  },

  // populateData(data){
  //   this.setState({
  //     own_messages: data.my_messages,
  //     my_feed:      data.messages_to_me,
  //     hasChannel:  data.channel != undefined,
  //     channelsSelectOptions: data.channel
  //   });
  // },

  // componentDidMount() {
  //   var ajaxOptions = {
  //     url:         'api/v1/messages.json',
  //     type:        'GET',
  //     dataType:    'json',
  //     headers:     {"Authorization": "Token token=" + AjaxCustomMethods.getAuthToken()},
  //     contentType: "application/json; charset=utf-8"
  //   };

  //   // Initiate the AJAX request to messages#index
  //   $.ajax(ajaxOptions).done(this.populateData).fail(AjaxCustomMethods.handleError);
  // },

  handleSubmit(message) {
    this.state.own_messages.unshift(message); // adds a new message at the biginning
    this.setState({ own_messages: this.state.own_messages });
    console.log('message was sent succesfully!', message);
  },

  render: function() {
    if(this.props.isAuthorized){
      return(
        <div className='body'>
          {this.props.hasChannel &&
            <NewMessage
              sendNewMessageHandler={this.handleSubmit}
              channelsSelectOptions={[this.props.channelsSelectOptions]}
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
  channelsSelectOptions: React.PropTypes.object,
  hasChannel: React.PropTypes.bool
};