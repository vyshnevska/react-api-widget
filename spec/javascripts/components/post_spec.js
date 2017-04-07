describe("Post", function() {
  var ReactTestUtils = React.addons.TestUtils;

  describe('for unlogged users', function() {
    beforeEach(function() {
      var props = {
        author: {name: 'John Smith', id: 1},
        body: 'lorem ipsum lorem ipsum',
        channel: { active: true, id: 7, name: "channel name" },
        isSubscribed: false,
        loggedUser: null,
        published: true,
        publishedAt: 1490645047986.583,
        slug: "article-1490645044"
      }

      this.element      = React.createElement(Post, props);
      this.component    = ReactTestUtils.renderIntoDocument(this.element);
      this.$renderedDOM = window.ReactDOM.findDOMNode(this.component);
    });

    describe("render", function() {
      it("should work", function() {
        $author_section = this.$renderedDOM.getElementsByClassName('author-text');
        expect($author_section[0].innerText).toEqual(" John SmithFounder, Amazing Journalist and Great Authoron Mar 27");
        expect(this.$renderedDOM.innerHTML).toContainText('lorem ipsum lorem ipsum');
      });
    });
  });

  describe('for logged in users', function() {
    beforeEach(function() {
      var props = {
        author: {name: 'John Smith', id: 1},
        body: 'lorem ipsum lorem ipsum',
        channel: { active: true, id: 7, name: "channel name" },
        loggedUser: { id: 2, name: "Nina", subscriptions: 1 },
        isSubscribed: false,
        published: true,
        publishedAt: 1490645047986.583,
        slug: "article-1490645044"
      }

      this.element      = React.createElement(Post, props);
      this.component    = ReactTestUtils.renderIntoDocument(this.element);
      this.$renderedDOM = window.ReactDOM.findDOMNode(this.component);
    });

    describe("render", function() {
      it("should work", function() {
        $author_section = this.$renderedDOM.getElementsByClassName('author-text');
        expect($author_section[0].innerText).toEqual(" John SmithFollow channel nameFounder, Amazing Journalist and Great Authoron Mar 27");
        expect(this.$renderedDOM.innerHTML).toContainText('lorem ipsum lorem ipsum');
      });
    });
  });
});