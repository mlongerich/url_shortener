import React from 'react'

const Error = props => (
  <div className={ props.error && "error notification is-danger" }> {props.error} </div>
)

export default Error