var MessageEntry = React.createClass({
  getInitialState() {
    return { status: this.props.status }
  },

  readFullMessage(event){
    _current = this;

    // expand message content
    if(_current.props.isLong ){
      event.target.offsetParent.classList.toggle('expanded')
    }

    var newMessageStatus = 'read',
        ajaxOptions = {
          url: '/api/v1/messages/' + this.props.id,
          type: 'PATCH',
          dataType: 'json',
          headers: { "Authorization": "Token token=" + AjaxCustomMethods.getAuthToken() },
          contentType: "application/json; charset=utf-8",
          data: JSON.stringify({ message: { status: newMessageStatus } })
        };

    if(_current.state.status != newMessageStatus){
      $.ajax(ajaxOptions).done(function(){ _current.setState({ status: newMessageStatus })});
    }
  },

  render: function() {
    return(
      <li id={this.props.id} className={this.state.status} onClick={this.readFullMessage}>
        <div className='message-entry-wrapper'>
          <div className='item'>
            <div className='vertical-wrapper'>
              <img src='assets/placeholders/channel.png' className='m-tool-icon'/>
            </div>
          </div>
          <div className='item'>
            <div className='message-content'> {this.props.message} </div>
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
