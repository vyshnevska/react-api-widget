describe("NewMessage", function() {
  var ReactTestUtils = React.addons.TestUtils;

  beforeEach(function() {
    jasmine.Ajax.install(); // mock ajax call on componentDidMount
    this.element      = React.createElement(NewMessage, { sendNewMessageHandler: function() {} });
    this.component    = ReactTestUtils.renderIntoDocument(this.element);
    this.$renderedDOM = window.ReactDOM.findDOMNode(this.component);
  });

  afterEach(function() {
    jasmine.Ajax.uninstall();
  });

  describe("render", function() {
    it("should work", function() {
      expect(this.$renderedDOM.textContent).toEqual('Send')
      expect(this.$renderedDOM.children).toHaveLength(3)

      inputs = this.$renderedDOM.getElementsByTagName('input');
      expect(inputs[0]).toHaveAttr('placeholder', 'Enter the message');
      expect(inputs[1]).toHaveAttr('placeholder', 'Enter a sender');
    });
  });

  describe("sendNewMessage", function() {
    let response = ['msg4']

    it("sends a message ON success", function() {
      mockSendNewMessageHandler = jasmine.createSpy('mockSendNewMessageHandler');

      newMessageElement   = React.createElement(NewMessage, { sendNewMessageHandler: mockSendNewMessageHandler });
      newMessageComponent = ReactTestUtils.renderIntoDocument(newMessageElement);

      spyOn(jQuery, 'ajax').and.callFake(function (req) {
        var d = $.Deferred();
        d.resolve(response);
        return d.promise();
      });

      submitButton = ReactTestUtils.findRenderedDOMComponentWithTag(newMessageComponent, 'button');
      ReactTestUtils.Simulate.click(submitButton);

      // handler function should have been called with new message as the first argument
      expect(mockSendNewMessageHandler.calls.mostRecent().args[0]).toEqual(['msg4']);
    });
  });
});