import React, { Component, Fragment } from 'react';
import ReactDOM from 'react-dom';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import GoogleMapReact from 'google-map-react';
import Modal from 'react-modal';
import CreateMemeModal from "../components/CreateMemeModal";
import MemeViewer from "../components/MemeViewer";
import { getNearbyMemes, getMyMemes, collectMeme } from '../../api';

import globalStrings from '../../strings';
import store from '../../store';

const strings = globalStrings.en.welcome;
const mapStateToProps = state => Object.assign({memes: [...state.memes], userId: state.userId}, state.position, state.modals );

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
  }}),
  addMemes: (memes) => dispatch({
    type: 'ADD_MEMES',
    data: memes
  })
})

Modal.setAppElement('#root')

function isCollide(a, b) {
  var aRect = a.getBoundingClientRect();
  var bRect = b.getBoundingClientRect();

  return !(
      ((aRect.top + aRect.height) < (bRect.top)) ||
      (aRect.top > (bRect.top + bRect.height)) ||
      ((aRect.left + aRect.width) < bRect.left) ||
      (aRect.left > (bRect.left + bRect.width))
  );
}

const PlayerMarker = (props) => (
  <div
    lat={props.lat}
    lng={props.lng}
  >
    <svg className="player-memeBoundary" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
      <circle id="boundary" cx="50" cy="50" r="50"/>
    </svg>
    <img className="player-marker" src="https://i.pinimg.com/originals/f3/c7/3c/f3c73c8c0c0eaf908ed17cc2966c0777.png" />
  </div>
);

const mapMarkerToProps = (state) => Object.assign({}, {userId: state.userId});

class MemeMarkerClass extends Component {
  constructor() {
    super();
    this.state = {
      clicked: false,
      collected: false
    }
    this.myRef = React.createRef();
    this.handleClick = this.handleClick.bind(this);
  }

  componentDidUpdate(prevProps, prevState) {
    if (prevState.clicked == false && this.state.clicked == true) {
      console.log({
        is_user_created: this.props.is_user_created,
        user_id: this.props.userId,
        meme_id: this.props.meme_id,
        gif_id: this.props.gif_id
      });
      fetch(collectMeme({
        is_user_created: this.props.is_user_created,
        user_id: this.props.userId,
        meme_id: this.props.meme_id,
        gif_id: this.props.gif_id
      }))
     setTimeout(() => {
        //this.setState({collected: true})
        
      }, 1000)
    }
  }

  handleClick(e) {
    if (!this.state.clicked) {
      const node = ReactDOM.findDOMNode(this).firstElementChild;
      const boundary = document.querySelector('circle');

      if (isCollide(node, boundary)) {
        this.setState({clicked: true})
      }
    }
  }
  
  render() {
    return (
      <div
        lat={this.props.lat}
        lng={this.props.lng}
        onClick={this.handleClick}
      >
        <img className="meme-marker" src="https://image.flaticon.com/icons/svg/214/214305.svg" />
        {this.state.clicked && !this.state.collected ? (
          <MemeViewer 
            imageUrl={this.props.image_url}
            gifUrl={this.props.gif_url}
            textLineOne={this.props.text_line_one}
            textLineTwo={this.props.text_line_two} 
          />
        ) : null}
      </div>
    )
  }
}

const MemeMarker = connect(mapMarkerToProps)(MemeMarkerClass);

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
  
  getNearbyMemes() {
    fetch(getNearbyMemes())
      .then(res => res.json())
      .then(json => this.props.addMemes(json.memes))
      .catch(err => console.log(err));
    
    fetch(getMyMemes())
      .then(res => res.json())
      .then(json => console.log(json));
  }

  componentDidMount() {
    console.log(this.props.memes);

    this.getAndTrackLocation();
    this.getNearbyMemes();
  }

  renderLoadingScreen() {
    return (
      <div>
        IT'S LOADING BOOOYZ
      </div>
    )
  }

  renderMemeMarkers() {
    console.log(this.props.memes);

    return this.props.memes.map(meme => (
      <MemeMarker 
        lat={meme.lat} 
        lng={meme.long}
        image_url={meme.image_url}
        is_user_created={meme.is_user_created}
        text_line_one={meme.text_line_one}
        text_line_two={meme.text_line_two}
        gif_id={meme.gif_id}
        meme_id={meme.meme_id}
        url={meme.url}
      />
    ))
  }

  renderMap() {
    return (
      <Fragment>
        <Modal
          isOpen={this.props.createMemeModal}
          onAfterOpen={this.afterOpenModal}
          onRequestClose={this.closeModal}
          contentLabel="Create Modal">
          <CreateMemeModal closeModal={this.closeModal}/>
        </Modal>
        <Modal
          isOpen={this.props.profileModal}
          onAfterOpen={this.afterOpenModal}
          onRequestClose={this.closeModal}
          contentLabel="Profile Modal"
        ></Modal>
        <div style={{height: '100vh', width: '100%'}}>
          <GoogleMapReact
            bootstrapURLKeys={{ key: 'AIzaSyA1h6CsIIQJYIWHhWdwZLYSW0qCByzlTAs' }}
            center={{
              lat: this.props.latitude,
              lng: this.props.longitude
            }}
            options={mapOptions}
            defaultZoom={18}
          >
            <PlayerMarker lat={this.props.latitude} lng={this.props.longitude}/>
            {this.renderMemeMarkers()}
          </GoogleMapReact>
        </div>
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
