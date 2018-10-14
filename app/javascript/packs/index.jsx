import React from 'react'
import ReactDOM from 'react-dom'
import Header from '../components/Header'
import Form from '../components/Form'

const App = props => (
  <div>
    <Header />
    <Form />
  </div>
)

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <App />,
    document.body.appendChild(document.createElement('div')),
  )
})