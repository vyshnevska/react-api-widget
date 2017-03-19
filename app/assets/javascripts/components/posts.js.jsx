var Posts = React.createClass({
  _publishedLabel(post){
    var label;
    if(post.published){
      label = 'published'
    } else{
      label = 'unpublished'
    }
    return (<span> {'state: '+label} </span>)
  },

  render: function() {
    return (
      <div>
        <h2>All posts here</h2>
        {this.props.posts.map(function(post){
          return (
            <div key={post.slug.toString()}>
              {this._publishedLabel(post)}
              <span>
                | <a href={'posts/' + post.slug}>{CustomMethods.truncate(post.body)} </a>
              </span>
              <span>|  {post.slug} </span>
            </div>
          )
        }, this)}
      </div>)
  }
});