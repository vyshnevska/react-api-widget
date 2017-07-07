var AllMessages = React.createClass({

  render: function() {
    var myMessages = this.props.myMessages.map((message) => {
      return (
        <div key={message.id}>
          <MessageEntry
            id             = {message.id}
            message        = {message.content}
            publisherName  = 'publisher'
            sentAt         = {message.created_at}
            status         = {message.status}
            isLong         = {message.content.length > 64 ? true : false}
          />
        </div>
      )
    });

    var messagesToMe = this.props.messagesToMe.map((message) => {
      return (
        <div key={message.id}>
          <MessageEntry
            id             = {message.id}
            message        = {message.content}
            publisherName  = 'publisher'
            sentAt         = {message.created_at}
            status         = {message.status}
            isLong         = {message.content.length > 64 ? true : false}
          />
        </div>
      )
    });


    if (this.props.myMessages.length > 0){
      return(
        <ul className='collapse-body'>
          {myMessages}
          <a className='section-separator'> </a>
          {this.props.messagesToMe.length > 0 &&
            messagesToMe}
        </ul>
      )
    } else {
      return null;
    }
  }
});
