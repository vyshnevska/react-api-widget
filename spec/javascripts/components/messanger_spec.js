describe("Messanger", function() {
  var ReactTestUtils = React.addons.TestUtils;

  beforeEach(function() {
    jasmine.Ajax.install(); // mock ajax call on componentDidMount
    spyOn(AjaxCustomMethods, 'isAuthorized').and.returnValue(true);

    this.element      = React.createElement(Messanger, { data: { messages_count: 1 }, is_rendered_for: 1});
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
      expect(renderedBody.innerHTML).toEqual("<div class=\"new-message-container\"><div class=\"new_message_form\"><button>Send</button></div><div class=\"expand-trigger\"><input placeholder=\"Share your ideas!\"><img src=\"/assets/icons/share.png\" class=\"m-tool-icon\"></div></div><a class=\"section-separator\"> </a><ul class=\"collapse-body\"></ul>")
    });
  });
});