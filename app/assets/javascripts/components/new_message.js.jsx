var NewMessage = React.createClass({
  sendNewMessage(){
    var content = this.refs.content.value,
        sender_id = this.refs.sender_id.value,
        currentProps = this.props;

    var ajaxOptions = {
          url: '/api/v1/messages',
          type: 'POST',
          dataType: 'json',
          headers: { "Authorization": "Token token=" + AjaxCustomMethods.getAuthToken() },
          contentType: "application/json; charset=utf-8",
          data: JSON.stringify({ message: { content: content, sender_id: sender_id } })
        };

    console.log('The content value is ' + content + 'the sender_id value is ' + sender_id);

    // Initiate the AJAX request to messages#create
    $.ajax(ajaxOptions)
      .done(function(response){currentProps.sendNewMessageHandler(response);})
      .fail(AjaxCustomMethods.handleError);
  },

  clickkki(){
    $('.new_message').toggleClass('expanded');
  },

  render: function() {
    return (
      <div className="box">
        <input className="new_message" type="search" placeholder="Send" />
        <div className="icon" onClick={this.clickkki}></div>
      </div>
      // <div>
      //   <input ref='content' placeholder='Enter the message' />
      //   <input ref='sender_id' placeholder='Enter a sender' />
      //   <button onClick={this.sendNewMessage}>Send</button>
      // </div>
    )
  }
});
