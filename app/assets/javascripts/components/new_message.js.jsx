var NewMessage = React.createClass({
  sendNewMessage(){
    var content      = this.refs.content.value,
        channel_id   = this.refs.channel_id.value,
        currentProps = this.props;

    var ajaxOptions = {
          url: '/api/v1/messages',
          type: 'POST',
          dataType: 'json',
          headers: { "Authorization": "Token token=" + AjaxCustomMethods.getAuthToken() },
          contentType: "application/json; charset=utf-8",
          data: JSON.stringify({ message: { content: content, channel_id: channel_id } })
        };
    console.log('The content value is ' + content + 'the channel_id value is ' + channel_id);

    // Initiate the AJAX request to messages#create
    $.ajax(ajaxOptions)
      .done(function(response){currentProps.sendNewMessageHandler(response);})
      .fail(AjaxCustomMethods.handleError);

    this.toggleSection(); // hide new message section
  },

  toggleSection(){
    var section = document.querySelector('.new_message_form')
    section.classList.toggle('expanded');
  },

  _renderChannelsSelect(){
    if (this.props.channelsSelectOptions.length > 0) {
      return(
        <select>
          {
            this.props.channelsSelectOptions.map(function (option) {
              return <option value={option.key} ref='channel_id'> {option.label}</option>;
            })
          }
        </select>);
    }
  },

  render: function() {
    return (
      <div className="box">
        <div className="new_message_form">
          <input ref='content' placeholder='Enter the message' />
          {this._renderChannelsSelect()}
          <button onClick={this.sendNewMessage}>Send</button>
        </div>
        <div className="icon" onClick={this.toggleSection}></div>
      </div>
    );
  }
});
NewMessage.propTypes = {
  sendNewMessageHandler: React.PropTypes.func,
  channelsSelectOptions: React.PropTypes.array
};
