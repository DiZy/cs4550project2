import React, { Component, Fragment } from 'react';
import { connect } from 'react-redux';

import globalStrings from '../../strings';
import MemeViewer from './MemeViewer';

const mapStateToProps = state => Object.assign({}, {myMemes: state.myMemes});

const mapDispatchToProps = (dispatch) => ({
    closeModal: () => dispatch({type: "UPDATE_MODAL_STATE", data: {profileModal: false}})
});

class CollectedMemesModal extends React.Component {

    constructor(props) {
        super(props);
    }
    
    render() {
        const memes = this.props.myMemes.map((meme) => {
            return (<div className="collected-meme-form-entry">
                <MemeViewer 
                    gifUrl={meme.gif_url}
                    imageUrl={meme.image_url}
                    textLineOne={meme.text_line_one}
                    textLineTwo={meme.text_line_two} />
            </div>);
        })
    
        return <div className="collected-meme-form">
            <div className="modalCloseButton" onClick={this.props.closeModal}>X</div>
            <p className="collected-meme-form-title">Collected Memes</p>
            <div className="collected-meme-form-meme-container">
                {memes}
            </div>
        </div>;
    }
}


export default connect(mapStateToProps, mapDispatchToProps)(CollectedMemesModal);
