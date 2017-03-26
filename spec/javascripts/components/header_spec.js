describe("Header", function() {
  var ReactTestUtils = React.addons.TestUtils;

  beforeEach(function() {
    this.element      = React.createElement(Header, { messages_count: 1, isAuthorized: true });
    this.component    = ReactTestUtils.renderIntoDocument(this.element);
    this.$renderedDOM = window.ReactDOM.findDOMNode(this.component);
  });

  describe("render", function() {
    it("should work", function() {
      let rootElement = this.$renderedDOM.firstChild;

      expect(rootElement).toHaveClass('messages')
      // Convert an HTMLCollection to an Array
      var messagesChildren = Array.from(rootElement.children).map(function(i){ return i.tagName + '.' + i.className;});
      expect(messagesChildren).toEqual(['A.header-top-section', 'DIV.header-content', 'A.section-separator']);
    });
  });

  describe("_renderUserDetails", function() {
    beforeEach(function() {
      this.rootElement = this.$renderedDOM.getElementsByClassName('user-details')[0];
    });

    it("should render a user link", function() {
      $userLink = this.rootElement.querySelector('a');

      expect($userLink).toHaveAttr('href', 'link/to/user')
      expect($userLink).toHaveText('User Name');
    });

    it("should render a user details", function() {
      $userDetails = this.rootElement.getElementsByClassName('more-details')[0];
      expect($userDetails).toHaveHtml('since 2016');
    });
  });

  describe("_renderUserStatistics", function() {
    beforeEach(function() {
      this.rootElement = this.$renderedDOM.getElementsByClassName('user-statistics')[0];
    });

    it("should render a user link", function() {
      let statsList = this.rootElement.getElementsByTagName('li');

      expect(statsList).toHaveLength(2);
      expect(statsList[0]).toHaveHtml("<a href=\"link/to/user\"><span class=\"statistics-name\">Messages</span><span class=\"statistics-value\">1</span></a>");
      expect(statsList[1]).toHaveHtml("<a href=\"link/to/user\"><span class=\"statistics-name\">Channels</span><span class=\"statistics-value\">100</span></a>");
    });
  });
});