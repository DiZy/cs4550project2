import React, { Component, Fragment } from 'react';
import { connect } from 'react-redux';
import { BrowserRouter as Router, Route } from 'react-router-dom';

import { Header, Menu } from './components/'
import { Login, Register, Welcome } from './routes/';

const mapStateToProps = state => ({
  token: state.token
})

class MemeMonGoApp extends Component {
  renderRegistrationRoutes() {
    return (
      <Fragment>
        <div className="welcome-splash">
          <div className="page-shell">
            <Route path="/" exact={true} render={() => <Welcome />} />
            <Route path="/login" exact={true} render={() => <Login />} />
            <Route path="/register" exact={true} render={() => <Register />} /> 
          </div>
        </div>
      </Fragment>
    )
  }

  renderRoutes() {
    return (
      <Fragment>
        <Route path="/" exact={true} render={() => <div> Hi </div>} />
      </Fragment>
    )
  }

  render() {
    const { token } = this.props;
    return (
      <Router>
        {token ? this.renderRoutes() : this.renderRegistrationRoutes()}
      </Router>
    )
  }
}

export default connect(mapStateToProps)(MemeMonGoApp)
