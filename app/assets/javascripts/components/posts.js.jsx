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
      <div className='row'>
        {this.props.posts.map(function(post){
          return (
            <div key={post.slug} className='col-md-3'>
              <div className='post'>
                <div className='image_wrapper'>
                  <a href={post.showUrl}>
                    <img src={post.topImageUrl}/>
                  </a>
                </div>
                <h2>
                  <a href={post.showUrl}>{post.slug}</a>
                </h2>
                <p className='published-date'> {post.createdAt} </p>
              </div>
            </div>
          )
        }, this)}
      </div>)
  }
});