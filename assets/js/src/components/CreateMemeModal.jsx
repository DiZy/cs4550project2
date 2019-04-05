import React, { Component, Fragment } from 'react';
import { connect } from 'react-redux';

import globalStrings from '../../strings';
import templateImages from '../../templates';
import {fetchGifs, uploadMeme} from '../../api';
import MemeViewer from './MemeViewer';

const mapStateToProps = state => Object.assign({}, state.createMemeForm, {position: state.position});

const mapDispatchToProps = (dispatch) => ({
    updateForm: (formData) => dispatch({type: 'UPDATE_CREATE_MEME_FORM', data: formData}),
    clearForm: () => dispatch({type: "CLEAR_CREATE_MEME_FORM"})
});

class CreateMemeModal extends React.Component {

    constructor(props) {
        super(props);
        this.updateField = this.updateField.bind(this);
        this.switchToCreate = this.switchToCreate.bind(this);
        this.switchToFind = this.switchToFind.bind(this);
        this.selectTemplateForCreate = this.selectTemplateForCreate.bind(this);
        this.submitMeme = this.submitMeme.bind(this);
        this.selectGif = this.selectGif.bind(this);
    }

    updateField(fieldName) {
        return (e) => {
            let data  = {};
            data[fieldName] = e.target.value;
            this.props.updateForm(data);
        };
    }

    selectTemplateForCreate(templateId) {
        return () => {
            this.props.updateForm({imageUrl: templateImages[templateId]});
        };
    }

    switchToCreate() {
        this.props.updateForm({isUserCreated: true, gifUrl: "", gifId: ""});
    }

    switchToFind() {
        this.props.updateForm({isUserCreated: false, imageUrl: "", textLineOne: "", textLineTwo: ""});

        if(this.props.gifsAvailable.length == 0) {
            fetch(fetchGifs())
            .then(resp => resp.json())
            .then(json => {
                this.props.updateForm({
                    gifsAvailable: json.data,
                });
            }).catch(err => {
                alert("Failed to fetch gifs. Please try again.");
                console.log(err);
            });
        }
    }

    selectGif() {
        return (gifId, gifUrl) => {
            this.props.updateForm({gifId: gifId, gifUrl: gifUrl});
        };
    }

    submitMeme() {
        fetch(uploadMeme({
            image_url: this.props.imageUrl,
            is_user_created: this.props.isUserCreated,
            gif_id: this.props.gifId,
            text_line_one: this.props.textLineOne,
            text_line_two: this.props.textLineTwo,
            lat: this.props.position.latitude,
            long: this.props.position.longitude,
        }))
        .then(resp => resp.json())
        .then(json => {
            this.props.clearForm();
        }).catch(err => {
            alert("Failed to upload meme. Please try again.");
            console.log(err);
        });
    }
    
    render() {
        const createTabClass = this.props.isUserCreated ? "tab active-tab" : "tab";
        const findTabClass = !this.props.isUserCreated ? "tab active-tab" : "tab";

        const tabHeader = <div className="tab-header">
            <div className={createTabClass} onClick={this.switchToCreate}>Create A Meme</div>
            <div className={findTabClass} onClick={this.switchToFind}>Find A Meme</div>
        </div>;

        const templates = Object.keys(templateImages).map((templateId) => {
            return (
                <div 
                    className="template-selector-template"
                    onClick={this.selectTemplateForCreate(templateId)}
                    key={templateId}>
                    <img src={templateImages[templateId]} />
                </div>);
        });

        const giphys = this.props.gifsAvailable.map(gif =>
            <img src={gif.embed_url} onClick={this.selectGif(gif.id, gif.embed_url)} />
        );


        return <div className="createMemeForm">
            {tabHeader}
            {this.props.isUserCreated &&
                <div>
                    Your Meme:
                    <MemeViewer
                        imageUrl={this.props.imageUrl}
                        textLineOne={this.props.textLineOne}
                        textLineTwo={this.props.textLineTwo} />

                    <p>Choose A Template:</p>
                    <div className="template-selector">
                        {templates}
                    </div>
                    <p>Add Text:</p>
                    <input 
                        type="text" 
                        value={this.props.textLineOne} 
                        placeholder="Text Line One"
                        onChange={this.updateField("textLineOne")} />
                    <br />
                    <input 
                        type="text" 
                        value={this.props.textLineTwo} 
                        placeholder="Text Line Two"
                        onChange={this.updateField("textLineTwo")} />
                    <br />
                    <button onClick={this.submitMeme}>Add Meme</button>
                </div>
            }
            {!this.props.isUserCreated && 
                <div>
                    {!this.props.gifId && <div>
                        <p>Choose a meme from Giphy</p>

                        <div className="giphy-memes">
                            {giphys}
                        </div>
                    </div>}

                    {this.props.gifId && <div>
                        <p>Selected Meme:</p>

                        <img src={this.props.gifUrl} />
                        
                        <p>Is this ok?</p>
                    </div>}
                </div>
            }
        </div>
    }
}


export default connect(mapStateToProps, mapDispatchToProps)(CreateMemeModal);
