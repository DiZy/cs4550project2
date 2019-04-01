import "phoenix_html"
import { Provider, connect } from 'react-redux';
import ReactDOM from 'react-dom';
import React from 'react';
import store from './store';
import MemeMonGoApp from "./src/app.jsx";

$(function() {
  ReactDOM.render(
    <Provider store={store}>
      <MemeMonGoApp state={store.getState()} />
    </Provider>,
    document.getElementById('root'),
  );
});
