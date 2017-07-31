@Posts = React.createClass
  _publishedLabel: (post) ->
    if post.published
      label = 'published'
    else
      label = 'unpublished'

    `<span> {'state: '+ label} </span>`

  _renderPosts: ->
    @props.posts.map (post) ->
      `<div key={post.slug} className='col-md-3'>
        <div className='post'>
          <div className='image_wrapper'>
            <a href={'/posts/' + post.slug}>
              <img src={post.topImageUrl}/>
            </a>
          </div>
          <h2>
            <a href={'/posts/' + post.slug}>{post.slug}</a>
          </h2>
          <p className='published-date'>{LocalTime.relativeTimeAgo(new Date(post.publishedAt))}</p>
        </div>
      </div>`


  render: ->
    `<div className='row'>
      {this._renderPosts()}
     </div>`