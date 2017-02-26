var MessageFeed = React.createClass({
  getInitialState() {
    return { messages: [] }
  },

  componentDidMount() {
    $.getJSON('/api/v1/messages.json/?token=20a1621f19c20056bf0f3087ce9d6970', (response) => {
      this.setState({ messages: response })
    });
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