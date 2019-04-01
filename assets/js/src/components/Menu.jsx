import React from 'react';
import globalStrings from '../../strings';

const strings = globalStrings.en.menu;

const Menu = (props) => (
  <nav className="menu">
    <ul className="menu__content">
      <li>
        <img className="menu__entry-img" src="https://ichef.bbci.co.uk/news/660/cpsprodpb/16620/production/_91408619_55df76d5-2245-41c1-8031-07a4da3f313f.jpg"/>
        <p className="menu__entry-text">{strings.profile}</p>
      </li>
      <li className="menu__cta">{strings.place}</li>
      <li>{strings.logout}</li>
    </ul>
  </nav>
);

export default Menu;