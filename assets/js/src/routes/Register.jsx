import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Link, withRouter } from 'react-router-dom';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import { Row, Col } from 'reactstrap';
import { register } from '../../api';
import globalStrings from '../../strings';
const strings = globalStrings.en.welcome;

const mapStateToProps = state => Object.assign({}, state.register)

const mapDispatchToProps = (dispatch, { history }) => ({
  updateField: (fieldName) => (e) => {
    let data = {};
    data[fieldName] = e.target.value;

    return dispatch({type: 'UPDATE_FORM', data})
  },
  register: (email, name, password) => {
    fetch(register(email, name, password))
      .then(resp => resp.json())
      .then(json => {
        alert("Successfully registered! You can now log in.");
        dispatch({
          type: 'ADD_USER',
          user: json.data,
        });
        history.push('/');
      }).catch(err => {
        alert("Failed to register. Please try again.");
        console.err(err);
      })
  }
})

const Register = ({updateField, register, name, password, email}) => (
  <div className="welcome">
    <div className="welcome__left">
      <div className="login__login">
        <p className="login__sign">Create your account</p>
        <p className="login__personal">with your personal email and name</p>
          <input value={email} onChange={updateField("email")} className="login__input" type="email" 
            name="email" placeholder="Email" />
          <input value={name} onChange={updateField("name")} className="login__input" type="text" 
            name="name" placeholder="Name" />
          <input value={password} onChange={updateField("password")} className="login__input" 
            type="password" name="password" placeholder="Password (at least 8 characters)" />
         <div className="login__butons">
          <Link to="/" className="login__create">Back</Link>
          <button onClick={() => register(email, name, password)} className="login__btn btn btn-primary">Register</button>
         </div>
      </div>
    </div>
    <div className="welcome__disclaimers">
      <hr />
      <p>{strings.disclaimer}</p>
      <p>{strings.developed}</p>
    </div>
    <img className="welcome__yao" src="http://pluspng.com/img-png/yao-ming-face-png-download-yao-ming-face-png-images-transparent-gallery-advertisement-advertisement-2321.png" />    
  </div>
);

export default withRouter(connect(mapStateToProps, mapDispatchToProps)(Register));
