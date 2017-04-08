var Post = React.createClass({
  getInitialState() {
    return ({
      hasChannel:   !!this.props.channel,
      isSubscribed: this.props.isSubscribed,
      channel:      this.props.channel
    })
  },

  loggedUserPresent(){
    return this.props.loggedUser !== null;
  },

  isRenderedForAuthor(){
    return this.loggedUserPresent() && this.props.author.id == this.props.loggedUser.id;
  },

  channelIsActive(){
    return this.state.hasChannel && this.state.channel.active;
  },

  // Ajax calls
  followAuthor(){
    var currentPost = this,
        ajaxOptions = {
          url: '/api/v1/subscriptions.json',
          type: 'POST',
          dataType: 'json',
          headers: { "Authorization": "Token token=" + AjaxCustomMethods.getAuthToken() },
          contentType: "application/json; charset=utf-8",
          data: JSON.stringify({ user_id: this.props.loggedUser.id, channel_id: this.state.channel.id })
        };

    $.ajax(ajaxOptions).done(function(response){
      newState = { isSubscribed: true }
      currentPost.setState(newState);
    });
  },

  createChannel(){
    var author_id   = this.props.author.id,
        author_name   = this.props.author.name,
        currentPost = this;

    var ajaxOptions = {
        url: '/api/v1/subscriptions/create_channel.json',
        type: 'POST',
        dataType: 'json',
        headers: { "Authorization": "Token token=" + AjaxCustomMethods.getAuthToken() },
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ channel: { user_id: author_id, name: 'By '+author_name, active: true } })
      };

    $.ajax(ajaxOptions).done(function(response){
      newState = {
        hasChannel: true,
        channel: response.channel
      }
      currentPost.setState(newState);
    });
  },
  ////

  _renderChannelBtn(){
    if (this.state.isSubscribed){
      return(<span>{'Subscribed to ' + this.state.channel.name}</span>)
    } else if (this.channelIsActive() && this.loggedUserPresent()){
      return(
        <span>
          <button className='as-follow' onClick={this.followAuthor}>
            <span>{'Follow ' + this.state.channel.name}</span>
          </button>
        </span>
      )
    }
  },

  _renderCreateChannelBtn(){
    if (this.isRenderedForAuthor() && !this.state.hasChannel){
      return(
        <span>
          <button className='as-follow' onClick={this.createChannel}>
            <span>Start Channel</span>
          </button>
        </span>
      )
    }
  },

  _renderAuthorAvatar(){
    if (this.props.author.avatar_url){
       return(<img src={this.props.author.avatar_url} />)
    } else {
      return(<img src="/assets/placeholders/author.png" />)
    }
  },

  _renderAuthorLine(){
    return (
      <div>
        <div className='author-text'>
          <div className='image-wrapper'>
            {this._renderAuthorAvatar()}
          </div>
          <div className='text-content'>
            <a> {this.props.author.name}</a>
            {this._renderChannelBtn()}
            {this._renderCreateChannelBtn()}
            <div>Founder, Amazing Journalist and Great Author</div>
            <div>{LocalTime.relativeTimeAgo(new Date(this.props.publishedAt))}</div>
          </div>
        </div>
      </div>
    )
  },

  render: function() {
    return (
      <div>
        {this._renderAuthorLine()}
        <h3>{this.props.title}</h3>
        <p>{this.props.body}</p>
      </div>
    )
  }
});
