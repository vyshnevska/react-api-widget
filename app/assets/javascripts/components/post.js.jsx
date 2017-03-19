var Post = React.createClass({
  getInitialState() {
    return ({ clicked: false })
  },

  isRenderedForAuthor(){
    return(typeof this.props.is_rendered_for !== 'undefined' && this.props.author_id == this.props.is_rendered_for);
  },

  channelIsActive(){
    return(!!this.props.channel && this.props.channel.active);
  },

  _renderChannelBtn(){
    if (this.channelIsActive()){
      return(
        <span>
          <button className='as-follow' onClick='this.followAuthor'>
            <span>Follow</span>
          </button>
        </span>
      )
    }
  },

  _renderCreateChannelBtn(){
    if (this.isRenderedForAuthor() && !this.channelIsActive()){
      return(
        <span>
          <button className='as-follow' onClick='this.createChannel'>
            <span>Start Channel</span>
          </button>
        </span>
      )
    }
  },

  _renderAuthorLine(){
    return (
      <div>
        <div className='author-container'>
          <div className='avatar'>
            <img src="/assets/placeholders/author.png" />
          </div>
          <div className='details'>
            <a> {this.props.author_name}</a>
            {this._renderChannelBtn()}
            {this._renderCreateChannelBtn()}
            <div>Founder, Amazing Journalist and Great Author</div>
            <div> Mar 15 - 5min
            </div>
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
