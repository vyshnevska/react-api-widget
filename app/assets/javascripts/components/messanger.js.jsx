var Messanger = React.createClass({
  getInitialState() {
    return {
      messages: [],
      channelsSelectOptions: [],
      isAuthorized: AjaxCustomMethods.isAuthorized(),
      current_user: {}
    }
  },

  render: function() {
    return (
      <div className="messages_box collapse-container" id="messages_container">
        <div className="collapse-group">
          <Header
            messages_count  = {this.props.data.messages_count}
            isAuthorized    = {this.state.isAuthorized}
            current_user    = {this.props.current_user} />
          <MessageFeed isAuthorized = {this.state.isAuthorized} />
        </div>
      </div>
    )
  }
});
