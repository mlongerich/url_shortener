import React from 'react';
import { configure, mount, shallow } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';

configure({ adapter: new Adapter() });

import App from '../../app/javascript/packs/index'
import Header from '../../app/javascript/components/Header'
import Form from '../../app/javascript/components/Form'
import Error from '../../app/javascript/components/Error'
import Success from '../../app/javascript/components/Success'

describe('<App />', () => {
  it('renders without crashing', () => {
    shallow(<App />);
  });
  it('renders <Header /> components', () => {
    const wrapper = shallow(<App />);
    expect(wrapper.find(Header).length).toBe(1)
  });
  it('renders <Form /> components', () => {
    const wrapper = shallow(<App />);
    expect(wrapper.find(Form).length).toBe(1)
  });
  it('renders <Error /> components', () => {
    const wrapper = mount(<App><Error error="error" /></App>);
    expect(wrapper.find(Error).length).toBe(1)
  });
  it('renders <Success /> components', () => {
    const wrapper = mount(<App><Success success="success" /></App>);
    expect(wrapper.find(Success).length).toBe(1)
  });
  it('does not renders <Error /> components if no error', () => {
    const wrapper = shallow(<App />);
    expect(wrapper.find(Error).length).toBe(0)
  });
  it('does not renders <Success /> components if no success', () => {
    const wrapper = shallow(<App />);
    expect(wrapper.find(Success).length).toBe(0)
  });
});