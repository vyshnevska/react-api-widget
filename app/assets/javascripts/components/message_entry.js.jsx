var MessageEntry = React.createClass({

  render: function() {
    return(
      <li id={this.props.id}>
        <div className='content left-column'>
          <a href='#' className='thumbnail'>
            <img src='assets/message_feed/img_placeholder.png' className='m-tool-icon'/>
            {'CH 1'}
          </a>
        </div>
        <div className='content right-column'>
          <h5>{'from ' + this.props.publisher_name}</h5>
          <span className='preview'> {this.props.message} </span>
          <span className='meta'> {this.props.sent_date} </span>
        </div>
      </li>
    )
  }
});
