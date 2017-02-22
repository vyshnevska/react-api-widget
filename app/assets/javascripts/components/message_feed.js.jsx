var MessageFeed = React.createClass({
  _renderHeader(){
    var data = this.props.data.messages_count || 0;
    return (
      <header className="collapse-header">
        <h2 className='title'>
          <a href='#' data-toggle='collapse' data-target='.collapse-one' target="_blank">
            Messanger
          </a>
        </h2>
        <ul className='tools'>
          <li>
            <span id='mercury_messages_counts'>{data}</span>
            <img src='assets/message_feed/messages_icon.svg' className='m-tool-icon'/>
          </li>
        </ul>
      </header>
    )
  },

  render: function() {
    return (
      <div className="messages_box collapse-container" id="mercury_container">
        <div className="collapse-group">
          {this._renderHeader()}
          <div className='body'>
            <ul className='collapse-body'>
              {this.props.messages.map(function(message){
                return (
                  <MessageEntry
                    id             = {message.data.id}
                    message        = 'Welcome to Messanger!'
                    channel_slug   = 'MK'
                    publisher_name = 'publisher'
                    sent_date      = {message.data.sent_date}
                  />
                )
              }, this)}
            </ul>
          </div>
        </div>
      </div>
    )
  }
});