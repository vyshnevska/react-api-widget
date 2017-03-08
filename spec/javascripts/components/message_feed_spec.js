describe("MessageFeed", function() {
  var ReactTestUtils = React.addons.TestUtils;

  beforeEach(function() {
    jasmine.Ajax.install(); // mock ajax call on componentDidMount
    this.element      = React.createElement(MessageFeed);
    this.component    = ReactTestUtils.renderIntoDocument(this.element);
    this.$renderedDOM = window.ReactDOM.findDOMNode(this.component);
  });

  afterEach(function() {
    jasmine.Ajax.uninstall();
  });

  describe("getInitialState", function() {
    it('should have no messages by default', function() {
      expect(this.component.getInitialState().messages).toEqual([]);
    });
  });

  describe("showMessages", function() {
    let data = ['msg1', 'msg2'];

    it('should change state', function() {
      this.component.showMessages(data);
      expect(this.component.state.messages).toEqual(['msg1', 'msg2']);
    });
  });

  describe("componentDidMount", function() {
    let data = ['msg1', 'msg2'];

    it("loads data from a url", function(){
      spyOn(jQuery, 'ajax').and.callThrough();
      spyOn(AjaxCustomMethods, 'getAuthToken');

      this.component.componentDidMount();

      expect(jQuery.ajax).toHaveBeenCalled;
      expect(jasmine.Ajax.requests.mostRecent().url).toBe('/api/v1/messages.json');
      expect(jQuery.done).toHaveBeenCalled;
      expect(AjaxCustomMethods.getAuthToken).toHaveBeenCalled();
    });

    it("should execute the showMessages function on success", function () {
      // Mock success response
      spyOn(jQuery, 'ajax').and.callFake(function (req) {
        var d = $.Deferred();
        d.resolve(data);
        return d.promise();
      });

      spyOn(this.component, 'showMessages').and.callThrough();

      this.component.componentDidMount();

      expect(this.component.showMessages).toHaveBeenCalled();
      expect(this.component.state.messages).toEqual(data);

      // var doneFn = jasmine.createSpy("success");
      //  jasmine.Ajax.stubRequest('/api/v1/messages.json').andReturn({
      //   "responseText": data
      // });

      // var xhr = new XMLHttpRequest();
      // xhr.onreadystatechange = function(args) {
      //   if (this.readyState == this.DONE) {
      //     doneFn(this.responseText);
      //   }
      // };

      // xhr.open("GET", '/api/v1/messages.json');
      // xhr.send();
      // expect(doneFn).toHaveBeenCalledWith(["msg1","msg2"]);
    });

    it("should execute the handleError function on error", function () {
      // Mock error response
      spyOn(jQuery, 'ajax').and.callFake(function (req) {
        var d = $.Deferred();
        d.reject({responseText: 'error happened'});
        return d.promise();
      });
      spyOn(AjaxCustomMethods, 'handleError');

      this.component.componentDidMount();

      expect(AjaxCustomMethods.handleError).toHaveBeenCalled();
      expect(this.component.state.messages).toEqual([]);
    });
  });
});