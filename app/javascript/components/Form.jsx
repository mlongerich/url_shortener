import React from 'react'
import Success from './Success'
import Error from './Error'

class Form extends React.Component {
  constructor(props) {
    super(props);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.state = {data: ""}
  }

  handleSubmit(event) {
    event.preventDefault();
    const that = this
    const data = new FormData(event.target);

    fetch('/add', {
      method: 'POST',
      body: data
    })
    .then(response => { return response.json();})
    .then(responseData => { return responseData;})
    .then(data => {that.setState({ data: {data} });
    console.log(that.state.data)
    console.log(that.state.data.data.error)
    console.log(that.state.data.data.short_url)
  })
  } 
  
  render() {
    return (
      <div className="container body">
        <Error error={this.state.data.data && this.state.data.data.error } />
        <form onSubmit={this.handleSubmit} className="" noValidate>
          <div className="field">
            <label className="label" htmlFor="url">Enter URL to be shortened</label>
            <div className="control">
              <input id="url" name="url" className="input" type="text" placeholder="http://example.com" required/>
            </div>
          </div>
          <div className="field">
            <div className="control">
              <button className="button is-link is-success">Submit</button>
            </div>
          </div>
        </form>
        <Success short_url={this.state.data.data && this.state.data.data.short_url } />
      </div>
    );
  }
}

export default Form