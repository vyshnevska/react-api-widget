var Messanger = React.createClass({

  render: function() {
   return (
      <div className="messages_box collapse-container" id="messages_container">
        <div className="collapse-group">
          <Header messages_count = {this.props.data.messages_count} />
          <MessageFeed />
        </div>
      </div>
    )
  }
});
