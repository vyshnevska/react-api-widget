var NewMessage = React.createClass({
  sendNewMessage(){
    var content      = this.refs.content.value,
        channel_id   = this.refs.channel_id.value,
        currentProps = this.props;

    // Don't allow an empty messages
    if (content.length <= 0){
      return false;
    }

    var ajaxOptions = {
          url: '/api/v1/messages',
          type: 'POST',
          dataType: 'json',
          headers: { "Authorization": "Token token=" + AjaxCustomMethods.getAuthToken() },
          contentType: "application/json; charset=utf-8",
          data: JSON.stringify({ message: { content: content, channel_id: channel_id } })
        };
    console.log('The content value is ' + content + 'the channel_id value is ' + channel_id);

    // reset textarea value
    this.refs.content.value = '';

    // Initiate the AJAX request to messages#create
    $.ajax(ajaxOptions)
      .done(function(response){ currentProps.sendNewMessageHandler(response);})
      .fail(AjaxCustomMethods.handleError);

    this.toggleSection(); // hide new message section
  },

  toggleSection(){
    section = document.querySelector('.new-message-container')
    section.classList.toggle('expanded')
  },

  _renderChannelsSelect(){
    if (this.props.channelsSelectOptions.length > 0) {
      return(
        <div className='form-group'>
          <select className='form-control form-control-sm'>
            {
              this.props.channelsSelectOptions.map(function (option) {
                return <option value={option.key} ref='channel_id'> {option.label}</option>;
              })
            }
          </select>
        </div>
        );
    }
  },

  render: function() {
    return (
      <div className="new-message-container">
        <div className="new_message_form">
          {this._renderChannelsSelect()}
          <button onClick={this.sendNewMessage} className='btn btn-secondary'>Send</button>
        </div>
        <div className="expand-trigger form-group" onClick={this.toggleSection}>
          <textarea className='form-control' ref='content' placeholder='Share your ideas!' rows="1">
          </textarea>
        </div>
      </div>
    );
  }
});
NewMessage.propTypes = {
  sendNewMessageHandler: React.PropTypes.func,
  channelsSelectOptions: React.PropTypes.array
};
