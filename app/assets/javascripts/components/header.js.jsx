var Header = React.createClass({
  render: function() {
    return (
      <header className='collapse-header' id='messages_box_header'>
        <div className='messages'>
          <a className='header-top-section'> </a>
          <div className='header-content'>
            <a className='avatar-outer-container'>
              <img src='assets/message_feed/messages_icon.svg' className='m-tool-icon'/>
            </a>
            <div className='user-details'>
              <div>
                <a href='link/to/user'>User Name</a>
              </div>
              <span className='more-details'>since 2016 </span>
            </div>
            <div className="user-statistics">
              <ul className='as-table'>
                <li>
                  <a href='link/to/user'>
                    <span className='statistics-name'>Messages</span>
                    <span className='statistics-value'>{this.props.messages_count || 0}</span>
                  </a>
                </li>
                <li>
                  <a href='link/to/user'>
                    <span className='statistics-name'>Channels</span>
                    <span className='statistics-value'>100</span>
                  </a>
                </li>
              </ul>
            </div>
          </div>
          <a className='header-bottom-section'> </a>
        </div>
      </header>
    )
  }
});