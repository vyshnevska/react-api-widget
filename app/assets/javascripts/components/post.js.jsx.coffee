@Post = React.createClass

  getInitialState: ->
    hasChannel:   !!@props.channel
    isSubscribed: @props.isSubscribed
    channel:      @props.channel

  currentUserPresent: ->
    @props.currentUser != null

  isRenderedForAuthor: ->
    @currentUserPresent() && @props.author.id == @props.currentUser.id

  channelIsActive: ->
    @state.hasChannel && @state.channel.active

  followAuthor: ->
    ajaxOptions =
      url:         '/api/v1/subscriptions.json'
      type:        'POST'
      dataType:    'json'
      headers:     { "Authorization": "Token token=" + AjaxCustomMethods.getAuthToken() }
      contentType: "application/json; charset=utf-8"
      data:        JSON.stringify({ user_id: @props.currentUser.id, channel_id: @state.channel.id })

    $.ajax(ajaxOptions).done (response) =>
      @setState
        isSubscribed: true

  createChannel: ->
    ajaxOptions =
      url:         '/api/v1/subscriptions/create_channel.json',
      type:        'POST',
      dataType:    'json',
      headers:     { "Authorization": "Token token=" + AjaxCustomMethods.getAuthToken() },
      contentType: "application/json; charset=utf-8",
      data:        JSON.stringify({ channel: { user_id: @props.author.id, name: 'By '+ @props.author.name, active: true } })

    $.ajax(ajaxOptions).done (response) =>
      @setState
        hasChannel: true,
        channel: { active: response.active, name: response.name }


  _renderChannelBtn: ->
    if @state.isSubscribed
      `<span>{'Subscribed to ' + this.state.channel.name}</span>`
    else if @channelIsActive() && @currentUserPresent()
      `<span>
        <button className='as-follow' onClick={this.followAuthor}>
          <span>{'Follow ' + this.state.channel.name}</span>
        </button>
      </span>`


  _renderCreateChannelBtn: ->
    if @isRenderedForAuthor() && !@state.hasChannel
      `<span>
        <button className='as-follow' onClick={this.createChannel}>
          <span>Start Channel</span>
        </button>
      </span>`

  _renderAuthorAvatar: ->
    if @props.author.avatar_url
      `<img src={this.props.author.avatar_url} />`
    else
      `<img src="/assets/placeholders/author.png" />`

  _renderAuthorLine: ->
    `<div>
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
    </div>`

  render: ->
    `<div>
      {this._renderAuthorLine()}
      <h3>{this.props.title}</h3>
      <p>{this.props.body}</p>
    </div>`