var MessageFeed = React.createClass({
  getInitialState() {
    return { messages: [] }
  },
  componentDidMount() {
    $.getJSON('/api/v1/items.json', (response) => { this.setState({ items: response }) });

  },

  render: function() {
    return (
      <ul className='collapse-body'>
        {this.props.messages.map(function(message){
          return (
            <MessageEntry
              id             = {message.data.id}
              message        = 'Welcome to Messanger!'
              channel_slug   = 'MK'
              publisher_name = 'publisher'
              sent_date      = {message.data.sent_date}
            />
          )
        }, this)}
      </ul>
    )
  }
});

