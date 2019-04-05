import React, { Component, Fragment } from 'react';
class MemeViewer extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return (
            <div className="meme-viewer">
                <h1 className="text-line-one">{this.props.textLineOne}</h1>
                <img src={this.props.imageUrl || this.props.gifUrl} />
                <h1 className="text-line-two">{this.props.textLineTwo}</h1>
            </div>);
    }
}

export default MemeViewer;