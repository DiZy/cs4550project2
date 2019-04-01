import React from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import { login } from '../../api';
import globalStrings from '../../strings';


const strings = globalStrings.en.welcome;

const mapStateToProps = state => Object.assign({}, state);

const Welcome = ({updateField, login, password, email}) => (
  <div className="welcome">
    <div className="welcome__left">
      <div className="welcome__app">
        <img className="welcome__appimg" src="https://static-s.aa-cdn.net/img/gp/20600010847786/KNHHhCLeSzLGP8IfoPzpWRH3tGoHYJEHLjOOGKjy7fhHW5WdpEBycrqlu259l4X3nQ=s300?v=1" />
        <div className="welcome__ios">
          <img className="welcome__apple-logo" src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/Apple_logo_white.svg/1024px-Apple_logo_white.svg.png"/>
          <div className="welcome__on-appstore">
            <p className="welcome__apptext">{strings.apptext}</p>
            <p className="welcome__appstore">App Store</p>
          </div>
        </div>
      </div>
      <p className="welcome__header">{strings.header}</p>
      <p className="welcome__support">{strings.support}</p>
      <div className="welcome__links">
        <a className="welcome__login" href="#">
          <img className="welcome__login-meme" src="https://cdn3.iconfinder.com/data/icons/popular-memes/48/JD-02-512.png" />
          {strings.login}
        </a>
        <a className="welcome__register" href="#">{strings.register}</a>
      </div>
    </div>
    <div className="welcome__disclaimers">
      <hr />
      <p>{strings.disclaimer}</p>
      <p>{strings.developed}</p>
    </div>
    <img className="welcome__right" src="https://www.pngkey.com/png/full/444-4442142_politically-incorrect-thread-pepe-the-frog-meme.png" />    
  </div>
);

export default connect(mapStateToProps)(Welcome);
