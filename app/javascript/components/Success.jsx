import React from 'react'

const Success = props => (
  <div className={ props.short_url && "success notification is-info has-text-centered" }>
    <p>{ props.short_url && "Your short url is:" }</p>
    <p>{ props.short_url }</p>
  </div>
)

export default Success