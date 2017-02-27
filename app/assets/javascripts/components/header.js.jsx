var Header = React.createClass({
  render: function() {
    return (
      <header className="collapse-header" id='messages_box_header' >
        <h2 className='title'>
          <a href='#' data-toggle='collapse' data-target='.collapse-one' target="_blank">
            Messanger
          </a>
        </h2>
        <ul className='tools'>
          <li>
            <span id='mercury_messages_counts'>{this.props.messages_count || 0}</span>
            <img src='assets/message_feed/messages_icon.svg' className='m-tool-icon'/>
          </li>
        </ul>
      </header>
    )
  }
});
