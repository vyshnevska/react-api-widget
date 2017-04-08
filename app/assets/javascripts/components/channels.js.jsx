var AvailableChannels = React.createClass({
  getInitialState() {
    return { channels: [] }
  },

  componentDidMount() {
    var channelContainer = this,
        ajaxOptions = {
          url:         'api/v1/subscriptions/channels.json',
          type:        'GET',
          dataType:    'json',
          headers:     {"Authorization": "Token token=" + AjaxCustomMethods.getAuthToken()},
          contentType: "application/json; charset=utf-8"
        };

    $.ajax(ajaxOptions).done(function(response){
      channelContainer.setState({ channels: response });
    }).fail(AjaxCustomMethods.handleError);
  },

  render: function(){
    var channels = this.state.channels.map((channel) => {
      return(
        <div key={channel.id} className='channel-item'><img src='assets/placeholders/channel.png' className='m-tool-icon'/>
          {channel.name} by {channel.user_id}
        </div>
      )
    });

    return(
      <div className='channels'>
        {channels}
      </div>
    )
  }
});