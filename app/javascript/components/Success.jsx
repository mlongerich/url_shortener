import React from 'react'

const Success = props => (
  <div>
    { props.short_url
      ? <div className="success notification is-info">Your short url is: {props.short_url} </div>
      : "" 
    }
  </div>
)

export default Success