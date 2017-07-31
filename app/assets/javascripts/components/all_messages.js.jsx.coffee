@AllMessages = React.createClass

  getDefaultProps: ->
    myMessages: []
    messagesToMe: []

  render: ->
    myMessages = @props.myMessages.map (message) ->
      `<div key={message.id}>
        <MessageEntry message= {message}/>
      </div>`

    if @props.messagesToMe.length > 0
      messagesToMe = @props.messagesToMe.map (message) ->
        `<div key={this.message.id}>
          <MessageEntry message= {this.message}/>
        </div>`
      #{ messagesToMe}

    if @props.myMessages.length > 0
      `<ul className='collapse-body'>
        {myMessages}
        <a className='section-separator'> </a>

      </ul>`
    else
      `<span>No Messages Yet</span>`
