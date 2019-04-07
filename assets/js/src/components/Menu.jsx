import React from 'react';
import { connect } from 'react-redux';
import globalStrings from '../../strings';

const strings = globalStrings.en.menu;

const mapStateToProps = state => Object.assign({}, state.modals);

const mapDispatchToProps = dispatch => ({
  openMemeModal: e => dispatch({type: 'UPDATE_MODAL_STATE', data: {createMemeModal: true}}),
  openProfileModal: e => dispatch({type: 'UPDATE_MODAL_STATE', data: {profileModal: true}}),
  onLogOut: e => {console.log('cucu'); dispatch({type: 'CLEAR_TOKEN'})}
});

const Menu = ({onLogOut, openMemeModal, openProfileModal}) => (
  <nav className="menu">
    <div className="menu__profile" onClick={openProfileModal}>
      <img className="menu__profile-img" src="http://www.stickpng.com/assets/images/5845ca7c1046ab543d25238b.png"/>
    </div>
    <div className="menu__create-meme" onClick={openMemeModal}>
      <img className="menu__create-img" src="https://image.flaticon.com/icons/svg/60/60785.svg"/>
      {strings.place}
    </div>
    <div className="menu__logout" onClick={onLogOut}>
      <img className="menu__logout-img" src="https://image.flaticon.com/icons/svg/149/149409.svg"/>
      {strings.logout}
    </div>
    <div className="menu__dankness">
      <marquee>This app is developed by Cristi Dragomir & David Zilburg</marquee>
    </div>
  </nav>
);

export default connect(mapStateToProps, mapDispatchToProps)(Menu);