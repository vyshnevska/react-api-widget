var NewMessage = React.createClass({
  sendNewMessage(){
    var content = this.refs.content.value;
    var sender_id = this.refs.sender_id.value;
    console.log('The content value is ' + content + 'the sender_id value is ' + sender_id);
    $.ajax({
      url: '/api/v1/messages',
      type: 'POST',
      data: { message: { content: content, sender_id: sender_id } },
      success: (message) => {
        console.log('message was sent succesfully!', message);
        this.props.handleSubmit(message);
      }
    });

  },

  render: function() {
    return (
      <div>
        <input ref='content' placeholder='Enter the message' />
        <input ref='sender_id' placeholder='Enter a sender' />
        <button onClick={this.sendNewMessage}>Send</button>
      </div>
    )
  }
});
