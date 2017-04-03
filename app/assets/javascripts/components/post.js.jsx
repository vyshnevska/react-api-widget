var Post = React.createClass({
  getInitialState() {
    return ({
      clicked: false,
      has_channel: !!this.props.channel,
      channel: this.props.channel
    })
  },

  isRenderedForAuthor(){
    return(typeof this.props.is_rendered_for !== 'undefined' && this.props.author_id == this.props.is_rendered_for);
  },

  channelIsActive(){
    return(this.state.has_channel && this.state.channel.active);
  },

  // Ajax calls
  // followAuthor(){

  // },

  createChannel(){
    var author_id   = this.props.author_id,
        currentPost = this;

    var ajaxOptions = {
          url: '/api/v1/subscriptions/create_channel',
          type: 'POST',
          dataType: 'json',
          headers: { "Authorization": "Token token=" + AjaxCustomMethods.getAuthToken() },
          contentType: "application/json; charset=utf-8",
          data: JSON.stringify({ channel: { user_id: author_id, name: 'Random Name', active: true } })
        };

    $.ajax(ajaxOptions).done(function(response){
      newState = {
        has_channel: true,
        channel: response.channel
      }
      currentPost.setState(newState);
    });
  },
  ////

  _renderChannelBtn(){
    if (this.channelIsActive()){
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
    if (this.isRenderedForAuthor() && !this.state.has_channel){
      return(
        <span>
          <button className='as-follow' onClick={this.createChannel}>
            <span>Start Channel</span>
          </button>
        </span>
      )
    }
  },

  _renderAuthorLine(){
    return (
      <div>
        <div className='author-text'>
          <div className='image-wrapper'>
            <img src="/assets/placeholders/author.png" />
          </div>
          <div className='text-content'>
            <a> {this.props.author_name}</a>
            {this._renderChannelBtn()}
            {this._renderCreateChannelBtn()}
            <div>Founder, Amazing Journalist and Great Author</div>
            <div>{LocalTime.relativeTimeAgo(new Date(this.props.publishedAt))}</div>
          </div>
        </div>
      </div>
    )
  },

  _showMe(){
    var newState = {};
    newState['clicked'] = true;
    this.setState(newState);
  },

  render: function() {
    commentsSection = <a onClick={this._showMe}>Show</a>;
    if(this.state.clicked){
      commentsSection = <div>
        <span> {this.props.published} </span>
        <span> {this.props.slug} </span>
      </div>
    }
    return (
      <div>
        {this._renderAuthorLine()}
        <h3>{this.props.title}</h3>
        <p>{this.props.body}</p>
        {commentsSection}
      </div>
    )
  }
});
