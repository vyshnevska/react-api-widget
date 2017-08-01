describe("MessageFeed", function() {
  var ReactTestUtils = React.addons.TestUtils;

  let data = {
    messages: ['msg1', 'msg2'],
    channels: []
  };

  beforeEach(function() {
    jasmine.Ajax.install(); // mock ajax call on componentDidMount
    this.element      = React.createElement(MessageFeed, {isAuthorized: true});
    this.component    = ReactTestUtils.renderIntoDocument(this.element);
    this.$renderedDOM = window.ReactDOM.findDOMNode(this.component);
  });

  afterEach(function() {
    jasmine.Ajax.uninstall();
  });

  describe("getInitialState", function() {
    it('should have no own messages by default', function() {
      expect(this.component.getInitialState().own_messages).toEqual([]);
    });
     it('should have no messages to me by default', function() {
      expect(this.component.getInitialState().my_feed).toEqual([]);
    });
  });

  // describe("populateData", function() {
  //   it('should change state', function() {
  //     this.component.populateData(data);
  //     expect(this.component.state.messages).toEqual(['msg1', 'msg2']);
  //   });
  // });

  // describe("componentDidMount", function() {
  //   // let data = ['msg1', 'msg2'];

  //   it("loads data from a url", function(){
  //     spyOn(jQuery, 'ajax').and.callThrough();
  //     spyOn(AjaxCustomMethods, 'getAuthToken');

  //     this.component.componentDidMount();

  //     expect(jQuery.ajax).toHaveBeenCalled;
  //     expect(jasmine.Ajax.requests.mostRecent().url).toBe('/api/v1/messages.json');
  //     expect(jQuery.done).toHaveBeenCalled;
  //     expect(AjaxCustomMethods.getAuthToken).toHaveBeenCalled();
  //   });

  //   it("should execute the populateData function on success", function () {
  //     // Mock success response
  //     spyOn(jQuery, 'ajax').and.callFake(function (req) {
  //       var d = $.Deferred();
  //       d.resolve(data);
  //       return d.promise();
  //     });

  //     spyOn(this.component, 'populateData').and.callThrough();

  //     this.component.componentDidMount();

  //     expect(this.component.populateData).toHaveBeenCalled();
  //     expect(this.component.state.messages).toEqual(data.messages);
  //   });

  //   it("should execute the handleError function on error", function () {
  //     // Mock error response
  //     spyOn(jQuery, 'ajax').and.callFake(function (req) {
  //       var d = $.Deferred();
  //       d.reject({responseText: 'error happened'});
  //       return d.promise();
  //     });
  //     spyOn(AjaxCustomMethods, 'handleError');

  //     this.component.componentDidMount();

  //     expect(AjaxCustomMethods.handleError).toHaveBeenCalled();
  //     expect(this.component.state.messages).toEqual([]);
  //   });
  // });

  describe('handleSubmit', function(){
    let data = { content: 'msg3', channel_id: 0 };

    beforeEach(function() {
      this.component.state.messages = [{content: 'msg1', channel_id:0 }, {content: 'msg2', channel_id:0 }];
    });

    it('sends a new message', function(){
      this.component.handleSubmit(data);
      contents = []
      this.component.state.messages.map(function(m){ contents.push(m.content) })
      expect(contents).toEqual([ 'msg3', 'msg1', 'msg2']);
    });
  });
});