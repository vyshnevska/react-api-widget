var Header = React.createClass({
  getInitialState() {
    return { isAuthorized: this.props.isAuthorized }
  },

  _renderUserDetails: function() {
    return (
      <div className='user-details'>
        <div>
          <a href='link/to/user'>User Name</a>
        </div>
        <span className='more-details'>since 2016</span>
      </div>)
  },

  _renderUserStatistics: function() {
    if(this.state.isAuthorized){
      return(
      <div className="user-statistics">
        <div className='item'>
          <div>Messages</div>
          <div>{this.props.messages_count}</div>
        </div>
        <div className='item'>
          <div>Channels</div>
          <div>100</div>
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