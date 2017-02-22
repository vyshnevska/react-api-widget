var MessageEntry = React.createClass({

  render: function() {
    return(
      <li id={this.props.id}>
        <a href='#' className='thumbnail'>
          {'#' + this.props.channel_slug + '#'}
        </a>
        <div className='content'>
          <h3>{'from ' + this.props.publisher_name}</h3>
          <span className='preview'> {this.props.message} </span>
          <span className='meta'> {this.props.sent_date} </span>
        </div>
      </li>
    )
  }
});
