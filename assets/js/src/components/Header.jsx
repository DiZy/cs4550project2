import React, { Fragment } from 'react';
import { connect } from 'react-redux';
import { NavLink } from 'react-router-dom'

const mapStateToProps = ({ token }) => ({
  name: token && token.user_name
});

const mapDispatchToProps = dispatch => ({
  onLogOut: (e) => {
    dispatch({
      type: 'CLEAR_TOKEN'
    })
  }
});

const Header = ({name, onLogOut}) => (
  <header>
    <div className="app-header">
      <h1 className="app-header__title">Meme Mon Go!</h1>
        <div className="app-header__links">
          {name ? (
            <Fragment>
              <p>Welcome: { name } | </p>
              <NavLink to="/" activeClassName="app-header--active">Dashboard</NavLink>
              <a href="javascript:void(0)" onClick={onLogOut}>Log Out</a>
            </Fragment>
          ) : <p>Get organized without the effort</p>}
        </div>
    </div>
  </header>
);

export default connect(mapStateToProps, mapDispatchToProps)(Header);