import React from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import { login } from '../../api';
import globalStrings from '../../strings';
const strings = globalStrings.en.welcome;


const mapStateToProps = state => Object.assign({}, state.login);
const mapDispatchToProps = dispatch => ({
  updateField: (fieldName) => (e) => {
    let data = {};
    data[fieldName] = e.target.value;

    return dispatch({type: 'UPDATE_LOGIN_FORM', data})
  },
  login: (email, pass) => {
    fetch(login(email, pass))
      .then(res => res.json())
      .then(json => dispatch({
        type: 'SET_TOKEN',
        token: json
      })).catch(err => {
        alert("Could not log in. Please try again.");
        console.err(err);
      });
  }
});

const Login = ({updateField, login, password, email}) => (
  <div className="welcome">
    <div className="welcome__left">
      <div className="login__login">
        <p className="login__sign">Sign in</p>
        <p className="login__personal">with your personal email</p>
          <input value={email} onChange={updateField("email")} className="login__input" type="email" 
            name="email" placeholder="user@example.com" />
          <input value={password} onChange={updateField("password")} className="login__input" 
            type="password" name="password" placeholder="password" />
        <div className="login__butons">
          <Link to="/register" className="login__create">Create account</Link>
          <button onClick={() => login(email, password)} className="login__btn btn btn-primary">Next</button>
        </div>
      </div>
    </div>
    <div className="welcome__disclaimers">
      <hr />
      <p>{strings.disclaimer}</p>
      <p>{strings.developed}</p>
    </div>
    <img className="welcome__doggo" src="http://www.stickpng.com/assets/images/5845e608fb0b0755fa99d7e7.png" />    
  </div>
);

export default connect(mapStateToProps, mapDispatchToProps)(Login);
