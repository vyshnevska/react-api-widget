@MessageFeed = React.createClass
  propTypes:
    myMessages:   React.PropTypes.array
    messagesToMe: React.PropTypes.array
    channelsSelectOptions: React.PropTypes.object
    hasChannel:   React.PropTypes.bool

  #// ---- main methods
  getInitialState: ->
    myMessages: @props.myMessages
    messagesToMe: @props.messagesToMe

  handleSubmit: (message) ->
    @state.myMessages.unshift(message) #// adds a new message at the biginning
    @setState
      myMessages: @state.myMessages
    console.log('message was sent succesfully!', message)

  _renderNewMessage: ->
    if @props.hasChannel == 'true'
      `<div>
          <NewMessage
            sendNewMessageHandler={this.handleSubmit}
            channelsSelectOptions={[this.props.channelsSelectOptions]}
          />
      </div>`

  render: ->
    if @props.isAuthorized
      `<div className='feed-body'>
        {this._renderNewMessage()}
        <a className='section-separator'> </a>
        { <AvailableChannels />}
        <a className='section-separator'> </a>
        <AllMessages
          myMessages   = {this.props.myMessages}
          messagesToMe = {this.props.messagesToMe} />
      </div>`
    else
      `<div className='unauthorized'>
        <h5>You are not authorized </h5>
      </div>`