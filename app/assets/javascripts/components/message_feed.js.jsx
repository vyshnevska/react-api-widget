var MessageFeed = React.createClass({
  // ---- main methods

  getInitialState() {
    return { messages: [], channelsSelectOptions: [] }
  },

  populateData(data){
    this.setState({ messages: data.messages, channelsSelectOptions: data.channels });
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
    $.ajax(ajaxOptions).done(this.populateData).fail(AjaxCustomMethods.handleError);
  },

  handleSubmit(data) {
    message = data.messages[0];
    this.state.messages.unshift(message); // adds a new message at the biginning
    this.setState({ messages: this.state.messages });
    console.log('message was sent succesfully!', message);
  },

  render: function() {
    // <AllMessages messages={this.state.messages}/>
    return (
      <div className='body'>
        <NewMessage sendNewMessageHandler={this.handleSubmit} channelsSelectOptions={this.state.channelsSelectOptions}/>
      </div>
    )
  }
});
MessageFeed.propTypes = {
  messages: React.PropTypes.array,
  channelsSelectOptions: React.PropTypes.array
};