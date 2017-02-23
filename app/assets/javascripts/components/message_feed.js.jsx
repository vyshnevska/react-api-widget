var MessageFeed = React.createClass({
  getInitialState() {
    return { messages: [] }
  },

  componentDidMount() {
    $.getJSON('/api/v1/messages.json', (response) => {
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