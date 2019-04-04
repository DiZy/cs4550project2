import React from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import GoogleMapReact from 'google-map-react';


import globalStrings from '../../strings';


const strings = globalStrings.en.welcome;

const mapStateToProps = state => Object.assign({}, state);
const style = {
  height: '80%'
};

const DashBoard = (props) => (
  <div className="dashboard">
      <GoogleMapReact
          bootstrapURLKeys={{ key: 'AIzaSyA1h6CsIIQJYIWHhWdwZLYSW0qCByzlTAs' }}
          defaultCenter={{
            lat: 42.360082,
            lng: -71.058880
          }}
          defaultZoom={19}
        ></GoogleMapReact>
  </div>
);


export default connect(mapStateToProps)(DashBoard);
