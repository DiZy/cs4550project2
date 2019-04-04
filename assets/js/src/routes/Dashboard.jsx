import React, { Component, Fragment } from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import GoogleMapReact from 'google-map-react';
import Modal from 'react-modal';

import globalStrings from '../../strings';

const strings = globalStrings.en.welcome;
const mapStateToProps = state => Object.assign({}, state.position, state.modals);

const mapOptions = {
  styles: [{"featureType":"all","elementType":"geometry","stylers":[{"color":"#c1fcb8"},{"weight":"1.00"}]},{"featureType":"all","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"all","elementType":"labels.text.fill","stylers":[{"gamma":0.01},{"lightness":20}]},{"featureType":"all","elementType":"labels.text.stroke","stylers":[{"saturation":-31},{"lightness":-33},{"weight":2},{"gamma":0.8}]},{"featureType":"all","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"administrative","elementType":"geometry","stylers":[{"hue":"#ff0000"},{"visibility":"off"}]},{"featureType":"administrative","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"landscape","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"poi","elementType":"all","stylers":[{"color":"#e0ffd3"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"saturation":20}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"lightness":20},{"saturation":-20}]},{"featureType":"poi.park","elementType":"geometry.fill","stylers":[{"visibility":"on"},{"color":"#41ff82"}]},{"featureType":"road","elementType":"all","stylers":[{"weight":"2.00"}]},{"featureType":"road","elementType":"geometry","stylers":[{"lightness":"-20"},{"saturation":"-67"},{"gamma":"1.32"},{"color":"#57aa9f"},{"weight":"2.00"},{"visibility":"simplified"}]},{"featureType":"road","elementType":"geometry.fill","stylers":[{"visibility":"on"},{"weight":"2.00"}]},{"featureType":"road","elementType":"geometry.stroke","stylers":[{"saturation":25},{"lightness":25},{"weight":"1.00"},{"color":"#f1ff8a"},{"visibility":"on"}]},{"featureType":"road","elementType":"labels","stylers":[{"weight":"2.12"},{"visibility":"off"}]},{"featureType":"road.highway","elementType":"geometry.fill","stylers":[{"visibility":"on"},{"color":"#4c98a8"}]},{"featureType":"road.highway","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"road.arterial","elementType":"geometry.fill","stylers":[{"color":"#4c98a8"},{"weight":"2.63"}]},{"featureType":"road.arterial","elementType":"geometry.stroke","stylers":[{"color":"#f1ff8a"}]},{"featureType":"transit","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"transit","elementType":"geometry","stylers":[{"visibility":"off"}]},{"featureType":"transit","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"transit.line","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"transit.station","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"water","elementType":"all","stylers":[{"lightness":-20},{"color":"#1b89d9"}]},{"featureType":"water","elementType":"geometry.fill","stylers":[{"color":"#1b87d9"}]},{"featureType":"water","elementType":"labels","stylers":[{"visibility":"off"}]}],
  gestureHandling: 'none',
  zoomControl: false,
  disableDefaultUI: true
};

const mapDispatchToProps = (dispatch) => ({
  updateLocation: (positionObject) => dispatch({type: 'UPDATE_POSITION', data: {
    latitude: positionObject.coords.latitude,
    longitude: positionObject.coords.longitude
  }})
})


Modal.setAppElement('#root')


const PlayerMarker = (props) => (
  <div
    lat={props.latitude}
    lng={props.longitude}
  >
    <img className="player-marker" src="https://i.pinimg.com/originals/f3/c7/3c/f3c73c8c0c0eaf908ed17cc2966c0777.png" />
  </div>
);

class Dashboard extends Component {
  getAndTrackLocation() {
    if (this.props.longitude) {
      this.isTracking = true;
      navigator.geolocation.watchPosition((position) => {
        this.props.updateLocation(position);
      });
    } else if (navigator.geolocation) {

      navigator.geolocation.getCurrentPosition((position) => {
        this.props.updateLocation(position);

        this.isTracking = true;
        navigator.geolocation.watchPosition((position) => {
          this.props.updateLocation(position);
        });
      });
    } else {
      alert("Geolocation is not supported by this browser. Unfortunately Mememon go can't work properly on your machine :(");
    }
  }

  componentDidMount() {
    this.getAndTrackLocation();
  }

  renderLoadingScreen() {
    return (
      <div>
        IT'S LOADING BOOOYZ
      </div>
    )
  }

  renderMap() {
    return (
      <Fragment>
        <Modal
          isOpen={this.props.createMemeModal}
          onAfterOpen={this.afterOpenModal}
          onRequestClose={this.closeModal}
          contentLabel="Create Modal"
        ></Modal>
        <Modal
          isOpen={this.props.profileModal}
          onAfterOpen={this.afterOpenModal}
          onRequestClose={this.closeModal}
          contentLabel="Profile Modal"
        ></Modal>
        <GoogleMapReact
          bootstrapURLKeys={{ key: 'AIzaSyA1h6CsIIQJYIWHhWdwZLYSW0qCByzlTAs' }}
          center={{
            lat: this.props.latitude,
            lng: this.props.longitude
          }}
          options={mapOptions}
          defaultZoom={18}
        >
        <PlayerMarker />
        </GoogleMapReact>
      </Fragment>
    )
  }

  render() {
    return (
      <div className="dashboard">
        {this.props.longitude ? this.renderMap() : this.renderLoadingScreen()}
    </div>
    )
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(Dashboard);
