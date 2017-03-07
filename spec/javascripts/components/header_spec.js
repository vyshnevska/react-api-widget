describe("Header", function() {
  var ReactTestUtils = React.addons.TestUtils;

  beforeEach(function() {
    this.element      = React.createElement(Header, { messages_count: 1 });
    this.component    = ReactTestUtils.renderIntoDocument(this.element);
    this.$renderedDOM = window.ReactDOM.findDOMNode(this.component);
  });

  describe("render", function() {
    it("should work", function() {
      let rootElement = this.$renderedDOM.getElementsByClassName('messages')[0];

      // Convert an HTMLCollection to an Array
      var messagesChildren = Array.from(rootElement.children).map(function(i){ return i.tagName + '.' + i.className;});
      expect(messagesChildren).toEqual(["A.header-top-section", "DIV.header-content", "A.header-bottom-section"]);
    });
  });

  describe("_renderUserDetails", function() {
    beforeEach(function() {
      this.rootElement = this.$renderedDOM.getElementsByClassName('user-details')[0];
    });

    it("should render a user link", function() {
      $userLink = this.rootElement.querySelector('a');
      expect($userLink.getAttribute('href')).toEqual('link/to/user');
      expect($userLink.text).toEqual('User Name');
    });

    it("should render a user details", function() {
      $userDetails = this.rootElement.getElementsByClassName('more-details')[0];
      expect($userDetails.innerHTML).toEqual('since 2016');
    });
  });

  describe("_renderUserStatistics", function() {
    beforeEach(function() {
      this.rootElement = this.$renderedDOM.getElementsByClassName('user-statistics')[0];
    });

    it("should render a user link", function() {
      let statsList = this.rootElement.getElementsByTagName('li');

      expect(statsList[0].innerHTML).toEqual("<a href=\"link/to/user\"><span class=\"statistics-name\">Messages</span><span class=\"statistics-value\">1</span></a>");
      expect(statsList[1].innerHTML).toEqual("<a href=\"link/to/user\"><span class=\"statistics-name\">Channels</span><span class=\"statistics-value\">100</span></a>");
    });
  });
});