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

  hideMessage(event){
  },

  _renderActionOverlay(event){
    if (!event.target.classList.contains('expanded')){
      event.target.classList.add('expanded');
      $(event.target).animate({duration: 350, width: '100px'}); //, opacity: 0.1
      console.log('on hover')
    }
  },

  _hideActionOverlay(event){
    if (event.target.classList.contains('expanded')){
      event.target.classList.remove('expanded');
      $(event.target).animate({duration: 350, width: '10px', opacity: 1});
      console.log('on leave')
    }
  },

  render: function() {
    return(
      <li id={this.props.id} className={this.state.status} onClick={this.readFullMessage}>
        <div className='message-entry-wrapper'>
          <div className='item m-image-section'>
            <div className='vertical-wrapper'>
              <img src='assets/placeholders/channel.png' className='m-tool-icon'/>
            </div>
          </div>
          <div className='item m-content-section'>
            <div className='content'> {this.props.message} </div>
            <div className='footer'>
              <div className='as-column'>{'from ' + this.props.publisherName}</div>
              <div className='as-column'>{LocalTime.relativeTimeAgo(new Date(this.props.sentAt))}</div>
            </div>
          </div>
          <div className='item m-actions' onMouseOver={this._renderActionOverlay} onMouseLeave={this._hideActionOverlay}>
            <button onClick={this.readFullMessage} className='btn as-coral'>Read</button>
            <button onClick={this.hideMessage} className='btn btn-default'>Hide</button>
          </div>
        </div>
      </li>
    )
  }
});
