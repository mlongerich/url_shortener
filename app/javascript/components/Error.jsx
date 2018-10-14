import React from 'react'

const Error = props => (
  <div>
    { props.error
      ? <div className="error notification is-danger"> {props.error} </div>
      : ""
    }
  </div>
)

export default Error