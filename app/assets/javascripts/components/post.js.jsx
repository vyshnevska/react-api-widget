var Post = React.createClass({
  getInitialState() {
    return ({ clicked: false })
  },

  _renderAuthorLine(){
    return (
      <div>
        <div className='author-container'>
          <div className='avatar'>
            <img src="/assets/placeholders/author.png" />
          </div>
          <div className='details'>
            <a> {this.props.author}</a>
            <span>
              <button className='as-follow'>
                <span>Follow</span>
              </button>
            </span>
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
