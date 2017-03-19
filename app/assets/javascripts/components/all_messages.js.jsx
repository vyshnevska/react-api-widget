var AllMessages = React.createClass({

  render: function() {
    var messages = this.props.messages.map((message) => {
      return (
        <div key={message.id}>
          <MessageEntry
            id             = {message.id}
            message        = {message.content}
            channel_slug   = 'MK'
            publisher_name = 'publisher'
            sent_date      = {message.created_at}
            status         = {message.status}
          />
        </div>
      )
    });

    return(
      <ul className='collapse-body'>
        {messages}
      </ul>
    )
  }
});
