describe("Messanger", function() {
  var ReactTestUtils = React.addons.TestUtils;

  beforeEach(function() {
    var props = {
        data: {
          messages_count: 1
        }
      }
    this.element      = React.createElement(Messanger, props);
    this.component    = ReactTestUtils.renderIntoDocument(this.element);
    this.$renderedDOM = window.ReactDOM.findDOMNode(this.component);
  });

  describe("render", function() {
    it("should work", function() {
      let renderedHeaders = this.$renderedDOM.getElementsByTagName('header');
      let renderedBodys = this.$renderedDOM.getElementsByClassName('body');

      expect(this.$renderedDOM.classList.value).toEqual("messages_box collapse-container");
      expect(renderedHeaders.length).toEqual(1);
      expect(renderedHeaders[0].id).toEqual('messages_box_header');
      expect(renderedBodys.length).toEqual(1);

      // Convert an HTMLCollection to an Array
      var bodyChildren = Array.from(renderedBodys[0].children).map(function(i){ return i.tagName + i.className;});
      expect(bodyChildren).toEqual(['DIV', 'ULcollapse-body']);
    });
  });
});