var MessageEntry = React.createClass({
  getInitialState() {
    return { status: this.props.status }
  },

  markAsRead(){
    currentMessage = this;

    var newMessageStatus = 'read',
        ajaxOptions = {
          url: '/api/v1/messages/' + this.props.id,
          type: 'PATCH',
          dataType: 'json',
          headers: { "Authorization": "Token token=" + AjaxCustomMethods.getAuthToken() },
          contentType: "application/json; charset=utf-8",
          data: JSON.stringify({ message: { status: newMessageStatus } })
        };

    if(currentMessage.state.status != newMessageStatus){
      $.ajax(ajaxOptions).done(function(){ currentMessage.setState({ status: newMessageStatus })});
    }
  },

  render: function() {
    return(
      <li id={this.props.id} className={this.state.status} onClick={this.markAsRead}>
        <div className='content left-column'>
          <a href='#' className='thumbnail'>
            <img src='assets/placeholders/channel.png' className='m-tool-icon'/>
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
