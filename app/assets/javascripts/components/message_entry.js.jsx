var MessageEntry = React.createClass({
  getInitialState() {
    return { status: this.props.status }
  },

  markAsRead(){
    currentMessage = this;

    var newMessageStatus = 'read',
        ajaxOptions = {
          url: '/api/v1/messages/' + this.props.id,
          type: 'PATCH',
          dataType: 'json',
          headers: { "Authorization": "Token token=" + AjaxCustomMethods.getAuthToken() },
          contentType: "application/json; charset=utf-8",
          data: JSON.stringify({ message: { status: newMessageStatus } })
        };

    if(currentMessage.state.status != newMessageStatus){
      $.ajax(ajaxOptions).done(function(){ currentMessage.setState({ status: newMessageStatus })});
    }
  },

  render: function() {
    return(
      <li id={this.props.id} className={this.state.status} onClick={this.markAsRead}>
        <div className='message-entry-wrapper'>
          <div className='item'>
            <div className='vertical-wrapper'>
              <img src='assets/placeholders/channel.png' className='m-tool-icon'/>
            </div>
          </div>
          <div className='item'>
            <div className='message-content'> {CustomMethods.truncate(this.props.message, 65)} </div>
            <div className='message-footer'>
              <div className='column'>{'from ' + this.props.publisherName}</div>
              <div className='column'>{LocalTime.relativeTimeAgo(new Date(this.props.sentAt))}</div>
            </div>
          </div>
        </div>
      </li>
    )
  }
});
