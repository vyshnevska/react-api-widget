@Header = React.createClass

  getDefaultProps: ->
    subscriptionsCount: 0
    myMessagesCount: 0

  _renderUserDetails: ->
    if @props.currentUser != null
      `<div className='user-details'>
        <div>
          <a href='link/to/user'>{this.props.currentUser.name}</a>
        </div>
        <span className='more-details'>since 2016</span>
      </div>`

  _renderUserStatistics: ->
    if @props.isAuthorized
      `<div className="user-statistics">
        <div className='item'>
          <div>Messages</div>
          <div>{this.props.myMessagesCount}</div>
        </div>
        <div className='item'>
          <div>Channels</div>
          <div>{this.props.subscriptionsCount}</div>
        </div>
      </div>`
    else
      null

  render: ->
    `<header className='collapse-header' id='messages_box_header'>
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
      </header>`
