var MessageEntry = React.createClass({
  getInitialState() {
    return { status: this.props.status }
  },

  updateMessage(current, newMessageStatus){
     var ajaxOptions = {
          url: '/api/v1/messages/' + this.props.id,
          type: 'PATCH',
          dataType: 'json',
          headers: { "Authorization": "Token token=" + AjaxCustomMethods.getAuthToken() },
          contentType: "application/json; charset=utf-8",
          data: JSON.stringify({ message: { status: newMessageStatus } })
        };

    if(current.state.status != newMessageStatus){
      $.ajax(ajaxOptions).done(function(){ current.setState({ status: newMessageStatus })});
    }
  },

  readFullMessage(event){
    // expand message content
    if (this.props.isLong ){
      event.target.offsetParent.classList.toggle('expanded')
    }
    this.updateMessage(this, 'read');
  },

  hideMessage(event){
    event.target.offsetParent.classList.remove('expanded');
  },

  removeMessage(event){
    this.updateMessage(this,'hidden');
  },

  renderActionOverlay(event){
    if (!event.target.classList.contains('expanded')){
      event.target.classList.add('expanded');
      $(event.target).animate({duration: 350, width: '100px'});
    }
  },

  hideActionOverlay(event){
    if (event.target.classList.contains('expanded')){
      event.target.classList.remove('expanded');
      $(event.target).animate({duration: 350, width: '10px'});
    }
  },

  render: function() {
    return(
      <li id={this.props.id} className={this.state.status}>
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
          <div className='item m-actions' onMouseOver={this.renderActionOverlay} onMouseLeave={this.hideActionOverlay}>
            <button onClick={this.readFullMessage} className='btn as-coral'>Read</button>
            { this.props.isLong &&
              <button onClick={this.hideMessage} className='btn btn-default'>Hide</button>
            }
            <button onClick={this.removeMessage} className='btn as-red'>Remove</button>
          </div>
        </div>
      </li>
    )
  }
});
