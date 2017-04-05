var AllMessages = React.createClass({

  render: function() {
    var own_messages = this.props.own_messages.map((message) => {
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

    var my_feed = this.props.my_feed.map((message) => {
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


    if (this.props.own_messages.length > 0){
      return(
        <ul className='collapse-body'>
          {own_messages}
          <a className='section-separator'> </a>
          {my_feed}
        </ul>
      )
    } else {
      return null;
    }
  }
});
