@MessageFeed = React.createClass
  propTypes:
    own_messages: React.PropTypes.array
    my_feed:      React.PropTypes.array
    channelsSelectOptions: React.PropTypes.object
    hasChannel:   React.PropTypes.bool

  #// ---- main methods
  getInitialState: ->
    own_messages: []
    my_feed: []

  handleSubmit: (message) ->
    @state.own_messages.unshift(message) #// adds a new message at the biginning
    @setState
      own_messages: @state.own_messages
    console.log('message was sent succesfully!', message)

  render: ->
    if @props.isAuthorized
      `<div className='feed-body'>
        {this.props.hasChannel &&
          <NewMessage
            sendNewMessageHandler={this.handleSubmit}
            channelsSelectOptions={[this.props.channelsSelectOptions]}
          />}
        <a className='section-separator'> </a>
        { <AvailableChannels />}
        <a className='section-separator'> </a>
        <AllMessages
          own_messages = {this.state.own_messages}
          my_feed      = {this.state.my_feed} />
      </div>`
    else
      `<div className='unauthorized'>
        <h5>You are not authorized </h5>
      </div>`