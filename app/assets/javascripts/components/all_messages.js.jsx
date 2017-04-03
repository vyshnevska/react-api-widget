var AllMessages = React.createClass({

  render: function() {
    var messages = this.props.messages.map((message) => {
      return (
        <div key={message.id}>
          <MessageEntry
            id             = {message.id}
            message        = {message.content}
            publisherName  = 'publisher'
            sentAt         = {message.createdAt}
            status         = {message.status}
            isLong         = {message.content.length > 64 ? true : false}
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
