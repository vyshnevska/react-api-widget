describe("Messanger", function() {
  var ReactTestUtils = React.addons.TestUtils;

  beforeEach(function() {
    jasmine.Ajax.install(); // mock ajax call on componentDidMount
    var props = {
      data: { messages_count: 1 }
    }
    this.element      = React.createElement(Messanger, props);
    this.component    = ReactTestUtils.renderIntoDocument(this.element);
    this.$renderedDOM = window.ReactDOM.findDOMNode(this.component);
  });

  afterEach(function() {
    jasmine.Ajax.uninstall();
  });

  describe("render", function() {
    it("should work", function() {
      let renderedHeader = this.$renderedDOM.getElementsByTagName('header')[0];
      let renderedBody   = this.$renderedDOM.getElementsByClassName('body')[0];

      expect(this.$renderedDOM.classList.value).toEqual("messages_box collapse-container");
      expect(renderedHeader).toHaveId('messages_box_header');
      expect(renderedBody.innerHTML).toEqual("<div class=\"new-message-container\"><div class=\"new_message_form\"><button>Send</button></div><div class=\"expand-trigger\"><input placeholder=\"Enter the message\"><img src=\"assets/message_feed/share_icon.png\" class=\"m-tool-icon\"></div></div><a class=\"section-separator\"> </a><ul class=\"collapse-body\"></ul>");
    });
  });
});