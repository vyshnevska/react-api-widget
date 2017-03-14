describe("NewMessage", function() {
  var ReactTestUtils = React.addons.TestUtils;

  beforeEach(function() {
    jasmine.Ajax.install(); // mock ajax call on componentDidMount
    this.element      = React.createElement(NewMessage, {
      sendNewMessageHandler: function() {},
      channelsSelectOptions: [{key: 99, label: 'opt1'}]
    });
    this.component    = ReactTestUtils.renderIntoDocument(this.element);
    this.$renderedDOM = window.ReactDOM.findDOMNode(this.component);
  });

  afterEach(function() {
    jasmine.Ajax.uninstall();
  });

  describe("render", function() {
    it("should work", function() {
      expect(this.$renderedDOM.getElementsByClassName('new_message_form')[0].children).toHaveLength(3)

      input = this.$renderedDOM.getElementsByTagName('input')[0];
      expect(input).toHaveAttr('placeholder', 'Enter the message');

      select = this.$renderedDOM.getElementsByTagName('select')[0];
      expect(select.options).toHaveLength(1);
      expect(select.options[0]).toHaveText('opt1');
      expect(select.options[0]).toHaveValue('99');
    });
  });

  describe("sendNewMessage", function() {
    let response = ['msg4']

    it("sends a message ON success", function() {
      mockSendNewMessageHandler = jasmine.createSpy('mockSendNewMessageHandler');

      newMessageElement   = React.createElement(NewMessage, {
        sendNewMessageHandler: mockSendNewMessageHandler ,
        channelsSelectOptions: [{key: 99, label: 'opt1'}]
      });
      newMessageComponent = ReactTestUtils.renderIntoDocument(newMessageElement);

      spyOn(jQuery, 'ajax').and.callFake(function (req) {
        var d = $.Deferred();
        d.resolve(response);
        return d.promise();
      });

      spyOn(newMessageComponent, 'toggleSection');

      submitButton = ReactTestUtils.findRenderedDOMComponentWithTag(newMessageComponent, 'button');
      ReactTestUtils.Simulate.click(submitButton);

      // handler function should have been called with new message as the first argument
      expect(mockSendNewMessageHandler.calls.mostRecent().args[0]).toEqual(['msg4']);
    });
  });
});