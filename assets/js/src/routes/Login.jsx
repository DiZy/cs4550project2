import React from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import { login } from '../../api';

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
  <div className="login">
    <p className="login__copy">Use taskify for tracking your tasks! You can create tasks with titles,
     descriptions and assign them to friends! Mark them as complete and note down how much you've 
     worked on them! All of this for <span className="text-pop">FREE!</span>
    </p>
    <div className="login__login">
      <p className="login__sign">Sign in</p>
      <p className="login__personal">with your personal email</p>
        <input value={email} onChange={updateField("email")} className="login__input" type="email" 
          name="email" placeholder="user@example.com" />
        <input value={password} onChange={updateField("password")} className="login__input" 
          type="password" name="password" placeholder="password" />
        <button onClick={() => login(email, password)} className="login__btn btn btn-primary">Next</button>
      <Link to="/register" className="login__create">Create account</Link>
    </div>
  </div>
);

export default connect(mapStateToProps, mapDispatchToProps)(Login);
