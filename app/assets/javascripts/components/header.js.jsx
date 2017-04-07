var Header = React.createClass({
  _renderUserDetails: function() {
    return (
      <div className='user-details'>
        <div>
          <a href='link/to/user'>{this.props.current_user.name}</a>
        </div>
        <span className='more-details'>since 2016</span>
      </div>)
  },

  _renderUserStatistics: function() {
    if(this.props.isAuthorized){
      return(
      <div className="user-statistics">
        <div className='item'>
          <div>Messages</div>
          <div>{this.props.messages_count}</div>
        </div>
        <div className='item'>
          <div>Channels</div>
          <div>{this.props.current_user.subscriptions}</div>
        </div>

      </div>)
    } else {
      return null;
    }
  },

  render: function() {
    return (
      <header className='collapse-header' id='messages_box_header'>
        <div className='messages'>
          <a className='header-top-section'> </a>
          <div className='header-content'>
            <a className='avatar-outer-container'>
              <img src="/assets/message_feed/messages_icon.svg" className="m-tool-icon" />
            </a>
            {this._renderUserDetails()}
            {this._renderUserStatistics()}
          </div>
          <a className='section-separator'> </a>
        </div>
      </header>
    )
  }
});