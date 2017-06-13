describe 'Header', ->
  ReactTestUtils = React.addons.TestUtils

  beforeEach ->
    @props =
      myMessagesCount: 1
      isAuthorized: true
      currentUser:
        name: 'User Name'
      subscriptionsCount: 2

    @element      = React.createElement(Header, @props)
    @component    = ReactTestUtils.renderIntoDocument(@element)
    @$renderedDOM = window.ReactDOM.findDOMNode(@component)

  describe 'render', ->
    it 'should work', ->
      rootElement = this.$renderedDOM.firstChild

      expect(rootElement).toHaveClass('messages')

      # Convert an HTMLCollection to an Array
      messagesChildren = Array.from(rootElement.children).map (i) =>
        i.tagName + '.' + i.className

      expect(messagesChildren).toEqual(['A.header-top-section', 'DIV.header-content', 'A.section-separator'])

  describe '_renderUserDetails', ->
    beforeEach ->
      @rootElement = @$renderedDOM.getElementsByClassName('user-details')[0]

    it 'should render a user link', ->
      $userLink = this.rootElement.querySelector('a')

      expect($userLink).toHaveAttr('href', 'link/to/user')
      expect($userLink).toHaveText('User Name')

    it 'should render a user details', ->
      $userDetails = this.rootElement.getElementsByClassName('more-details')[0]
      expect($userDetails).toHaveHtml('since 2016')

  describe '_renderUserStatistics', ->
    beforeEach ->
      @rootElement = @$renderedDOM.getElementsByClassName('user-statistics')[0]

    it 'should render a user link', ->
      statsList = this.rootElement.getElementsByClassName('item')

      expect(statsList).toHaveLength(2)
      expect(statsList[0]).toHaveHtml("<div>Messages</div><div>1</div>")
      expect(statsList[1]).toHaveHtml("<div>Channels</div><div>2</div>")
