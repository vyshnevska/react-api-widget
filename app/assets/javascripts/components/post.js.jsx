var Post = React.createClass({
  getInitialState() {
    return ({ clicked: false })
  },

  _showMe(){
    var newState = {};
    newState['clicked'] = true;
    this.setState(newState);
  },

  render: function() {
    onOpen = <a onClick={this._showMe}>Show</a>;
    if(this.state.clicked){
      onOpen = <div>
        <h2> {this.props.post.body} </h2>
        <span> {this.props.post.published} </span>
      </div>
    }
    return (<div> {onOpen} </div>)
  }
});
