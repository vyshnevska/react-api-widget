@NewMessage = React.createClass
  propTypes:
    sendNewMessageHandler: React.PropTypes.func
    channelsSelectOptions: React.PropTypes.array

  sendNewMessage: ->
    content      = this.refs.content.value
    channel_id   = this.refs.channel_id.value
    currentProps = this.props

    #// Don't allow an empty messages
    if content.length <= 0
      false

    ajaxOptions =
      url: '/api/v1/messages'
      type: 'POST'
      dataType: 'json'
      headers: { "Authorization": "Token token=" + AjaxCustomMethods.getAuthToken() }
      contentType: "application/json; charset=utf-8"
      data: JSON.stringify ->
        { message: { content: content, channel_id: channel_id } }

    console.log('The content value is ' + content + 'the channel_id value is ' + channel_id);

    #// reset textarea value
    @refs.content.value = ''

    #// Initiate the AJAX request to messages#create
    $.ajax(ajaxOptions)
      .done (response) ->
        currentProps.sendNewMessageHandler(response)
      .fail(AjaxCustomMethods.handleError)

    @toggleSection() #// hide new message section

  toggleSection: ->
    section = document.querySelector('.new-message-container')
    section.classList.toggle('expanded')

  _renderSelectOptions: ->
    this.props.channelsSelectOptions.map (channel) ->
      `<option key={channel.id} value={channel.id} ref='channel_id'> {channel.name}</option>`

  _renderChannelsSelect: ->
    if this.props.channelsSelectOptions.length > 0
      `<div className='form-group'>
        <select className='form-control form-control-sm'>
          {this._renderSelectOptions()}
        </select>
      </div>`

  render: ->
    `<div className="new-message-container">
      <div className="new_message_form">
        {this._renderChannelsSelect()}
        <button onClick={this.sendNewMessage} className='btn btn-secondary'>Send</button>
      </div>
      <div className="expand-trigger form-group" onClick={this.toggleSection}>
        <textarea className='form-control' ref='content' placeholder='Share your ideas!' rows="1">
        </textarea>
      </div>
    </div>`