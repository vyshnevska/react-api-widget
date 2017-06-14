describe 'Messanger', ->
  ReactTestUtils = React.addons.TestUtils

  beforeEach ->
    jasmine.Ajax.install()

    @props =
      myMessagesCount: 1
      isAuthorized: true
      currentUser:
        name: 'User Name'
      subscriptionsCount: 2

    spyOn(AjaxCustomMethods, 'isAuthorized').and.returnValue(true)

    @element      = React.createElement(Messanger, @props)
    @component    = ReactTestUtils.renderIntoDocument(@element)
    @$renderedDOM = window.ReactDOM.findDOMNode(@component)

  afterEach ->
    jasmine.Ajax.uninstall()

  describe 'render', ->
    it 'should have default sections', ->
      renderedHeader = @$renderedDOM.getElementsByTagName('header')[0]
      renderedBody   = @$renderedDOM.getElementsByClassName('body')[0]
      expect(@$renderedDOM.classList.value).toEqual("messages_box collapse-container")
      expect(renderedHeader).toHaveId('messages_box_header')
      expect(renderedBody.innerHTML).toContain("<a class=\"section-separator\"> </a><div class=\"channels\"></div><a class=\"section-separator\">")

    describe 'with currentUser', ->
      it 'should have user sections', ->
        renderedBody   = @$renderedDOM.getElementsByClassName('body')[0]
        expect(renderedBody.innerHTML).toContain("<a class=\"section-separator\"> </a><div class=\"channels\"></div><a class=\"section-separator\">")
